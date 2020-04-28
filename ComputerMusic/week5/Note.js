class Note {

// credit to https://css-tricks.com/introduction-web-audio-api/#article-header-id-4

  constructor(context, frequency) {
     this.context = context;
     this.frequency = frequency;
   }

 init() {
   this.oscillator = this.context.createOscillator();
   this.tuna = new Tuna(this.context);

   this.chorus = new this.tuna.Chorus({
     rate: 1.5,
     feedback: 0.5,
     //delay: 0.0045,
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

   this.oscillatorGain = this.context.createGain();
   this.oscillatorGain.gain.value = 0.1;
   this.oscillator.connect(this.oscillatorGain);

   this.oscillatorGain.connect(this.chorus);
   //this.oscillatorGain.connect(this.filter);

   //this.chorus.connect(this.context.destination);

   this.chorus.connect(this.filter);
   this.filter.connect(this.context.destination);

 }

 play() {
   const attackTime = 0;
   const decayTime = 2.5;
   const sustainValue = 0.4;
   const releaseTime = 2.3;

   this.init();
   this.oscillator.start();

   // attack
   this.oscillatorGain.gain.setValueAtTime(0, this.context.currentTime);
   this.oscillatorGain.gain.linearRampToValueAtTime(1, this.context.currentTime + attackTime);
   this.oscillatorGain.gain.linearRampToValueAtTime(sustainValue, this.context.currentTime + attackTime + decayTime);

   // release
   this.oscillatorGain.gain.linearRampToValueAtTime(0, this.context.currentTime + releaseTime);
   this.oscillator.stop(this.context.currentTime + releaseTime);
 }

}
