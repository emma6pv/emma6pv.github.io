
// The Note class is modeled after https://css-tricks.com/introduction-web-audio-api/#article-header-id-4
class Note {

  constructor(context, frequency, gainValue) {
     this.context = context;
     this.frequency = frequency;
     this.gainValue = gainValue;
   }

 init() {
   this.oscillator = this.context.createOscillator();
   this.tuna = new Tuna(this.context); // https://github.com/Theodeus/tuna

   this.chorus = new this.tuna.Chorus({
     rate: 1.5,
     feedback: 0.5,
     delay: 0.0045,
     bypass: 0
   });
   this.filter = new this.tuna.Filter({
    frequency: 1000, //20 to 22050
    Q: 1, //0.001 to 100
    gain: 0, //-40 to 40 (in decibels)
    filterType: "bandpass", //lowpass, highpass, bandpass, lowshelf, highshelf, peaking, notch, allpass
    bypass: 0
  });

   this.oscillator.frequency.value = this.frequency;
   this.oscillator.detune.value = 20;
   this.oscillator.type = "sawtooth";

   this.input = this.context.createGain();
   this.output = this.context.createGain();

   this.oscillator.connect(this.input);

   this.input.connect(this.chorus);
   this.chorus.connect(this.output);

   this.input.connect(this.filter);
   this.filter.connect(this.output);

   this.input.gain.value = this.gainValue;
   console.log(this.gainValue);
   this.output.connect(this.context.destination);
 }


 play() {
   const attackTime = 0;
   const decayTime = 2.5;
   const sustainValue = 0.4;

   this.init();
   this.oscillator.start();

   // attack, decay, sustain
   this.output.gain.setValueAtTime(0, this.context.currentTime);
   this.output.gain.linearRampToValueAtTime(1, this.context.currentTime + attackTime);
   this.output.gain.linearRampToValueAtTime(sustainValue, this.context.currentTime + attackTime + decayTime);
}

release() {
   const releaseTime = 2.3;
   // release
   this.output.gain.linearRampToValueAtTime(0, this.context.currentTime + releaseTime);
   this.oscillator.stop(this.context.currentTime + releaseTime);
}

adjustGain(gainValue) {
  this.gainValue = gainValue;
}

}
