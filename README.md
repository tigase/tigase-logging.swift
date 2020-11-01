<!--<p align="center">
  <a href="https://tigase.net/">
    <img
      alt="YouTrack Agile Boards"
      src="/assets/Agile_Board.png"
      width="600"
    />
  </a>
</p>-->

<h1 align="center">
  Tigase Logging library for Swift
</h1>

<!--<p align="center">
  <img alt="Tigase Tigase Logo" src="/assets/tigase-logo.png" width="25"/>
  <img src="https://tc.tigase.net/app/rest/builds/buildType:(id:TigaseXmlTools_Build)/statusIcon" width="100"/>
</p>-->

# What it is

Tigase Logging library for Swift is a library providing a thin wrapper around `os_log` from `os` framemerk. It as a replacement for `Logger` struct provided in macOS 11 and iOS 14 with aim to have a subset of functionality of that struct and very similar API, to make it possible to switch to the `Logger` from the `os`  framework without many changes.

For operating systems not having `os` framework available, we use `print` to print logged messages to the console.

# Compilation 

This repository contains Swift package and is compatible with SwiftPM. It may be easily used by adding dependency on this repository in your project.

# License

<img alt="Tigase Tigase Logo" src="https://github.com/tigase/website-assets/blob/master/tigase/images/tigase-logo.png?raw=true" width="25"/> Official <a href="https://tigase.net/">Tigase</a> repository is available at: https://github.com/tigase/tigase-swift/.

Copyright (c) 2004 Tigase, Inc.

Licensed under AGPL License Version 3. Other licensing options available upon request.
