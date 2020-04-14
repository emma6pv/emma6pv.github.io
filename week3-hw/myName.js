
let myName = "emma anderson"
let userCount = 0

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

// <video id="myVid" width="400" height="200">
//  <source src="beach.mp4" type="video/mp4">
//   Sorry, your browser does not support HTML5 video.
// </video>
// <script>
// var myVideo = document.getElementById("myVid");
// function playVideo() {
//  myVideo.play();
// }


var audio = new Audio() // used this source: https://www.developphp.com/lib/JavaScript/Audio


// used this source: https://stackoverflow.com/a/48855598
document.addEventListener("keypress", function onEvent(event) {
  var myVideo = document.getElementById("myVid");

  let userKey = event.key
  audio.pause();

  if (userKey === myName[userCount]) {
    audio.pause();
    console.log(true)
    document.getElementById('secondBody').innerHTML = getLettersAtIndex([userCount])
    audio.src = soundbites[userCount];
    audio.play();
    myVideo.play();
    userCount += 1
  } else {
    console.log(false)
    document.getElementById('secondBody').innerHTML = "<span style='font-size: 20px; color: #D9A443'>Whoops! Try again.</span>"
    userCount = 0
    myVideo.pause();
  }

});

function getLettersAtIndex(index) {
  result = ""
  for (i=0; i<=index; i++){
      result += letters[i]
      // console.log(result)
    }
  return result
}
