require 'progressive_load/rails/path_resolver'

describe ProgressiveLoad::Rails::PathResolver do
	describe "with an empty template context" do
		it "throws when resolving paths" do
			pr = ProgressiveLoad::Rails::PathResolver.new(nil)
			expect { pr.path_for }.to raise_error(ProgressiveLoad::Rails::PathResolver::InvalidTemplateContextException) 
		end
	end

	describe "with a controller context" do
		let(:tc) { ProgressiveLoad::Rails::PathResolver::TemplateContext.new }
		before do
			tc.type = :controller
			tc.controller = 'Foo'
			tc.action = 'index'
		end
		let(:pr) { ProgressiveLoad::Rails::PathResolver.new(tc) }
		it "resolves the default view" do
			expect(pr.path_for).to eq("foo/index")
		end
		it "resolves a view within the controller" do
			expect(pr.path_for('action')).to eq("foo/action")
		end
	end


	describe "with a view context" do
		let(:tc) { ProgressiveLoad::Rails::PathResolver::TemplateContext.new }
		before do
			tc.type = :view
			tc.controller = 'Foo'
			tc.action = 'index'
		end
		let(:pr) { ProgressiveLoad::Rails::PathResolver.new(tc) }
		it "does not allow default view" do
			expect { pr.path_for }.to raise_error(ProgressiveLoad::Rails::PathResolver::InvalidPathException)
		end
		it "resolves a partial within the view" do
			expect(pr.path_for('partial')).to eq("foo/partial")
		end
	end
end