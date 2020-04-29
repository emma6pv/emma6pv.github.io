
var audioCtx = new AudioContext();

var notes = {};
var gainValue = 0.3;
setupNotes(gainValue);
var keyMap = {};
setupKeyMap();

var lastPlayed = new Date().getTime();
preventTimeout();

const whiteKeyHighlighted = "#F2528D";
const blackKeyHighlighted = "#F29F06";
const whiteKeyColor = "#F2C2C2";
const blackKeyColor = "#1C418C";


// **********  MAIN FUNCTIONS  **********

// if volume is changed
document.getElementById("volume").addEventListener("input", function() {
  sliderValue = this.value;

  gainValue = sliderValue;
  adjustGain(gainValue);
})

// if key is pressed
document.addEventListener("keydown", function onEvent(event){
  // first, make sure the window has not timed out
  checkForTimeout();

  // play note according to key press
  let userKey = event.key;
  if (isValidKey(userKey)) { // if the user key is valid
    playNote(userKey);
    changeKeyColor(userKey, true);
  }
});

// if key is released
document.addEventListener("keyup", function onEvent(event){
  let userKey = event.key;
  if(isValidKey(userKey)) {
    releaseNote(userKey);
    changeKeyColor(userKey, false);
  }
});

// button is clicked
document.getElementById("button").addEventListener("click", function onEvent(event){
  console.log("click");
  playSpecialTune();
})

// **********  HELPER FUNCTIONS  **********

function setupNotes(gainValue) {
  notes = {
    "C3": [new Note(audioCtx, 130.81, gainValue),false],
    "C3#": [new Note(audioCtx, 138.59, gainValue),false],
    "D3": [new Note(audioCtx, 146.83, gainValue),false],
    "E3b": [new Note(audioCtx, 155.56, gainValue),false],
    "E3": [new Note(audioCtx, 164.81, gainValue),false],
    "F3": [new Note(audioCtx, 174.61, gainValue), false],
    "F3#": [new Note(audioCtx, 185, gainValue), false],
    "G3": [new Note(audioCtx, 196, gainValue), false],
    "A3b": [new Note(audioCtx, 207.65, gainValue),false],
    "A3": [new Note(audioCtx, 220, gainValue),false],
    "B3b": [new Note(audioCtx, 233.08, gainValue),false],
    "B3": [new Note(audioCtx, 246.94, gainValue),false],
    "C4": [new Note(audioCtx, 261.63, gainValue),false],
    "C4#": [new Note(audioCtx, 277.18, gainValue),false],
    "D4": [new Note(audioCtx, 293.66, gainValue),false],
    "E4b": [new Note(audioCtx, 311.13, gainValue),false],
    "E4": [new Note(audioCtx, 329.63, gainValue),false],
    "F4": [new Note(audioCtx, 349.23, gainValue),false]
  }
};

function setupKeyMap() {
  keyMap = {
    "a": notes["C3"],
    "w": notes["C3#"],
    "s": notes["D3"],
    "e": notes["E3b"],
    "d": notes["E3"],
    "f": notes["F3"],
    "t": notes["F3#"],
    "g": notes["G3"],
    "y": notes["A3b"],
    "h": notes["A3"],
    "u": notes["B3b"],
    "j": notes["B3"],
    "k": notes["C4"],
    "o": notes["C4#"],
    "l": notes["D4"],
    "p": notes["E4b"],
    ";": notes["E4"],
    "\'": notes["F4"],
  }
};

function playNote(userKey){
  let note = getNoteByKey(userKey);
  if (!isCurrentlyPlaying(note)) {
    startPlaying(note);
  }
}

function releaseNote(userKey){
  let note = getNoteByKey(userKey);
  startReleasing(note);
}

function isCurrentlyPlaying(note){
  return note[1];
}

function startPlaying(note) {
  note[1] = true;
  note[0].play();
}

function startReleasing(note) {
  note[0].release();
  note[1] = false;
}

function getNoteByKey(userKey){
  return keyMap[userKey];
}

function changeKeyColor(userKey, selected){
  if (isWhiteKey(userKey)) {
    if (selected){ // if desired state is a selected state
      document.getElementById(userKey).style.backgroundColor = whiteKeyHighlighted;
    } else { // if desired state is an unselected state
      document.getElementById(userKey).style.backgroundColor = whiteKeyColor;
    }

  } else { // if black key
    if (selected){ // if desired state is a selected state
      document.getElementById(userKey).style.backgroundColor = blackKeyHighlighted;
    } else { // if desired state is an unselected state
      document.getElementById(userKey).style.backgroundColor = blackKeyColor;
    }
  }
}

function isWhiteKey(userKey){
  return document.getElementById(userKey).className === "whiteKey"
}

function isValidKey(userKey){
  return ['a', 'w', 's', 'e', 'd','f','t','g','y','h','u','j','k','o','l','p',';','\''].includes(userKey)
}


function adjustGain(gainValue){
  for (item in notes) {
    note = notes[item][0];
    note.adjustGain(gainValue);
  }
}

// this code prevents Chrome timeout
// credit to: https://stackoverflow.com/a/33155239
function preventTimeout() {
  var myArrayBuffer = audioCtx.createBuffer(2, audioCtx.sampleRate * 3, audioCtx.sampleRate);
  var audioSource = audioCtx.createBufferSource();
      audioSource.connect( audioCtx.destination );
      audioSource.buffer = myArrayBuffer;
      audioSource.start( 0 );
}

// this code prevents Chrome timeout
// credit to: https://stackoverflow.com/a/33155239
function checkForTimeout() {
  if (new Date().getTime()-lastPlayed>30000) {   // Time passed since last playing is greater than 30 secs
      audioCtx.close();
      audioCtx = new AudioContext();
      setupNotes(gainValue);
      setupKeyMap();
  };
  lastPlayed = new Date().getTime();
}

// **** functions for automated playback ****
function playSpecialTune(){
  playEFlatChord();

  setTimeout(function(){
     playDm7Chord();
  }, 2000);

  setTimeout(function(){
   playBFlatChord();
  }, 3000);

  setTimeout(function(){
   playEFlatChord();
  }, 4000);
}

function playEFlatChord(){
  playNote("e");
  playNote("g");
  playNote("u");

  changeKeyColor("e", true);
  changeKeyColor("g", true);
  changeKeyColor("u", true);

  setTimeout(function(){
   releaseNote("e");
   releaseNote("g");
   releaseNote("u");
}, 1000);

  setTimeout(function(){
   changeKeyColor("e", false);
   changeKeyColor("g", false);
   changeKeyColor("u", false);
}, 3000);
}

function playDm7Chord(){
  playNote("s");
  playNote("f");
  playNote("h");
  playNote("k");

  changeKeyColor("s", true);
  changeKeyColor("f", true);
  changeKeyColor("h", true);
  changeKeyColor("k", true);

  setTimeout(function(){
   releaseNote("s");
   releaseNote("f");
   releaseNote("h");
   releaseNote("k");
}, 500);

  setTimeout(function(){
   changeKeyColor("s", false);
   changeKeyColor("f", false);
   changeKeyColor("h", false);
   changeKeyColor("k", false);
}, 1500);
}

function playBFlatChord(){
  playNote("s");
  playNote("f");
  playNote("u");

  changeKeyColor("s", true);
  changeKeyColor("f", true);
  changeKeyColor("u", true);

  setTimeout(function(){
   releaseNote("s");
   releaseNote("f");
   releaseNote("u");
}, 500);

  setTimeout(function(){
   changeKeyColor("s", false);
   changeKeyColor("f", false);
   changeKeyColor("u", false);
}, 1500);
}
