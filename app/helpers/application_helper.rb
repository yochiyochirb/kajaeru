module ApplicationHelper
  def bootstrap_alert_class(flash_type)
    {alert: 'alert-danger', notice: 'alert-info'}.fetch(flash_type.to_sym, '')
  end
end
