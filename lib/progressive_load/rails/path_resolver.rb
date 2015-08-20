module ProgressiveLoad
	module Rails
		class PathResolver
			class TemplateContext
				attr_accessor :controller, :action, :type

				def valid?
					return false if type != :view && type != :controller
					return false if controller.nil? or controller.empty?
					return false if action.nil? or action.empty?
					true
				end
			end

			class InvalidTemplateContextException < Exception
			end

			class InvalidPathException < Exception
			end

			def initialize(_template_context)
				@context = _template_context
			end

			def path_for(view_name=nil)
				raise InvalidTemplateContextException.new unless @context && @context.valid?
				raise InvalidPathException.new if (view_name.nil? or view_name.empty?) and view_action?

				path = "#{@context.controller.downcase}/"

				if view_name == nil || view_name.empty?
					path += "#{@context.action}"
				else
					path += "#{view_name}"
				end
			end

			private
			def view_action?
				@context.type == :view
			end
		end
	end
end