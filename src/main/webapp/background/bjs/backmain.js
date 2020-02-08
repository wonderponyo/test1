function aClick(node) {
	var path = node.title;
	var iframeNode = document.getElementById("myif");
	iframeNode.src = path;
}