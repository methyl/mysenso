# -*- encoding : utf-8 -*-
module ApplicationHelper
  def asset_path
    Rails::Application.config.action_controller.asset_host
  end
end
