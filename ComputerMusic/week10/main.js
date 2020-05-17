
// https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Advanced_techniques
// for cross browser compatibility
const AudioContext = window.AudioContext || window.webkitAudioContext;
const audioCtx = new AudioContext();


const drumType = {
   crash: 1,
   tomHigh: 2,
   tomMed: 3,
   tomLow: 4,
   hatClose: 5,
   hatOpen: 6,
   snare: 7,
   kick: 8,
   clap: 9,
   cowbell: 10,
   conga: 11,
   maraca: 12
};


drums = [
  new Drum(drumType.crash, "/TR-808/crash.wav"),
  new Drum(drumType.clap, "/TR-808/clap.wav"),
]


// credit = https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Advanced_techniques
async function getFile(audioContext, filepath) {
  const response = await fetch(filepath);
  const arrayBuffer = await response.arrayBuffer();
  const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
  return audioBuffer;
}

// credit = https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Advanced_techniques
async function setupSample() {
    const filePath = 'TR-808/crash.wav';
    const sample = await getFile(audioCtx, filePath);
    return sample;
}

setupSample()
    .then((sample) => {
        // sample is our buffered file
        // ...
});

function playSample(audioContext, audioBuffer) {
    const sampleSource = audioContext.createBufferSource();
    sampleSource.buffer = audioBuffer;
    sampleSource.playbackRate.setValueAtTime(playbackRate, audioCtx.currentTime);
    sampleSource.connect(audioContext.destination)
    sampleSource.start();
    return sampleSource;
}

let dtmf;
playSample(audioCtx, dtmf);
