class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :prepare_exception_notifier

  include Response

  unless Rails.env.development?
    include ExceptionLogger::ExceptionLoggable # loades the module
    rescue_from Exception do |e|
      log_exception_handler(e)# tells rails to forward the 'Exception' (you can change the type) to the handler of the module
    end
  end

  def authorize_request
    if request.format == "application/json"
      if request.headers['Authorization'].present?
        auth = request.headers['Authorization']
        if auth.eql?(Rails.application.credentials.orakulo_auth_token)
          @user ||= User.find(908)
        else
          authenticate_user!
        end
      else
        authenticate_user!
      end
    else
      authenticate_user!
    end
  end

  def after_sign_in_path_for(_resource)
    '/dashboard'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def not_active_user
    '/users/sign_in'
  end

  def is_defined_param?(param)
    !params[param].nil? && !params[param].empty?
  end

  protected

  def verify_root_access!
    unless current_user.root?
      redirect_to '/dashboard', notice: 'Você não tem permissão para executar esta ação.'
    end
  end

  def json_pagination(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    }
  end

  private

  def prepare_exception_notifier
    request.env["exception_notifier.exception_data"] = {
      :USUARIO => current_user.inspect,
      :PARAMS => request.params.inspect
    }
  end

  def user_not_authorized
    flash[:notice] = 'Você não tem permissão para executar esta ação'
    redirect_to(request.referrer || '/dashboard')
  end
end
