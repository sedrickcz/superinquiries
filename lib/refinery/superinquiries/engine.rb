module Refinery
  module Superinquiries
    class Engine < Rails::Engine
      include Refinery::Engine
      isolate_namespace Refinery::Superinquiries

      engine_name :refinery_superinquiries

      initializer "register refinerycms_superinquiries plugin" do
        Refinery::Plugin.register do |plugin|
          plugin.name = "superinquiries"
          plugin.url = proc { Refinery::Core::Engine.routes.url_helpers.superinquiries_admin_superinquiries_path }
          plugin.pathname = root
          plugin.activity = {
            :class_name => :'refinery/superinquiries/superinquiry'
          }
          
        end
      end

      config.after_initialize do
        Refinery.register_extension(Refinery::Superinquiries)
      end
    end
  end
end
