module SimpleFilter
  module Filter
    attr_accessor :filters

    def filter(name, options = {})
      method_module = ModuleHelper.module_for 'Filter', name, self
      value_param = options.fetch :value_param, false
      by_pass = options.fetch :by_pass, false

      method_module.module_eval <<-CODE, __FILE__, __LINE__ + 1
        def #{name}
          return if params[:#{name}].to_s.blank? && !#{by_pass}

          args = [:#{name}]
          args << params[:#{name}] if #{value_param}

          scope.send *args
        end
      CODE

      add_filter name
    end

    private

    def add_filter(name)
      @filters ||= []
      @filters << name
    end
  end
end
