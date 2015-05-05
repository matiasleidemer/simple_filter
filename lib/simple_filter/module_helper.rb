module SimpleFilter
  module ModuleHelper
    module_function def module_for(prefix, name, klass)
      mod_name = ModuleName.new(prefix, name)

      begin
        mod = klass.send(:const_get, mod_name)
      rescue NameError
        mod = Module.new
        klass.send(:const_set, mod_name, mod)
        klass.send(:include, mod)
      end

      mod
    end

    class ModuleName
      def initialize(prefix, name)
        @prefix = prefix
        @name = name
      end

      def to_s
        @prefix + @name.to_s.split('_').map(&:capitalize).join
      end
      alias to_str to_s
    end
  end
end
