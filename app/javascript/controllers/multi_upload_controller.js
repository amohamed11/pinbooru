import { Controller } from "stimulus"

export default class extends Controller {

  addFile(event) {
    // Modified from: https://mentalized.net/journal/2020/11/30/upload-multiple-files-with-rails/
    // Create preveiw
    const previewList = document.getElementById("preview")
    const preview = document.getElementById("preview-template").cloneNode(true)
    const previewImg = preview.firstElementChild

    // Grab some references for later
    const originalInput = event.target

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

