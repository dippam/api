Dippam::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.eager_load = false
  config.consider_all_requests_local = true
  config.action_controller.perform_caching = false
  config.active_support.deprecation = :log
  config.action_dispatch.best_standards_support = :builtin
end
