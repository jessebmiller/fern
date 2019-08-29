# Some thoughts on design

This isca rough early draft of my thinking about the design and goals of fern and
the system architecture

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

## Security

Security should be built in from the beginning, Encryption should be handeled
without giving the user much room to shoot themselves in the foot.

It's worth annoying experts quite a bit in order to make it safe and accessible
to non-expert computer users. Expertise in using fern, that all users who stick
with it will get should naturally and transparently translate to good safe
security practices.

## Interface

Rough list of things we might want fern to be able to do

* List and search available positions
* Create new positions
* Edit existing positions
* Save the state of a position
* Arrange existing positions (execute, set up, enact, open..)
  * This is the part where fern makes sure you have Chrome installed and opens
    with all the tabs the position states
  * or clones the git repo where it's suposed to and opens it with emacs
* Close, tear down, stop positions

## Parameterized positions

It's probably useful to have a system that allows generalized positions to be
parameterized, like a GitHub general position that can be instantiated with the
users different repos kept on GitHub.

## Architecture

### Position definitions

Configuration for the CLI telling it what positions there are and how to handle
or arrange them.

Positions might consist of:

* Name
* Storage pipeline (maybe tar -> bzip -> erasure encode -> encrypt -> ipfs)
  * pipeline step config (encryption keys, erasure code parameters...)
* Local location
* Get script
* Put script
* Use script

Remember https://github.com/genuinetools/binctr
Using containers and packaging them as binaries (that can be managed by systemd)
could be very convinient

Remember https://github.com/genuinetools/img
building containers cross platform, enables ARM architectures

### CLI (or TUI?)

Interface that manages positions.

### Storage Interfaces

The position state needs to be stored and backed up somewhere and somehow
described in the position definition. Storage interfaces are responsible for
putting and getting the state from it's storage location.

Storage interfaces should be composable with middleware that can do things like
encryption, compression, and erasure encoding when putting and getting form
certain storage locations if the position requires it.
