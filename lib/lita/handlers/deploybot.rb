module Lita
  module Handlers
    class Deploybot < Handler
      options = {
        command: true,
        restrict_to: :deployers,
        help: { "deploy RAILS_ENV": "Deploy to Heroku with Deploybot." }
      }
      route(/^deploy\s+production/, :deploy, options)

      def deploy(response)
        response.reply("のっ!\n`production` にデプロイします...")
      end
    end
  end
end
