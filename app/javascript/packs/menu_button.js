function switchMenuDisplay() {
  const menuItems = document.getElementById("menu-items")

  if (menuItems.style.display === "none") {
    menuItems.style.display = "block"
  } else {
    menuItems.style.display = "none"
  }
}

const menuButton = document.getElementById("menu-button")
menuButton.addEventListener("click", switchMenuDisplay);
