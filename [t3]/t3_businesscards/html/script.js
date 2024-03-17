$(document).keyup(function(e) {
    if (e.keyCode === 27 || e.keyCode === 8) {
        if ($(".inner-container").hasClass("anim-enter")) {
            $(".inner-container").addClass("anim-exit");
            $(".inner-container").removeClass("anim-enter");
            setTimeout(() => {
                $(".inner-container").removeClass("anim-exit");
                $.post("https://t3_businesscards/closeNUI");
            }, 400);
        }
    }
});
$(document).mouseup(function() {
    if ($(".inner-container").hasClass("anim-enter")) {
        $(".inner-container").addClass("anim-exit");
        $(".inner-container").removeClass("anim-enter");
        setTimeout(() => {
            $(".inner-container").removeClass("anim-exit");
			$.post("https://t3_businesscards/closeNUI");
        }, 400);
    }
});
function show(data) {
    if (data.img) {
        $(".card").attr("src",`images/${data.img}.png`);
    }
    $(".inner-container").addClass("anim-enter");
    $(".card").tilt({
		maxTilt: 5,
		reset: false,
	});
};
window.onload = function() {
    var eventCallback = {
        show: function(data){
            show(data)
        },
    }
	window.addEventListener('message', function(event) {
        eventCallback[event.data.action](event.data.data);
    })
	
};