assert = require 'assert'
path = require 'path'
hubot_script = require path.resolve '.', 'scripts', 'hubot-12horoscopes.coffee'

describe 'hubot-12horoscopes', ->
  before (done) ->
    console.log '[describe] before test'
    done()

  after (done) ->
    console.log '[describe] after test'
    done()

  describe 'parseDate()', ->
    it 'M月D日 -> MM, DD', (done) ->
      tests =
        '1月1日'  : [1, 1]
        '12月10日': [12, 10]
        '01月01日': [1, 1]
      for key, val in tests
        assert.equal val, hubot_script.parseDate key
      done()

    it 'MMDD -> MM, DD', (done) ->
      tests =
        '1224': [12, 24]
        '0102': [1, 2]
      for key, val in tests
        assert.equal val, hubot_script.parseDate key
      done()

  describe 'getAstroFromDate()', ->
    it 'return constellation index', (done) ->
      tests =
        0: [ [3, 21], [4, 19] ]
        1: [ [4, 20], [5, 20] ]
        2: [ [5, 21], [6, 21] ]
        3: [ [6, 22], [7, 22] ]
        4: [ [7, 23], [8, 22] ]
        5: [ [8, 23], [9, 22] ]
        6: [ [9, 23], [10,23] ]
        7: [ [10,24], [11,22] ]
        8: [ [11,22], [12,22] ]
        9: [ [12,23], [1, 19] ]
        10:[ [1, 20], [2, 18] ]
        11:[ [2, 19], [3, 20] ]
      for key, val in tests
        for num in val
          assert.equal key, hubot_script.getAstroFromDate num[0], num[1]
      done()
