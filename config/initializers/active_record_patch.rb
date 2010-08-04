module ActiveRecord
    class Base
      def attributes=(new_attributes, guard_protected_attributes = true)
        return if new_attributes.nil?
        attributes = new_attributes.dup
        attributes.stringify_keys!

        multi_parameter_attributes = []
        attributes = sanitize_for_mass_assignment(attributes) if guard_protected_attributes

        attributes.each do |k, v|
          if k.include?("(")
            multi_parameter_attributes << [ k, v ]
          else
            send(:"#{k}=", v)
          end
        end

        assign_multiparameter_attributes(multi_parameter_attributes)
      end
    end
end
