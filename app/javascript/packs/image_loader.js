// Modified from: https://stackoverflow.com/a/3263539

var interValRef = 0;

var interValRef = setInterval(function (){
  // Once all the images are done loading
  if(document.readyState == 'complete'){
    clearInterval(interValRef);

    // Hide the skeleton
    const skeletons = document.getElementsByClassName("post-skeleton")
    for (let skeleton of skeletons) {
      skeleton.style.display = "none"
    }

    // Display the loaded images
    const hiddenImages = document.getElementsByClassName("load-hidden")
    for (let hiddenImage of hiddenImages) {
      hiddenImage.style.display = "block"
    }
  }
}, 500)

