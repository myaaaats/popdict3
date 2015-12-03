var dct = {};

var resetDict = function () {
	dct = {apple: "りんご", banana: "バナナ"};
}
// idがresetDictの要素をクリックしたら、起動する関数。（onclickは使わない。
$("#resetDict").click(function () {
	resetDict();
});


function convText0(word) {
	var elem = ($("<div></div>").append($("<a></a>", {
		class: "word",
		href: "http://ejje.weblio.jp/content/" + word
	}).text(word)));
	return elem[0].outerHTML;
}

$("#convText").click(function convText() {
	t = "";
	var src = $("[name=word]").val();
	var not_dot = src.replace(".", '').replace("?", '').replace("!", '').replace(":", '').replace(",", '');

//    var txt = "";
//    var A ="";
//    var B = document.getElementById("src");
//    A.value = B.value.replace(/./g,'');
//    txt = A.value.split(" ");
//	txt = not_dot.split(" ");
//	for (i = 0; i < txt.length; i++) {
//		t = t + convText0(txt[i]);
//	}

	//$("#linked").append(t);
	convText2(not_dot);
});

function convText2() {
	txt = $("#src").val();

	$.ajax({
		type: 'GET',
		url: '/api/check/' + txt
	}).success(function (data) {
		dct = data;
		for (k in data) {
			var elem = ($("<div></div>").append($("<a></a>", {
				class: "word",
				href: "http://ejje.weblio.jp/content/" + k
			}).text(k)));
			$("#linked").append(elem);
		}
	});

}

$("#getDict").click(function getDict() {
	txt = $("src").value;
	$.ajax({
		type: 'GET',
		url: '/cgi-bin/dict/dict.cgi?word=' + txt
	}).success(function (data) {
		txt = data;
		dct = JSON.parse(txt);
	});
});


function mapDict(wd) {
	if (dct[wd]) {
		element = $("#display")[0];
		element.innerHTML = dct[wd];
	}
}

function mapExit() {
	element = $("#display")[0];
	element.innerHTML = "[無指定]";
};


//ページのロードが完了したら、呼び出す。
$(document).ready(function () {
	resetDict();
});

// word class の要素にマウスが掛かったら、呼び出す。
$(document).on('mouseover', '.word', function (ev) {

	mapDict(ev.currentTarget.text);
})
;

