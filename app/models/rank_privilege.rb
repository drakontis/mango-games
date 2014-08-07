class RankPrivilege < ActiveRecord::Base
  attr_accessible :rank_id,
                  :model,
                  :action,
                  :model_label

  belongs_to :rank, :class_name => 'Rank', :inverse_of => :rank_privileges

  validates :model,   :presence => true, :length => {:maximum => 64}, :if => 'self.model_label.blank?'
  validate  :model_from_list

  validates :action, :presence => true, :length => {:maximum => 32}, :uniqueness => {:scope => [:rank_id, :model]}
  validate  :action_from_list

  def model_label
    return @model_label = Ability.model_label(model) unless @model_label.present?
    @model_label
  end

  def model_label=(value)
    @model_label = value
    self.model = Ability.model(value)
  end

  #########
  protected
  #########

  def model_from_list
    errors[:model] << 'is unknown' unless Ability.available_model? model
  end

  def action_from_list
    errors[:action] << 'not valid on this model' unless Ability.action_available_to_model? action, model
  end
end

