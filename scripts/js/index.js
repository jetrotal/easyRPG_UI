textIsLoaded = function(target){
initQMLloader(target);
}

var qmlFile= Array.prototype.slice.apply(document.getElementsByTagName('script')).find(e => e.type == 'text/qml');

var qmlContent = qmlFile.src? loadLocalText(qmlFile.src) : qmlFile.innerHTML;
console.log (qmlContent);

