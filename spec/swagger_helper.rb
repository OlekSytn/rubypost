require 'rails_helper'
RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'Blog app API V1',
        description: 'This is a sample server Blog app.',
        version: 'v1'
      },
      paths: {},
      servers: [{
        url: 'http://localhost:3000',
        variables: {
          defaultHost: { default: 'localhost:3000' }
        }
      }],
      components: {
        securitySchemes: {
          ApiKeyAuth: {
            type: 'apiKey',
            in: 'header',
            name: 'Authorization'
          }
        }
      }
    }
  }
  config.swagger_format = :yaml
end
