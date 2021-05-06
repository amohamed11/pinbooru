import { Controller } from "stimulus"

export default class extends Controller {
  // filesTarget is going to contain the list of input elements we've added
  // files to - in other words, these are the input elements that we're going
  // to submit.
  static targets = ["files"]

  // Modified from: https://mentalized.net/journal/2020/11/30/upload-multiple-files-with-rails/
  addFile(event) {
    const previewList = document.getElementById("preview")

    // Grab some references for later
    const originalInput = event.target
    const originalParent = originalInput.parentNode

    // Move the input element that we've added files to, to the list of
    // selected elements
    this.filesTarget.append(originalInput)

    // Read the image file for preview
    for (let imgFile of originalInput.files) {
      const preview = document.getElementById("preview-template").cloneNode(true)
      const previewImg = preview.firstElementChild
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

    // // Create a new blank, input field to use going forward
    // const newInput = originalInput.cloneNode()

    // // Clear the filelist - some browsers maintain the filelist when cloning,
    // // others don't
    // newInput.value = ""

    // // Add it to the DOM where the original input was
    // originalParent.removeChild(originalInput)
    // originalParent.append(newInput)
  }

  removeFile(event) {
    // Remove the preview that the button belongs to
    const button = event.target
    button.parentElement.remove()

    // Remove file from the input
    // Source (bless this person's soul): https://stackoverflow.com/a/47642446
    const input = document.getElementById("post_images")
    const dt = new DataTransfer()
    for (let file of input.files) {
      if (file !== input.files[input.files.length - 1]){
        dt.items.add(file)
      }
    }
    input.files = dt.files
  }
}

