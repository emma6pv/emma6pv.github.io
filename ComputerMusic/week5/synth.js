
var audioCtx = new AudioContext();

var notes = {};
setupNotes();

var lastPlayed = new Date().getTime();
preventTimeout();


document.addEventListener("keydown", function onEvent(event){
  let userKey = event.key;

  // this code prevents Chrome timeout
  // credit to: https://stackoverflow.com/a/33155239
  if (new Date().getTime()-lastPlayed>30000) {   // Time passed since last playing is greater than 30 secs
      audioCtx.close();
      audioCtx = new AudioContext();
      setupNotes();
  }


  if (userKey === "e") {
    console.log("e key is pressed");
    notes["E3b"].play();
    notes["G3"].play();
    notes["B3b"].play();
  }

  if (userKey === "o") {
    console.log("o key is pressed");
    notes["D3"].play();
    notes["F3"].play();
    notes["A3"].play();
    notes["C4"].play();
  }

  if (userKey === "m") {
    console.log("m key is pressed");
    notes["B3b"].play();
    notes["D3"].play();
    notes["F3"].play();
  }
});


function setupNotes() {
  notes = {
    "C3": new Note(audioCtx, 130.81),
    "C3#": new Note(audioCtx, 138.59),
    "D3": new Note(audioCtx, 146.83),
    "E3b": new Note(audioCtx, 155.56),
    "E3": new Note(audioCtx, 164.81),
    "F3": new Note(audioCtx, 174.61),
    "F3#": new Note(audioCtx, 185),
    "G3": new Note(audioCtx, 196),
    "A3b": new Note(audioCtx, 207.65),
    "A3": new Note(audioCtx, 220),
    "B3b": new Note(audioCtx, 233.08),
    "B3": new Note(audioCtx, 246.94),
    "C4": new Note(audioCtx, 261.63)
  }
};

// this code prevents Chrome timeout
// credit to: https://stackoverflow.com/a/33155239
function preventTimeout() {
  var myArrayBuffer = audioCtx.createBuffer(2, audioCtx.sampleRate * 3, audioCtx.sampleRate);
  var audioSource = audioCtx.createBufferSource();
      audioSource.connect( audioCtx.destination );
      audioSource.buffer = myArrayBuffer;
      audioSource.start( 0 );
}
