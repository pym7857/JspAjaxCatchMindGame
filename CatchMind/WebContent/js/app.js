const canvas = document.getElementById("jsCanvas");
const ctx = canvas.getContext("2d"); // 우리는 2d로 작업
const colors = document.getElementsByClassName("jsColor");  
const range = document.getElementById("jsRange");
const mode = document.getElementById("jsMode");
const clr = document.getElementById("jsClear");

const INITIAL_COLOR = "#2c2c2c";
const CANVAS_SIZE = 700;

canvas.width = CANVAS_SIZE;
canvas.height = CANVAS_SIZE;

ctx.fillStyle = "white";
ctx.fillRect(0, 0, CANVAS_SIZE, CANVAS_SIZE);

ctx.strokeStyle = INITIAL_COLOR; // stroke = 그리는 것
ctx.fillStyle = INITIAL_COLOR; 
ctx.lineWidth = 2.5;

let painting = false;
let filling = false;

function stopPainting() {
	painting = false;
}

function startPainting() {
	painting = true;
}

function onMouseMove(event) { 
	const x = event.offsetX;
	const y = event.offsetY;
	if (!painting) { // 클릭하면, 더이상 이부분은 작동X
		ctx.beginPath();
		ctx.moveTo(x, y);
	} else {
		ctx.lineTo(x, y); // 연결
		ctx.stroke(); // 그린다
	}
}

function handleColorClick(event) {
	const color = event.target.style.backgroundColor;
	ctx.strokeStyle = color;
	ctx.fillStyle = ctx.strokeStyle;
}

function handleRangeChange(event) {
	const size = event.target.value;
	ctx.lineWidth = size; // lineWidth를 Override
}

function handleModeClick() {
	if (filling == true) {
		filling = false;
		mode.innerText = "Fill";
	} else {
		filling = true;
		mode.innerText = "Paint";
	}
}

function handleCanvasClick() {
	if (filling) {
		ctx.fillRect(0, 0, CANVAS_SIZE, CANVAS_SIZE);
	}
}

function handleCanvasClear(){
	ctx.clearRect(0, 0, CANVAS_SIZE, CANVAS_SIZE);
}

if(canvas) {
	canvas.addEventListener("mousemove", onMouseMove);
	canvas.addEventListener("mousedown", startPainting);
	canvas.addEventListener("mouseup", stopPainting);
	canvas.addEventListener("mouseleave", stopPainting);
	canvas.addEventListener("click", handleCanvasClick);
}

Array.from(colors).forEach(color_element => color_element.addEventListener("click", handleColorClick));

// range이벤트는 input에 반응한다
if (range) {
	range.addEventListener("input", handleRangeChange);
}

if (mode) {
	mode.addEventListener("click", handleModeClick);
}

if (clr) {
	clr.addEventListener("click", handleCanvasClear);
}


