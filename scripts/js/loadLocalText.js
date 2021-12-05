function loadLocalText(target) {
  var rawFile = new XMLHttpRequest();
  rawFile.open("GET", target, true);
  rawFile.onreadystatechange = function() {
    if (rawFile.readyState === 4)
      return rawFile.responseText;
  }
}
