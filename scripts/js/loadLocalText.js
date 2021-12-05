textIsLoaded = function(target){ console.log(target) } // replace this function with whatever happens after loading the External Text.

function loadLocalText(target) {
  var rawFile = new XMLHttpRequest();
  rawFile.open("GET", target, true);
  rawFile.onreadystatechange = function() {
    if (rawFile.readyState === 4) textIsLoaded(rawFile.responseText);   
  }
  rawFile.send();
}
