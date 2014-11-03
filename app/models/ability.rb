class Ability
  include CanCan::Ability

  DEFAULT_ACTIONS = [ :manage, :read, :update, :create, :destroy, :count, :index ]
  MODELS = {
      "all" =>                                   {:actions => DEFAULT_ACTIONS,
                                                  :label => 'all'},

      "Category" => {:actions => DEFAULT_ACTIONS},
      "Comment"  => {:actions => DEFAULT_ACTIONS},
      "Game"     => {:actions => DEFAULT_ACTIONS},
      "Image"    => {:actions => DEFAULT_ACTIONS},
      "Rank"     => {:actions => DEFAULT_ACTIONS},
      "User"     => {:actions => DEFAULT_ACTIONS}
  }

  def self.available_model?(model)
    model = model.to_s
    Ability::MODELS.keys.include? model
  end

  # Checks if the given +action+ is available for assignment on the given +model+.
  def self.action_available_to_model?(action, model)
    return false unless action.present? && model.present?
    action, model = action.to_sym, model.to_s
    Ability::MODELS.has_key?(model) and Ability::MODELS[model][:actions].include? action
  end

  def self.model_label(model)
    key = nil
    key = model.to_s if Ability::MODELS[model.to_s].present?
    return '' unless key.present?
    if Ability::MODELS[key].keys.include? :label
      Ability::MODELS[key][:label]
    else
      key
    end
  end

  def self.model(model_label)
    # find the model with the given model_label
    model = Ability::MODELS.select{|k,v| v.key?(:label) && v[:label] == model_label}.first
    if model.nil?
      model_label
    else
      model[0] # this one returns the key of the MODEL
    end
  end

  # Define abilities for the passed in user here. For example:
  #
  #   user ||= User.new # guest user (not logged in)
  #   if user.admin?
  #     can :manage, :all
  #   else
  #     can :read, :all
  #   end
  #
  # some useful notes about CanCan:
  #
  # Usual actions:
  #
  #  :read, :create, :update, :destroy
  #
  #  correspond to:
  #
  #    :read    => :index,  :show
  #    :create  => :new,    :create
  #    :update  => :edit,   :update
  #    :destroy => :destroy
  #
  #  :manage is used to represent any action
  #  :all is used to represent any object
  #
  #  @param [Integer] user_id id of the user to check ability for. Note that cancan, in their documentation
  #  says that {Ability::initialize} will take as input whatever {current_user} is going to return.
  #
  def initialize(user_id=nil)
    if Rails.env.test? && user_id.nil?
      return can :manage, :all
    end
    return define_public_abilities if user_id.nil?
    user = User.find(user_id)
    if user.root?
      define_root_abilities
    else
      define_user_abilities(user)
    end
  end

  protected

  def define_public_abilities
  end

  def define_root_abilities
    can :manage, :all
  end

  def define_user_abilities(user)

    user.rank.rank_privileges.each do |rp|
      if self.class.action_available_to_model?(rp.action, rp.model)
        can rp.action.to_sym, rp.model == 'all' ? :all : rp.model.constantize
      end
    end

    can :read, Game
    can [:read, :edit, :update], User, :id => user.id
  end
end
