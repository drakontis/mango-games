class Privilege

  attr_accessor :model
  attr_accessor :action

  def initialize(attributes={})
    attributes = attributes.with_indifferent_access
    @model = attributes[:model]
    @action = attributes[:action]
    @model_label =  Ability.model_label(@model),
        @privilege_label = privilege_label
  end

  def self.all
    result = []
    Ability::MODELS.sort.each do |model_element|
      model_element[1][:actions].sort.each do |action|
        privilege = Privilege.new(:model => model_element[0], :action => action)
        result << privilege
      end
    end
    result
  end

  # overrides the Queryable fetch
  def self.fetch(options={})
    all
  end

  def id
    "#{model}/#{action}"
  end

  def self.count
    all.count
  end

  def privilege_label
    "#{model_label} / #{action}"
  end

  def model_label
    Ability.model_label(@model)
  end

  def privilege_label=(value)
    pl = value
    pl = pl.split('/')
    self.model_label = pl[0].strip
    @action = pl[1].strip
  end

  def model_label=(value)
    @model = Ability.model(value)
  end
end
