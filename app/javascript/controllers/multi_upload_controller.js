// Modified from: https://mentalized.net/journal/2020/11/30/upload-multiple-files-with-rails/

import { Controller } from "stimulus"

export default class extends Controller {
  // filesTarget is going to contain the list of input elements we've added
  // files to - in other words, these are the input elements that we're going
  // to submit.
  static targets = ["files"]

  addFile(event) {
    // Create preveiw
    const preview = document.createElement("img")
    const previewList = document.getElementById("preview")

    // Grab some references for later
    const originalInput = event.target
    const originalParent = originalInput.parentNode

    // Read the image file for preview
    var imgFile = originalInput.files[originalInput.files.length - 1]
    var reader = new FileReader()
    reader.onload = function(e) {
      preview.src = e.target.result
    };
    reader.readAsDataURL(imgFile)

    preview.style.objectFit = "cover"
    preview.style.width = "200px"
    preview.style.height = "200px"

    // Append preview to preview list
    previewList.prepend(preview)
  }
}

