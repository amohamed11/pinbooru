function switchMenuDisplay() {
  const menuItems = document.getElementById("menu-items")

  menuItems.style.display = menuItems.style.display === "block" ? "none" : "block" 
}

const menuButton = document.getElementById("menu-button")
menuButton.addEventListener("click", switchMenuDisplay);
