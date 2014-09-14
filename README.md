hubot-12horoscopes
====

[![Build Status](https://travis-ci.org/sota1235/hubot-12horoscopes.svg)](https://travis-ci.org/sota1235/hubot-12horoscopes)
[![NPM version](https://badge.fury.io/js/stylestats.svg)](http://badge.fury.io/js/stylestats)

占い結果を返してくれるHubot scriptです。

## Description

[YAHOO!JAPAN占い](http://fortune.yahoo.co.jp/12astro)より、12星座占いの結果を取得し、respondします。

## Demo

![demo](http://i.gyazo.com/786e6547b4c3f7759c6d8659e48f3495.png)

## Usage

日付はM月D日, MMDD形式のいずれかに対応しています。

```
hubot 占い 12月24日

hubot 占い 1214

hubot 占い 0301
```

## Install

```
% npm install hubot-12horoscopes -save
```

### edit `external-script.json`

```json
["hubot-12horoscopes"]
```

## Author

[@sota1235](https://github.com/sota1235)
