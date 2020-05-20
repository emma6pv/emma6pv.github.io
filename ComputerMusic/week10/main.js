// Audio Context
const AudioContext = window.AudioContext || window.webkitAudioContext;
const audioCtx = new AudioContext();

// Variables
var tempo = 120;
var secondsPerBeat = 60.0 / tempo;

// Drums
var clap = new Drum("clap.wav", [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0], audioCtx);
var conga = new Drum("conga.wav", [0,1,1,0,0,1,1,0,0,1,1,0,0,1,1,0], audioCtx);
var cowbell = new Drum("cowbell.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var crash = new Drum("crash.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var hatClose = new Drum("hatClose.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var hatOpen = new Drum("hatOpen.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var kick = new Drum("kick.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var maraca = new Drum("maraca.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var snare = new Drum("snare.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomHigh = new Drum("tomHigh.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomLow = new Drum("tomLow.wav", [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], audioCtx);
var tomMed = new Drum("tomMed.wav", [1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0], audioCtx);

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
setupSamples();
updateConsole();

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
| Event Handlers
|--------------------------------------------------------------------------
|
| ...
| ...
| ...
|
*/

window.addEventListener("click", function(event) {
  // play(conga, congaBuffer);
  // play(tomMed, tomMedBuffer);

  //newSeq = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  //setTimeout(function(){ tomMed.updateSequence(newSeq); }, 8000);
});

function handleKeyPress(e){

  if (enterKeyPressed(e)){

    var userInput = document.getElementById('consoleInput').value.toString().replace( /\s/g, '');
    clearInput();

    if (isTutorialMode) {
      handleTutorial(userInput);
    }
    else if (isValidInput(userInput)) {
      displayValidInput(userInput);
      isFirstLaunchOfConsole = false;
      // handleValidCommand(userInput)
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
    let msg = "Let&apos;s start with something simple.<br>We are going to add a Clap drum, placing one 16th note at the beginning of each beat like a metronome.<br><br>Try this: <span style='color: #EDEACC'>addDrum(clap, [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0])</span><br><br>The 1&apos;s correspond with an audible 16th note. The 0&apos;s correspond with silence.<br>"
    printToConsole(msg);
    isTutorialMode = true;
    tutorialStepNumber += 1;
  }

  // ROUND 1
  else if (tutorialStepNumber == 1) {
    let correctAnswer = "addDrum(clap,[1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0])";

    // User answers correctly
    if (userInput == correctAnswer) {
      displayValidInput(userInput);
      // TODO: actually implement the function the user asked, with a msg like "Clap drum added."
      let msg = "Good, now let&apos;s start the drum.<br>Try this: <span style='color: #EDEACC'>start()</span><br>"
      printToConsole(msg);
      tutorialStepNumber += 1;
    }
    // User answers incorrectly
    else {
      displayErrorInput(userInput)
      let msg = "Invalid command, let&apos;s try again. When in doubt, use copy and paste.<br>Try this: <span style='color: #EDEACC'>addDrum(clap, [1,0,0,0, 1,0,0,0, 1,0,0,0, 1,0,0,0])</span><br>"
      printToConsole(msg);
    }
  }

  // ROUND 2
  else if (tutorialStepNumber == 2) {
    let correctAnswer = "start()";

    // User answers correctly
    if (userInput == correctAnswer) {
      displayValidInput(userInput);
      // TODO: actually implement the start function the user asked, with a msg like "Drum started."
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
| Checking, displaying, and erasing of inputs from the user.
|
|
*/

function clearInput() {
  document.getElementById('consoleInput').value = "";
  event.preventDefault();
}

function displayValidInput(userInput) {
  let msg = "<span style='color: #00F900'>" + ">> " + userInput + "</span><br>"
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

function play(drum, buffer){
  playSequence(drum, buffer);
  setInterval(function(){ playSequence(drum, buffer); }, secondsPerBeat*4000);
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
