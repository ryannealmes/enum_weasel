module EnumWeasel
  class GetAllModelEnums
    attr_reader :model_enums

    def initialize
      @model_enums = {}
    end

    def call
      all_models.each do |model|
        model_enums[model.name.downcase] = get_model_enums(model)
      end
      model_enums
    end

    private

    def all_models
      ::ActiveRecord::Base.send(:subclasses).select{ |m| m.defined_enums.any? }
    end

    def get_model_enums model
      model.defined_enums.map{ |key, value| key }
    end
  end
end
