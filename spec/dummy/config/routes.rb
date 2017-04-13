Rails.application.routes.draw do
  root 'load_test#index'

  scope '/load_test' do
    %w[block multiple_blocks custom_placeholder example render_params
       deprecated_explicit_call deprecated_explicit_call_with_template
       atom_repro].each do |endpoint|
      get endpoint => "load_test##{endpoint}", as: "load_test_#{endpoint}"
    end
  end
end
