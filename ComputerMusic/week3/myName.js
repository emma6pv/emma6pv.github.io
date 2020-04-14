let letters = [
  "<span style='color: #4193A6'>E</span> ",
  "<span style='color: #F2C849'>m</span> ",
  "<span style='color: #D9A443'>m</span> ",
  "<span style='color: #D96C6C'>a</span> ",
  "&nbsp;&nbsp;",
  "<span style='color: #D99A9F'>A</span> ",
  "<span style='color: #4193A6'>n</span> ",
  "<span style='color: #F2C849'>d</span> ",
  "<span style='color: #D9A443'>e</span> ",
  "<span style='color: #D96C6C'>r</span> ",
  "<span style='color: #D99A9F'>s</span> ",
  "<span style='color: #4193A6'>o</span> ",
  "<span style='color: #F2C849'>n</span>"
]


let soundbites = [
  "sounds/BA1.mp3",
  "sounds/BA2.mp3",
  "sounds/BA3.mp3",
  "sounds/BA4.mp3",
  "sounds/BA5.mp3",
  "sounds/BA6.mp3",
  "sounds/BA7.mp3",
  "sounds/BA8.mp3",
  "sounds/BA9.mp3",
  "sounds/BA10.mp3",
  "sounds/BA11.mp3",
  "sounds/BA12.mp3",
  "sounds/BA13.mp3",
]

var audio = new Audio() // used this source: https://www.developphp.com/lib/JavaScript/Audio
let myName = "emma anderson"
let correctLetters = 0
let repeats = 0

// used this source: https://stackoverflow.com/a/48855598
document.addEventListener("keypress", function onEvent(event) {
  var video = document.getElementById("myVid");
  setupVideo()

  let userKey = event.key
  audio.pause();

  // if user key matches the correct letter
  if (userKey === myName[correctLetters]) {
    // display correct letter on page
    document.getElementById('secondBody').innerHTML = getLettersAtIndex([correctLetters])

    // load the next audio file
    audio.src = soundbites[correctLetters];

    // play the audio and video
    audio.play();
    video.play();

    // add timed listener so audio pauses after each keypress
    video.addEventListener("timeupdate", pauseVideo); // used this source: https://stackoverflow.com/a/53924299

    // update the count of correctLetters
    correctLetters += 1
  }

  // if user's key press is incorrect
  else {
    // replace innerHTML with Try Again message
    document.getElementById('secondBody').innerHTML = "<span style='font-size: 20px; color: #D9A443'>Whoops! Try again.</span>"
    correctLetters = 0
    repeats = 0
    video.pause();
  }


  // pause the video in between keystrokes
  function pauseVideo(e) {
    if (correctLetters < 13) {
      video.pause();
    }
    video.removeEventListener("timeupdate", pauseVideo);
  }

  // if the video ends prematurely, play it for another 2 seconds
  function setupVideo() {
    video.onended = function() {
      if (correctLetters == 13 && repeats == 0) {
        video.play();
        setTimeout(function(){ video.pause(); }, 2000)
        repeats += 1
      }
    };
  }

});


function getLettersAtIndex(index) {
  result = ""
  for (i=0; i<=index; i++){
      result += letters[i]
    }
  return result
}
