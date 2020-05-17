
// https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Advanced_techniques
const AudioContext = window.AudioContext || window.webkitAudioContext;
const audioCtx = new AudioContext();
const rawPath = 'https://raw.githubusercontent.com/emma6pv/emma6pv.github.io/master/ComputerMusic/week10/TR-808/'


//var crash = new Drum(getPath("crash.wav"), [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]);
//var clap = new Drum(getPath("clap.wav"), [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0]);


let buffer;
let secondsPerBeat = 60.0 / 120; //tempo

window.addEventListener("click", function(event) {
  var clap = new Drum("clap.wav", [1,0,0,0,1,0,0,0,1,0,0,0,1,0,0,0], audioCtx);

  clap.setupSample()
      .then((sample) => {
        buffer = sample;
  });

  playSequence(clap);
  setInterval(function(){ playSequence(clap); }, secondsPerBeat*4000);
});

function playSequence(drum) {
  let seq = drum.getSequence();
  var  time = 10;

  for (let i = 0; i < 16; i++){
    if (seq[i] == 1) {
      console.log(true);
      setTimeout(function(){ drum.playSample(audioCtx, buffer); }, time);
    }
    time += secondsPerBeat*1000/4;
  }
}

// function playSomething(){
//   let seq = [1,1,1,1,0,1,1,0,1,1,1,1,0,1,1,0];
//   var  time = 0.0;
//
//   for (let i = 0; i < 16; i++){
//     if (seq[i] == 1) {
//       setTimeout(function(){ playSample(audioCtx, buffer); }, time);
//     }
//     time += secondsPerBeat*1000/4;
//   }
// }
