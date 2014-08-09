class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :build_resource_class
  before_filter :build_resource_param_name
  before_filter :build_resource_instance, :only => [:edit, :update, :destroy]
  before_filter :authorize_person
  before_filter :authenticate

  def current_user
    session[:user_id].present? ? User.find(session[:user_id]) : nil
  end

  #########
  protected
  #########

  def authenticate
    unless session[:user_id]
      session[:return_to] = request.fullpath
      redirect_to login_path, :notice => "Please Login"
    else
      @current_person = User.find(session[:user_id])
    end
  end

  def authorize_person
    if @resource_class.present?
      authorize! params[:action].to_sym, @resource_class
    end

    # NOTE: substitutes "folder/controller" for "controller" to avoid illegal instance names.
    # Before: resource_instance = instance_variable_get("@#{@resource_param_name}")
    @resource_param_name.gsub!(/\w+\//, '') unless @resource_param_name.nil?
    resource_instance = instance_variable_get("@#{@resource_param_name}")

    if resource_instance.present?
      authorize! params[:action].to_sym, resource_instance
    end
  end

  rescue_from CanCan::AccessDenied do |exception|
    session[:back] = request.referer
    flash.now[:alert] = "You are not authorized to access this page."
    render 'public/401', :status => :unauthorized
  end

  def build_resource_class
    @resource_class = "#{(self.class.to_s.gsub /Controller/, '').singularize}".constantize
  end

  def build_resource_param_name
    @resource_param_name = self.class.to_s.gsub(/Controller/, '').singularize.underscore
  end

  def build_resource_instance
    instance_variable_set("@#{@resource_param_name.gsub(/\w+\//, '')}", @resource_class.find(params[:id]))
  end

end