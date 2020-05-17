class Drum {

  constructor(fileName, sequence, context) {
    this.fileName = fileName;
    this.sequence = sequence;
    this.context = context;
  }

  getSequence(){
    return this.sequence;
  }

  getPath(fileName){
    console.log(rawPath);
    return rawPath + fileName
  }


// Loading files ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
// Credit goes to this mozilla tutorial -> https://developer.mozilla.org/en-US/docs/Web/API/Web_Audio_API/Advanced_techniques
  async getFile(audioContext, filepath) {
    const response = await fetch(filepath);
    const arrayBuffer = await response.arrayBuffer();
    const audioBuffer = await audioContext.decodeAudioData(arrayBuffer);
    return audioBuffer;
  }
  async setupSample() {
    const filePath = this.getPath(this.fileName);
    const sample = await this.getFile(this.context, filePath);
    return sample;
  }
  playSample(audioContext, audioBuffer) {
    const sampleSource = audioContext.createBufferSource();
    sampleSource.buffer = audioBuffer;
    sampleSource.playbackRate.setValueAtTime(1, this.context.currentTime);
    sampleSource.connect(audioContext.destination)
    sampleSource.start();
    return sampleSource;
  }
}
