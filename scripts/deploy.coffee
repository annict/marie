# Description:
#   デプロイコマンド

needle = require("needle")

ENDPOINT = "https://annict.deploybot.com/api/v1"

class Client
  constructor: (token) ->
    @token = token

  deploy: ->
    data =
      environment_id: 37417
    options =
      headers:
        "X-Api-Token": process.env["DEPLOYBOT_API_TOKEN"]
    needle.post "#{ENDPOINT}/deployments", data, options, (err, response) ->
      console.log 'response: ', response

  environments: ->
    options =
      url: "#{ENDPOINT}/environments"
      headers:
        "X-Api-Token": @token
    request options, (error, response, body) ->
      console.log 'error: ', error
      console.log 'response: ', response
      console.log 'body: ', body


module.exports = (robot) ->
  console.log("api_token: ", process.env["DEPLOYBOT_API_TOKEN"])
  robot.respond /deploy\s+production/, (res) ->
    res.reply("のっ！")
    client = new Client(process.env["DEPLOYBOT_API_TOKEN"])
    client.deploy()
