Rails.application.routes.draw do
  root to: redirect("/homepage")
  get "/homepage", to: "homepage#homepage"
end
