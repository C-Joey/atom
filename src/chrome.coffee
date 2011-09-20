module.exports =
class Chrome
  # path - Optional. The String path to the file to base it on.
  @newWindow: (path) ->
    c = OSX.AtomWindowController.alloc.initWithWindowNibName "AtomWindow"
    c.window
    c.window.makeKeyAndOrderFront null

  # Returns null or a file path.
  @openPanel: ->
    panel = OSX.NSOpenPanel.openPanel
    panel.setCanChooseDirectories true
    if panel.runModal isnt OSX.NSFileHandlingPanelOKButton
      return null
    filename = panel.filenames.lastObject
    localStorage.lastOpenedFilename = filename
    filename

  @openURL: (url) ->
    window.location = url
    App = require 'app'
    App.activeWindow.setTitle _.last url.replace(/\/$/,'').split '/'

  # Returns null or a file path.
  @savePanel: ->
    panel = OSX.NSSavePanel.savePanel
    if panel.runModal isnt OSX.NSFileHandlingPanelOKButton
      return null
    panel.filenames.lastObject

  writeToPasteboard: (text) ->
    pb = OSX.NSPasteboard.generalPasteboard
    pb.declareTypes_owner [OSX.NSStringPboardType], null
    pb.setString_forType text, OSX.NSStringPboardType
