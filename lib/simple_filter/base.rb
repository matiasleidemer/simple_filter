module SimpleFilter
  class Base
    extend Filter

    attr_reader :params, :scope

    def initialize(params = {}, scope = nil)
      @params = params
      @scope = scope
    end

    def scoping(scope)
      @scope = scope

      self
    end

    def search
      conditions.scope
    end

    private

    def conditions
      self.class.filters.each do |filter|
        @scope.merge! send(filter) || @scope.where(nil)
      end

      self
    end
  end
end
