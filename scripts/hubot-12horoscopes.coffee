# Description:
#   12 horoscopes (presented by Yahoo)
#
# Commands:
#   hubot 占い 誕生日(M月D日/MMDD)
#
# Author:
#   @sota1235


request = require 'request'
cheerio = require 'cheerio'
iconv = require 'iconv'

# [early month, dat, late month, day] : URL
ASTRO = [
  ["aries", "おひつじ座"]
  ["taurus", "おうし座"]
  ["gemini", "ふたご座"]
  ["cancer", "かに座"]
  ["leo", "しし座"]
  ["virgo", "おとめ座"]
  ["libra", "てんびん座"]
  ["scorpio", "さそり座"]
  ["sagittarius", "いて座"]
  ["capricorn", "やぎ座"]
  ["aquarius", "みずがめ座"]
  ["pisces", "うお座"]
]

URL = "http://fortune.yahoo.co.jp/12astro/"

## 日時を整形
parseDate = (date, callback = ->) ->
  if /^\d+月\d+日/.test date
    month = date.match(/^\d+/)
    day = date.match(/\d+月(\d+)日/)[1]
  else
    month = date.slice(0, 2)
    day = date.slice(2, 4)
  return [month, day]

## 日時から星座のインデックスをreturn
## TODO:汚すぎ
getAstroFromDate = (month, day, callback = ->) ->
  month = parseInt(month)
  day = parseInt(day)
  switch month
    when 3
      return if day >= 21 then 0 else 11
    when 4
      return if day >= 20 then 1 else 0
    when 5
      return if day >= 21 then 2 else 1
    when 6
      return if day >= 22 then 3 else 2
    when 7
      return if day >= 23 then 4 else 3
    when 8
      return if day >= 23 then 5 else 4
    when 9
      return if day >= 23 then 6 else 5
    when 10
      return if day >= 24 then 7 else 6
    when 11
      return if day >= 22 then 8 else 7
    when 12
      return if day >= 22 then 9 else 8
    when 1
      return if day >= 20 then 10 else 9
    when 2
      return if day >= 19 then 11 else 10
    else
      return false

## Yahooの占いサイトをスクレイピング
## http://fortune.yahoo.co.jp/12astro/index.html
getFortuneData = (url, callback = ->) ->
  request {url: url, encoding: null},  (err, res, body) ->
    if err
      callback err
      return
    conv = new iconv.Iconv('euc-jp', 'UTF-8//TRANSLIT//IGNORE')
    body = conv.convert(body)
    $ = cheerio.load(body)
    b = cheerio.load($('div .bg01-03').html())
    point = b('p').text()
    text = b('dd').text()
    callback [point, text]

module.exports = (robot) ->
  robot.hear /HELLO$/i, (msg) ->
    msg.send "hello!"
    msg.send "Thenk"

  robot.respond /(占い)\s+(\d+月\d+日$|\d{4}$)/i, (msg) ->
    date = parseDate(msg.match[2])
    month = date[0]
    day = date[1]
    if getAstroFromDate(month, day)
      astro = ASTRO[getAstroFromDate(date)]
    else
      msg.send("#{month}月#{day}日なんて誕生日は存在しないっ！！！")
    who = msg.message.user.name

    msg.send "#{astro[1]}: @#{who}さんの今日の運勢"
    getFortuneData URL + astro[0], (data) ->
      msg.send "総合得点：#{data[0]}"
      msg.send data[1]
