# Some thoughts on design

This document is intended as a rough early draft of my thinking about the design
and goals of fern and the system architecture

## Fern manages names for the things you do

* Position
  1. a place where someone or something is located or has been put.
  1. a particular way in which someone or something is placed or arranged.

In fern, a position is a named arangement of data and metadata on where to get
it, how to save it, where it goes, and how to work on it.

For example:

* A git repository kept on GitHub and worked on with emacs
* A particular set of audio files, plugins, and midi instruments worked on with
  pro-tools
* A set of files in a directory visited in zsh
* A set of urls opened in tabs in chrome

Positions are not a repelacement for shell commands and the unix philosophy, but
are rather personal computing configurations that you have found you want to get
to frequently enough to describe them in code and name them.

