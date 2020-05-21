// Audio Context
const AudioContext = window.AudioContext || window.webkitAudioContext;
const audioCtx = new AudioContext();

// Variables
var tempo = 120;
var secondsPerBeat = 60.0 / tempo;

// Drums
var clap = new Drum("clap.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var conga = new Drum("conga.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var cowbell = new Drum("cowbell.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var crash = new Drum("crash.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var hatClose = new Drum("hatClose.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var hatOpen = new Drum("hatOpen.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var kick = new Drum("kick.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var maraca = new Drum("maraca.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var snare = new Drum("snare.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomHigh = new Drum("tomHigh.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomLow = new Drum("tomLow.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomMed = new Drum("tomMed.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);

// Buffers
let clapBuffer;
let congaBuffer;
let cowbellBuffer;
let crashBuffer;
let hatCloseBuffer;
let hatOpenBuffer;
let kickBuffer;
let maracaBuffer;
let snareBuffer;
let tomHighBuffer;
let tomLowBuffer;
let tomMedBuffer;

// Path for soundfiles
const rawPath = 'https://raw.githubusercontent.com/emma6pv/emma6pv.github.io/master/ComputerMusic/week10/TR-808/'

// Setup
var consoleContents = ["Welcome to the console.<br>This is where you&apos;ll code your drum kit.<br><br>Want a quick tutorial? (Y/N)<br>"];
var isFirstLaunchOfConsole = true;
var isTutorialMode = false;
var tutorialStepNumber = 0;
var isStartButtonOn = false;
var isCurrentlyPlaying = false;

setupSamples();
updateConsole();


function playAll(){
  isCurrentlyPlaying = true;
  play(conga, congaBuffer);
  play(clap, clapBuffer);
  play(cowbell, cowbellBuffer);
  play(crash, crashBuffer);
  play(hatClose, hatCloseBuffer);
  play(hatOpen, hatOpenBuffer);
  play(kick, kickBuffer);
  play(maraca, maracaBuffer);
  play(snare, snareBuffer);
  play(tomHigh, tomHighBuffer);
  play(tomLow, tomLowBuffer);
  play(tomMed, tomMedBuffer);

  let msg = "Now playing.<br>";
  printToConsole(msg);
}

function stopAll() {
  isCurrentlyPlaying = false;
  stop(conga, congaBuffer);
  stop(clap, clapBuffer);
  stop(cowbell, cowbellBuffer);
  stop(crash, crashBuffer);
  stop(hatClose, hatCloseBuffer);
  stop(hatOpen, hatOpenBuffer);
  stop(kick, kickBuffer);
  stop(maraca, maracaBuffer);
  stop(snare, snareBuffer);
  stop(tomHigh, tomHighBuffer);
  stop(tomLow, tomLowBuffer);
  stop(tomMed, tomMedBuffer);
}


/*
|--------------------------------------------------------------------------
| Console Log
|--------------------------------------------------------------------------
|
| ...
| ...
| ...
|
*/

function updateConsole() {
  result = ""
  for (let t = 0; t < consoleContents.length; t++){
    result += consoleContents[t] + "<br>";
  }
  document.getElementById('consoleWindow').innerHTML = result;
  document.getElementById('consoleWindow').scrollTop = 9999999;
}

function printToConsole(msg){
  consoleContents.push(msg);
  updateConsole();
}

function clearConsole() {
  document.getElementById('consoleWindow').innerHTML = "";
}

/*
|--------------------------------------------------------------------------
| From the User to the Drum
|--------------------------------------------------------------------------
|
| Core functions for translating the user commands to
| actual drum commands within the code.
|
|
*/

// Determine which function to trigger based on the input
function centralNavigation(userInput){
  if (userInput.startsWith("addDrum")) {
    str = (userInput.split("addDrum("))[1].split(',[');
    drumType = str[0];
    sequence = (str[1].replace('])', '').split(',')).map(Number);
    userAddsDrum(drumType, sequence);
  }
  else if (userInput.startsWith("removeDrum")){
    drumType = (userInput.split("removeDrum("))[1].split(',[')[0].replace(')','');
    userRemovesDrum(drumType);
  }
  else if (userInput.startsWith("start")) {
    userStartsMachine();
  }
  else if (userInput.startsWith("stop")) {
    userStopsMachine();
  }
}

function userAddsDrum(drumType, sequence) {
  let msg = "<span style='color: #EDEACC'>" + drumType + "</span>" + " drum updated.<br>"
  printToConsole(msg);

  if (isCurrentlyPlaying) {
    stopAll();
    window[drumType].updateSequence(sequence);

    if (isStartButtonOn){
      let msg = "Loading..."
      printToConsole(msg);
      setTimeout(function(){ playAll(); }, secondsPerBeat*4050); // timeout waits until first loop ends
    }
  } else {
    window[drumType].updateSequence(sequence);

    if (isStartButtonOn) {
      playAll();
    }
  }
}

function userRemovesDrum(drumType) {
  userAddsDrum(drumType, [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
}

function userResetsMachine() {
  // set all drums to [0000]
}

function userClearsConsole() {
  clearConsole();
}

function userStopsMachine() {
  let msg = "Drum machine stopped.<br>"
  printToConsole(msg);
  isStartButtonOn = false;
  stopAll();
}

function userStartsMachine() {
  if (isStartButtonOn) {
    let msg = "Drum machine has already started.<br>"
    printToConsole(msg);
  } else {
    isStartButtonOn = true;
    playAll();
  }
}

function userSetsSpeed() {
  // update tempo
}

/*
|--------------------------------------------------------------------------
| Event Handlers
|--------------------------------------------------------------------------
|
| ...
| ...
| ...
|
*/

function handleKeyPress(e){

  if (enterKeyPressed(e)){

    var userInput = document.getElementById('consoleInput').value.toString().replace( /\s/g, '');
    clearInput();

    if (isTutorialMode) {
      handleTutorial(userInput);
    }
    else if (isValidInput(userInput)) {
      displayValidInput(userInput);
      centralNavigation(userInput);
      isFirstLaunchOfConsole = false;
    }
    else {
      if (isFirstLaunchOfConsole) {
        handleLaunchPrompt(userInput);
      }
      else {
        // User made an invalid command.
        displayErrorInput(userInput);
        let msg = "Oops. That&apos;s not a valid command. Check the Reference below for legal commands.<br>"
        printToConsole(msg);
      }
    }
  }
}


/*
|--------------------------------------------------------------------------
| User Tutorial
|--------------------------------------------------------------------------
|
| Handling of the user tutorial option given to the user
| upon page launch.
|
|
*/

// Console handling for the initial launch message
// asking if the user wants to take the tutorial
function handleLaunchPrompt(userInput) {
  // If user said yes to the tutorial
  if (userSaidYes(userInput)) {
    displayValidInput(userInput);
    handleTutorial();
    isFirstLaunchOfConsole = false;
  }
  else if (userSaidNo(userInput)) {
    displayValidInput(userInput);
    skipTutorial();
    isFirstLaunchOfConsole = false;
  }
  else if (!isValidInput(userInput)){
    displayErrorInput(userInput);
    let msg = "Oops. That&apos;s not a valid command.<br>Want a quick tutorial? (Y/N)<br>"
    printToConsole(msg);
  }
}

function handleTutorial(userInput) {
  // ROUND 0
  if (tutorialStepNumber == 0) {
    let msg = "Let&apos;s start with something simple.<br>We are going to add a <span style='color: #EDEACC'>snare</span> drum, placing one 16th note at the beginning of each beat like a metronome.<br><br>Try this: <span style='color: #EDEACC'>addDrum(snare, [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0])</span><br><br>The 1&apos;s correspond with an audible 16th note. The 0&apos;s correspond with silence.<br>"
    printToConsole(msg);
    isTutorialMode = true;
    tutorialStepNumber += 1;
  }

  // ROUND 1
  else if (tutorialStepNumber == 1) {
    let correctAnswer = "addDrum(snare,[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0])";

    // User answers correctly
    if (userInput == correctAnswer) {
      displayValidInput(userInput);
      userAddsDrum("snare", [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]);

      let msg = "Good, now let&apos;s start the drum.<br>Try this: <span style='color: #EDEACC'>start()</span><br>"
      printToConsole(msg);
      tutorialStepNumber += 1;
    }
    // User answers incorrectly
    else {
      displayErrorInput(userInput)
      let msg = "Invalid command, let&apos;s try again. When in doubt, use copy and paste.<br>Try this: <span style='color: #EDEACC'>addDrum(snare, [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0])</span><br>"
      printToConsole(msg);
    }
  }

  // ROUND 2
  else if (tutorialStepNumber == 2) {
    let correctAnswer = "start()";

    // User answers correctly
    if (userInput == correctAnswer) {
      displayValidInput(userInput);
      userStartsMachine();
      let msg = "Nice!<br><br>The metronome has started and you are ready to live-code some music.<br>Refer to the Reference to add more drums or adjust speed and playback.<br><br>Happy drumming!<br>"
      printToConsole(msg);
      isTutorialMode = false;
    }
    // User answers incorrectly
    else {
      displayErrorInput(userInput)
      let msg = "Invalid command, let&apos;s try again. When in doubt, use copy and paste.<br>Try this: <span style='color: #EDEACC'>start()</span><br>"
      printToConsole(msg);
    }
  }
}

function launchTutorial(){
  let msg = "Let&apos;s start with something simple.<br>Try this: <span style='color: #EDEACC'>addDrum(clap, [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0])</span><br>"
  printToConsole(msg);
}

function skipTutorial(){
  let msg = "Okay! If you need help, use the Reference included below.<br>"
  printToConsole(msg);
}

/*
|--------------------------------------------------------------------------
| User Input Handling
|--------------------------------------------------------------------------
|
| Checking, disCurrentlyPlaying, and erasing of inputs from the user.
|
|
*/

function clearInput() {
  document.getElementById('consoleInput').value = "";
  event.preventDefault();
}

function displayValidInput(userInput) {
  result = userInput;
  if (userInput.startsWith("addDrum")) {
    result = prettyPrint(userInput);
  }
  let msg = "<span style='color: #00F900'>" + ">> " + result + "</span><br>"
  printToConsole(msg);
}

function displayErrorInput(userInput){
  let msg = "<span style='color: #DE1101'>" + ">> " + userInput + "</span><br>"
  printToConsole(msg);
}

function userSaidYes(userInput){
  return userInput.toLowerCase() == 'y';
}

function userSaidNo(userInput){
  return userInput.toLowerCase() == 'n';
}

function enterKeyPressed(e){
  var key=e.keyCode || e.which; // credit to https://stackoverflow.com/a/13987361
  return key == 13
}

function isValidInput(userInput) {
  // addDrum
  let regex1 = /addDrum\(\b(?:clap|crash|tomHigh|tomMed|tomLow|hatClose|hatOpen|snare|kick|cowbell|conga|maraca)\b\,\[[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01],[01]\]\)/;

  // removeDrum
  let regex2 = /removeDrum\(\b(?:clap|crash|tomHigh|tomMed|tomLow|hatClose|hatOpen|snare|kick|cowbell|conga|maraca)\b\)/;

  // setSpeed
  let check3 = false;
  if (userInput.startsWith("setSpeed(") && userInput.endsWith(")")) {
    var newStr = userInput.replace("setSpeed(", "");
    newStr = parseInt((newStr.replace(")", "")));
    check3 = (newStr >= 30 && newStr <= 200);
  }

  // other
  let check4 = ["start()", "clear()", "stop()"].includes(userInput);

  return regex1.test(userInput) || regex2.test(userInput) || check3 || check4
}

// Separate array according to beats so that it is easier
// for the user to understand
function prettyPrint(userInput){
  newString = (userInput.split('addDrum('))[1].split(',[')
  type = newString[0]
  sequence = newString[1].replace('])', '')

  counter = 0
  prettySequence = ""
  for (let c = 0; c < sequence.length; c++) {
    if (counter == 7) {
      counter = 0
      prettySequence += ', '
    } else {
      counter++;
      prettySequence += sequence[c];
    }
  }
  return "addDrum(" + type + ", [" + prettySequence + '])'
}

/*
|--------------------------------------------------------------------------
| Playback Functionality
|--------------------------------------------------------------------------
|
| Core functions that handle playback.
| Play and stop files.
| Automatically loops drums after each measure.
|
*/

var intervalsPlaying = [];

function play(drum, buffer){
  playSequence(drum, buffer);
  let id = setInterval(function(){ playSequence(drum, buffer); }, secondsPerBeat*4000);
  intervalsPlaying.push(id);
}

function playSequence(drum, buffer) {
  let seq = drum.getSequence();
  var  time = 10;

  for (let i = 0; i < 16; i++){
    if (seq[i] == 1) {
      setTimeout(function(){ drum.playSample(audioCtx, buffer); }, time);
    }
    time += secondsPerBeat*1000/4;
  }
}

function stop(drum, buffer) {
  deleteOldIntervals();
}

function deleteOldIntervals() {
  for (let i = 0; i < intervalsPlaying.length; i++) {
    clearInterval(intervalsPlaying[i]);
  }
  intervalsPlaying = [];
}


/*
|--------------------------------------------------------------------------
| Buffer Setup
|--------------------------------------------------------------------------
|
| The following function setups the buffer for each drum object.
| I tried to automate this using a loop, but it only worked
| when I assigned each buffer individually, hence the longer function.
|
*/

// Load the samples and prepare the buffers
function setupSamples() {
  conga.setupSample()
  .then((sample) => {
    congaBuffer = sample;
  });

  clap.setupSample()
  .then((sample) => {
    clapBuffer = sample;
  });


  cowbell.setupSample()
  .then((sample) => {
    cowbellBuffer = sample;
  });

  crash.setupSample()
  .then((sample) => {
    crashBuffer = sample;
  });

  hatClose.setupSample()
  .then((sample) => {
    hatCloseBuffer = sample;
  });

  hatOpen.setupSample()
  .then((sample) => {
    hatOpenBuffer = sample;
  });

  kick.setupSample()
  .then((sample) => {
    kickBuffer = sample;
  });

  maraca.setupSample()
  .then((sample) => {
    maracaBuffer = sample;
  });

  snare.setupSample()
  .then((sample) => {
    snareBuffer = sample;
  });

  tomHigh.setupSample()
  .then((sample) => {
    tomHighBuffer = sample;
  });

  tomLow.setupSample()
  .then((sample) => {
    tomLowBuffer = sample;
  });

  tomMed.setupSample()
  .then((sample) => {
    tomMedBuffer = sample;
  });
}
