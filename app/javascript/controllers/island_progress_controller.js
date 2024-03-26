import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="island-progress"
export default class extends Controller {
  static targets = ["gridCanvas", "backgroundImage", "scrollContainer", "characterIcon"]

  connect() {
    this.characterProgress()
  }

  characterProgress() {
    const canvas = this.gridCanvasTarget;
    const ctx = canvas.getContext("2d");

    const backgroundImage = this.backgroundImageTarget;
    canvas.width = backgroundImage.width;
    canvas.height = backgroundImage.height;

    const gridWidth = 42.8;
    const gridHeight = 42.8;

    ctx.drawImage(backgroundImage, 0, 0);

    ctx.beginPath();
    for (let x = 0; x <= canvas.width; x += gridWidth) {
      ctx.moveTo(x, 0);
      ctx.lineTo(x, canvas.height);
    }
    for (let y = 0; y <= canvas.height; y += gridHeight) {
      ctx.moveTo(0, y);
      ctx.lineTo(canvas.width, y);
    }
    ctx.strokeStyle = "rgba(0, 0, 0, 0)";
    ctx.stroke();

    const characters = [
      { x: 15, y: 8 },
      { x: 16, y: 8 }
    ];

    const characterWidth = gridWidth;
    const characterHeight = gridHeight;
    const characterIcon = this.characterIconTargets

    for (let i = 0; i < characters.length; i++) {
      const character = characters[i];
      ctx.strokeStyle = "#FFD700";
      ctx.drawImage(characterIcon[i], character.x * gridWidth, character.y * gridHeight, characterWidth, characterHeight);
    }

    const scrollContainer = this.scrollContainerTarget;
    const characterX = characters[0].x * gridWidth + gridWidth / 2;
    const scrollX = characterX - scrollContainer.offsetWidth / 2;
    scrollContainer.scrollTo(scrollX, 0);
  };
}
