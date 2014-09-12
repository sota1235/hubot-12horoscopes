assert = require 'assert'
path = require 'path'
hubot_script = require path.resolve '.', 'scripts', 'hubot-12horoscopes.coffee'

describe 'Hubot script', ->
  before (done) ->
    console.log '[describe] before test'
    done()

  after (done) ->
    console.log '[describe] after test'
    done()

  describe 'parseDate', ->
    it 'M月D日 -> MM, DD', (done) ->
      tests =
        '1月1日': [1, 1]
        '12月10日': [12, 10]
        '01月01日': [1, 1]
      for key, val in tests
        assert.equal key, hubot_script.parseDate key
      done()
