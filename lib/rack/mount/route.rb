module Rack
  module Mount
    # Route is an internal class used to wrap a single route attributes.
    #
    # Plugins should not depend on any method on this class or instantiate
    # new Route objects. Instead use the factory method, RouteSet#add_route
    # to create new routes and add them to the set.
    class Route
      extend Mixover

      # Include generation and recognition concerns
      include Generation::Route, Recognition::Route

      #--
      # TODO: Support any method on Request object
      #++
      VALID_CONDITIONS = [:method, :path].freeze

      # Valid rack application to call if conditions are met
      attr_reader :app

      # A hash of conditions to match against. Conditions may be expressed
      # as strings or regexps to match against. Currently, <tt>:method</tt>
      # and <tt>:path</tt> are the only valid conditions.
      attr_reader :conditions

      # A hash of values that always gets merged into the parameters hash
      attr_reader :defaults

      # Symbol identifier for the route used with named route generations
      attr_reader :name

      # Path condition
      attr_reader :path

      # Method condition
      attr_reader :method

      def initialize(app, conditions, defaults, name)
        @app = app
        validate_app!

        @name = name.to_sym if name
        @defaults = (defaults || {}).freeze

        @conditions = conditions
        validate_conditions!

        method = @conditions.delete(:method)
        @method = method.to_s.upcase if method

        path = @conditions.delete(:path)
        if path.is_a?(Regexp)
          @path = RegexpWithNamedGroups.new(path)
        elsif path.is_a?(String)
          path = Utils.normalize(path)
          @path = RegexpWithNamedGroups.compile("^#{path}$")
        end
        @path.freeze if @path

        @conditions.freeze
      end

      private
        def validate_app!
          unless @app.respond_to?(:call)
            raise ArgumentError, 'app must be a valid rack application' \
              ' and respond to call'
          end
        end

        def validate_conditions!
          unless @conditions.is_a?(Hash)
            raise ArgumentError, 'conditions must be a Hash'
          end

          unless @conditions.keys.all? { |k| VALID_CONDITIONS.include?(k) }
            raise ArgumentError, 'conditions may only include ' +
              VALID_CONDITIONS.inspect
          end
        end
    end
  end
end
