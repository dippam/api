module Sunspot
  module Rails
    module Adapters
      class ActiveRecordInstanceAdapter < Sunspot::Adapters::InstanceAdapter
        def id
          @instance.id
        end
      end

      class ActiveRecordDataAccessor < Sunspot::Adapters::DataAccessor
        attr_accessor :include, :select

        def select=(value)
          value = value.join(', ') if value.respond_to?(:join)
          @select = value
        end
        
        def load(id)
          @clazz.first(options_for_find.merge(conditions: { @clazz.primary_key => id }))
        end
        
        def load_all(ids)
          @clazz.all(options_for_find.merge(conditions: { @clazz.primary_key => ids.map { |id| id }} ))
        end
        
        private
        
        def options_for_find
          options = {}
          options[:include] = @include unless @include.blank?
          options[:select]  = @select unless @select.blank?
          options
        end
      end
    end
  end
end
