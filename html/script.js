let progress = 0;
let targetPosition = Math.random() * 280;
let gameActive = false;

const progressBar = document.querySelector('.progress-bar');
const target = document.querySelector('.target');

function startMinigame() {
    progress = 0;
    targetPosition = Math.random() * 280;
    gameActive = true;
    progressBar.style.width = '0%';
    target.style.left = `${targetPosition}px`;
    update();
}

function update() {
    if (!gameActive) return;
    
    progress += 1;
    progressBar.style.width = `${progress}%`;
    
    if (progress >= 100) {
        gameActive = false;
        fetch(`https://${GetParentResourceName()}/minigameFailed`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        });
        return;
    }
    
    if (progress >= targetPosition && progress <= targetPosition + 20) {
        gameActive = false;
        fetch(`https://${GetParentResourceName()}/minigameSuccess`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8',
            },
            body: JSON.stringify({})
        });
        return;
    }
    
    requestAnimationFrame(update);
}

window.addEventListener('message', (event) => {
    if (event.data.action === 'startMinigame') {
        startMinigame();
    }
});