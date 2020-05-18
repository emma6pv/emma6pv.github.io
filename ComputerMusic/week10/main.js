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

// init
setupSamples();

window.addEventListener("click", function(event) {
  play(conga, congaBuffer);
  play(tomMed, tomMedBuffer);

  //newSeq = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  //setTimeout(function(){ tomMed.updateSequence(newSeq); }, 8000);
});

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


// Load the samples and prepare the buffers
function setupSamples() {
  // Tried to automate this using a loop, but it only worked
  // when I assigned each buffer individually, hence the longer function
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
