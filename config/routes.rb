# frozen_string_literal: true

Rails.application.routes.draw do
  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
  resources :partners
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
