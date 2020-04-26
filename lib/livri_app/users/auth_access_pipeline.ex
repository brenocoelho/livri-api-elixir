defmodule LivriApp.Users.AuthAccessPipeline do
    use Guardian.Plug.Pipeline, otp_app: :livri_app,
        module: LivriApp.Users.Guardian,
        error_handler: LivriApp.Users.AuthErrorHandler
  
    # If there is an authorization header, restrict it to an access token and validate it
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
 
    plug Guardian.Plug.EnsureAuthenticated
 
    # Load the user
    plug Guardian.Plug.LoadResource

end