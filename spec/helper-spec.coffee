describe 'linter helpers', ->
  helpers = require '../lib/helpers'
  fs = require 'fs'
  testFile = __dirname + '/fixtures/test.txt'
  testContents = fs.readFileSync(testFile).toString()
  describe '::exec', ->
    it 'cries when no argument is passed', ->
      gotError = false
      try
        helpers.exec()
      catch erro then gotError = true
      expect(gotError).toBe(true)
    it 'works', ->
      waitsForPromise ->
        helpers.exec('cat', [testFile]).then (text) ->
          expect(text).toBe(testContents)
    it 'lets you choose streams', ->
      waitsForPromise ->
        helpers.exec('cat', [testFile], stream: 'stderr').then (text) ->
          expect(text).toBe('')
    it 'accepts stdin', ->
      waitsForPromise ->
        helpers.exec('cat', [], stream: 'stdout', stdin: testContents).then (text) ->
          expect(text).toBe(testContents)
  describe '::execFilePath', ->
    it 'cries when no argument is passed', ->
      gotError = false
      try
        helpers.execFilePath()
      catch erro then gotError = true
      expect(gotError).toBe(true)
    it 'cries when no filepath is passed', ->
      gotError = false
      try
        helpers.execFilePath('cat', [])
      catch erro then gotError = true
      expect(gotError).toBe(true)
    it 'works', ->
      waitsForPromise ->
        helpers.execFilePath('cat', [], testFile).then (text) ->
          expect(text).toBe(testContents)
  describe '::parse', ->
    it 'cries when no argument is passed', ->
      gotError = false
      try
        helpers.parse()
      catch erro then gotError = true
      expect(gotError).toBe(true)