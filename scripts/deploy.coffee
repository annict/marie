# Description:
#   デプロイコマンド

request = require("request")

DEPLOYBOT_API_TOKEN = process.env["DEPLOYBOT_API_TOKEN"]

class Client
  ENDPOINT = "https://annict.deploybot.com"
  API_ENDPOINT = "#{ENDPOINT}/api/v1"
  ENVIRONMENT_ID = process.env["DEPLOYBOT_ENVIRONMENT_ID"]

  constructor: (token) ->
    @token = token

  request: (method, path, headers, body, callback) ->
    options =
      url: API_ENDPOINT
      headers:
        "X-Api-Token": @token
    options.method = method
    options.url += path
    options.json = body

    request options, callback

  post: (path, options, callback) ->
    @request "POST", path, options.headers, options.body, callback

  deploy: (callback) ->
    @post "/deployments",
      body:
        environment_id: ENVIRONMENT_ID
    , (error, response, body) ->
      return callback error if error

      repositoryId = body.repository_id
      deploymentId = body.id
      url = "#{ENDPOINT}/#{repositoryId}/deployments/#{deploymentId}"

      callback null,
        url: url

module.exports = (robot) ->
  robot.respond /deploy\s+production/, (res) ->
    res.send("のっ！")
    client = new Client(DEPLOYBOT_API_TOKEN)
    client.deploy (error, data) ->
      return console.error error if error
      res.send("つ #{data.url}")
