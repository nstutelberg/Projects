 Projects

hypotheses
    #1) average disposable income per capita is positively related to the average selling price of yeezys. (TABLEAU MEAN OF SELL PRICE AND INCOME)
    #2) solid color yeezys appreciate faster than multicolored yeezys or striped yeezys (TABLEAU GROUP COLORS AND TAKE AVERAGE OR PLOT TWO LINES IN R)
    #3) higher shoe size correlates to higher resale price (REGRESSION IN R)
    #4) later order date (more recent) correlates to higher resale price. (REGRESSION IN R)

notes
    #fix a day and find the day that has the greatest variation in the cross section, a day where you have the most models being sold
    #looking for greatest degree of variation fixing the time period, CROSS SECTIONAL ANALYSIS. fix time period of sale
    #an option would be to only include common sizes so you have more observations that are more consistent

proposed plan
    #find greatest number of observations on a given day, fix time, find sale date that gives largest # of observations of each make
    #find a day with greatest number of observations for each specific shoe, regress price on shoe size and quantity of shoes that was released (probably not available)


With plotting the regression lines, In order to see the relationship for each variable, there is a separate ggplot graph for each variable. Note that the binary dependent 
      variables won't have a meaningful regression line because they are discrete values rather than continuous. However, we can still see the difference in the mean
      of each category by using a plot
      
      
# Foco
[![Build Status](https://travis-ci.org/akashnimare/foco.svg?branch=master)](https://travis-ci.org/akashnimare/foco)
[![Windows Build Status](https://ci.appveyor.com/api/projects/status/github/akashnimare/foco?branch=master&svg=true)](https://ci.appveyor.com/project/akashnimare/foco/branch/master)
[![js-standard-style](https://img.shields.io/badge/code%20style-standard-brightgreen.svg?style=flat)](https://github.com/feross/standard)

<h1 align="center">
  <br>
  <img src="https://github.com/akashnimare/foco/blob/master/app/img/foco.png" alt="Foco" width="160">
</h1>

<h4 align="center">A desktop menubar app based on <a href="http://electron.atom.io" target="_blank">Electron</a>.</h4>

Foco is a cross-platform desktop app :computer: which runs in menubar.
Foco boosts your productivity :rocket: by creating perfect productive environment.
It has the best sounds for getting work done :raised_hands:.

# Demo
👉 Watch it <a href="https://www.youtube.com/watch?v=6SG2Mjpv8YE">here</a>.
<br>

[![Watch demo](https://cloud.githubusercontent.com/assets/2263909/18597112/0622a3b0-7c6a-11e6-897d-13f0aa36b6e4.png)](https://www.youtube.com/watch?v=6SG2Mjpv8YE)

<img src="https://j.gifs.com/BBqE8Y.gif">

## Installation
[FR]: https://github.com/akashnimare/foco/releases

### OS X

1. Download [Foco-osx.x.x.x.dmg][FR] or [Foco-osx.x.x.x.zip][FR]
2. Open or unzip the file and drag the app into the `Applications` folder
3. Done!

### Windows
coming soon :stuck_out_tongue_closed_eyes:

### Linux

*Ubuntu, Debian 8+ (deb package):*

1. Download [Foco-linux.x.x.x.deb][FR]
2. Double click and install, or run `dpkg -i Foco-linux.x.x.x.deb` in the terminal
3. Start the app with your app launcher or by running `foco` in a terminal


### For developers
Clone the source locally:

```sh
$ git clone https://github.com/akashnimare/foco/
$ cd foco
```
If you're on Debian or Ubuntu, you'll also need to install
`nodejs-legacy`:

Use your package manager to install `npm`.

```sh
$ sudo apt-get install npm nodejs-legacy
```

Install project dependencies:

```sh
$ npm install
```
Start the app:

```sh
$ npm start
```

### Build installers

Build app for OSX
```sh
$ npm run build:osx
```
Build app for Linux
```sh
$ npm run build:linux
```

## Features

- [x] Offline support
- [x] Cross-platform
- [x] Awesome sounds
- [x] No singup/login required
- [ ] Auto launch
- [ ] Auto updates


## Usage

<kbd>Command/ctrl + R</kbd> - Reload

<kbd>command + q</kbd> - Quit App (while window is open).

## Built with
- [Electron](https://electron.atom.io)
- [Menubar](https://github.com/maxogden/menubar)

## Related
- [zulip-electron](https://github.com/zulip/zulip-electron)

## License

MIT  © [Akash Nimare](http://akashnimare.in)
