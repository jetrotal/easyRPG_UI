textIsLoaded = function(target){
console.log(target) };

function loadLocalText(target) {
  var rawFile = new XMLHttpRequest();
  rawFile.open("GET", target, true);
  rawFile.onreadystatechange = function() {
    if (rawFile.readyState === 4) textIsLoaded(rawFile.responseText);   
  }
  rawFile.send();
}
