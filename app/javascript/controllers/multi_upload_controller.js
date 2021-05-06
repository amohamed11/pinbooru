// Modified from: https://mentalized.net/journal/2020/11/30/upload-multiple-files-with-rails/

import { Controller } from "stimulus"

export default class extends Controller {
  // filesTarget is going to contain the list of input elements we've added
  // files to - in other words, these are the input elements that we're going
  // to submit.
  static targets = ["files"]

  addFile(event) {
    // Create preveiw
    const previewList = document.getElementById("preview")
    const preview = document.getElementById("preview-template").cloneNode(true)
    const previewImg = preview.firstElementChild

    // Grab some references for later
    const originalInput = event.target
    const originalParent = originalInput.parentNode

    this.filesTarget.append(originalInput)

    // Read the image file for preview
    var imgFile = originalInput.files[originalInput.files.length - 1]
    var reader = new FileReader()
    reader.onload = function(e) {
      previewImg.src = e.target.result
    };
    reader.readAsDataURL(imgFile)

    previewImg.style.objectFit = "cover"
    previewImg.style.width = "200px"
    previewImg.style.height = "200px"

    // Append preview to preview list
    preview.style.display = "block"
    preview.removeAttribute("id")
    previewList.append(preview)
  }

  removeFile(event) {
    // Find related image
    const button = event.target
    const relatedImg = button.previousElementSibling

    // Remove it from preview list
    const previewList = document.getElementById("preview")
    var nodeToRemove = null

    for (let i = 0; i < previewList.childNodes.length; i++) {
      let p = previewList.childNodes[i];
      console.log(p)
      if (p.firstElementChild?.tagName === "IMG" && p.firstElementChild.src === relatedImg.src) {
        nodeToRemove = p
        break
      }
    }

    previewList.removeChild(nodeToRemove)
  }
}

