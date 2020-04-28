
const audioCtx = new AudioContext();

const notes = {
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
};


document.addEventListener("keydown", function onEvent(event){
  let userKey = event.key;

  if (userKey === "e") {
    console.log("e key is pressed");
    //notes["E3b"].play();
    newNote = new Note(audioCtx, 155.56);
    newNote.play();
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







// {
//   "C2": new Note(audioCtx, 65.41),
//   "C2#": new Note(audioCtx, 69.3),
//   "D2": new Note(audioCtx, 73.42),
//   "E2b": new Note(audioCtx, 77.78),
//   "E2": new Note(audioCtx, 82.41),
//   "F2": new Note(audioCtx, 87.31),
//   "F2#": new Note(audioCtx, 92.5),
//   "G2": new Note(audioCtx, 98),
//   "A2b": new Note(audioCtx, 103.83),
//   "A2": new Note(audioCtx, 110),
//   "B2b": new Note(audioCtx, 116.54),
//   "B2": new Note(audioCtx, 123.47),
//   "C3": new Note(audioCtx, 130.81)
// };
