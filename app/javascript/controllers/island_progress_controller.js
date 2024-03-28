import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="island-progress"
export default class extends Controller {
  static targets = ["gridCanvas", "scrollContainer", "characterIcon"]
  static values = { currentScore: String }
  canvas = this.gridCanvasTarget;
  ctx = this.canvas.getContext("2d");
  baseImg = new Image();
  currentLevel = 1
  score = Number(this.currentScoreValue)
  scoreToDisplay = this.score / 3

  connect() {
    this.#changeCurrentLevel()
    this.baseImg.src = "https://res.cloudinary.com/dvgcwuo68/image/upload/v1711404034/hub-bg.jpg";
    this.baseImg.onload = () => this.characterProgress()
  }

  characterProgress() {
    this.canvas.width = this.baseImg.width;
    this.canvas.height = this.baseImg.height;
    this.ctx.drawImage(this.baseImg, 0, 0);
    const gridWidth = 45;
    const gridHeight = 45;
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
    this.ctx.lineWidth = 5;
    this.ctx.stroke();

    const charactersLevels = {
      1: [
        { x: 7, y: 12 },
        { x: 8, y: 12 }
      ],
      2: [
        { x: 14, y: 8 },
        { x: 15, y: 8 }
      ]
    }

    const characters = charactersLevels[this.currentLevel]
    const characterWidth = gridWidth;
    const characterHeight = gridHeight;
    const characterIcon = this.characterIconTargets

    for (let i = 0; i < characters.length; i++) {
      const character = characters[i];
      const characterX = character.x * gridWidth;
      const characterY = character.y * gridHeight;


      this.ctx.strokeStyle = "#fa7602";
      this.ctx.drawImage(characterIcon[i], characterX, characterY, characterWidth, characterHeight);


      this.ctx.beginPath();
      this.ctx.moveTo(characterX, characterY + gridHeight);
      this.ctx.lineTo(characterX + gridWidth, characterY + gridHeight);
      this.ctx.stroke();
    }

    const scrollContainer = this.scrollContainerTarget;
    const characterX = characters[0].x * gridWidth + gridWidth / 2;
    const scrollX = characterX - scrollContainer.offsetWidth / 2;
    scrollContainer.scrollTo(scrollX, 0);
  };


  // private
  #changeCurrentLevel() {
    if (this.scoreToDisplay >= 100) {
      this.currentLevel = 4;
    } else if (this.scoreToDisplay >= 66) {
      this.currentLevel = 3;
    } else if (this.scoreToDisplay >= 33) {
      this.currentLevel = 2;
    }
  }
}
