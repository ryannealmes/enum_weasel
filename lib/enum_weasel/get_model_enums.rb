module EnumWeasel
  class GetModelEnums
    attr_reader :prefix

    def initialize prefix
      @prefix = prefix
    end

    def call
      preload_active_record_models

      active_record_models.each do |model|
        get_model_enums model if has_enum? model
      end

      model_enums
    end

    def preload_active_record_models
      Rails.application.eager_load! # might be able to remove this
    end

    def active_record_models
      ActiveRecord::Base.send(:subclasses).map{ |m| m.name.constantize }
    end

    def get_model_enums model
      model.defined_enums.each do |key, value|
        model_enums[enum_table_name(model, key)] = value
      end

      model_enums
    end

    def has_enum? model
      !model.defined_enums.empty?
    end

    def model_enums
      @model_enums ||= {}

    def enum_table_name model, enum
      "#{prefix}_#{model.to_s.underscore.pluralize}_#{enum}"
    end
  end
end
