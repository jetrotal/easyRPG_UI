function loadLocalText(target) {
  var rawFile = new XMLHttpRequest();
  rawFile.open("GET", target, true);
  rawFile.onreadystatechange = function() {
    if (rawFile.readyState === 4) {
      var allText = rawFile.responseText;
console.log(allText)
return allText
    }
rawFile.send();
  }
}
