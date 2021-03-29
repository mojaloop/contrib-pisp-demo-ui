var comments = [ 
  "slicing up some pineapples",
  "prepping a pina colada",
  "juicing up the good stuff",

]

function loadSnarkyComment() {
  var comment = comments[Math.floor(Math.random() * comments.length)];
  document.getElementById("snarkyComment").innerHTML = comment;
}

loadSnarkyComment()