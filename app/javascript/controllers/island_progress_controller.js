import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="island-progress"
export default class extends Controller {
  static targets = ["gridCanvas", "backgroundImage", "scrollContainer", "characterIcon"]

  canvas = this.gridCanvasTarget;
  ctx = this.canvas.getContext("2d");
  baseImg = new Image();
  // backgroundImage = this.backgroundImageTarget;

  connect() {
    this.baseImg.src = "https://res.cloudinary.com/dvgcwuo68/image/upload/v1711404034/hub-bg.jpg";
    this.baseImg.onload = () => this.characterProgress()
  }

  characterProgress() {
    this.canvas.width = this.baseImg.width;
    this.canvas.height = this.baseImg.height;
    this.ctx.drawImage(this.baseImg, 0, 0);
    const gridWidth = 42.8;
    const gridHeight = 42.8;
    this.ctx.beginPath();
    for (let x = 0; x < this.canvas.width; x += gridWidth) {
      this.ctx.moveTo(x, 0);
      this.ctx.lineTo(x, this.canvas.height);
    }
    for (let y = 0; y < this.canvas.height; y += gridHeight) {
      this.ctx.moveTo(0, y);
      this.ctx.lineTo(this.canvas.width, y);
    }

    this.ctx.strokeStyle = "rgba(0, 0, 0, 0)";
    this.ctx.lineWidth = 3;
    this.ctx.stroke();

    const characters = [
      { x: 5, y: 8 },
      { x: 6, y: 8 }
    ];

    const characterWidth = gridWidth;
    const characterHeight = gridHeight;
    const characterIcon = this.characterIconTargets

    for (let i = 0; i < characters.length; i++) {
      const character = characters[i];
      this.ctx.strokeStyle = "#FFD700";
      this.ctx.drawImage(characterIcon[i], character.x * gridWidth, character.y * gridHeight, characterWidth, characterHeight);
    }

    const scrollContainer = this.scrollContainerTarget;
    const characterX = characters[0].x * gridWidth + gridWidth / 2;
    const scrollX = characterX - scrollContainer.offsetWidth / 2;
    scrollContainer.scrollTo(scrollX, 0);
  };
}
