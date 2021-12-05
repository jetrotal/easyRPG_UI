var qmlFile= Array.prototype.slice.apply(document.getElementsByTagName('script')).find(e => e.type == 'text/qml');

var qmlContent = qmlFile.innerHTML;
console.log (qmlFile);
