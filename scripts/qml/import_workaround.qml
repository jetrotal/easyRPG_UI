import QtQuick 2.0
import QtQuick.Controls 2.12

ApplicationWindow {
    visible:true
    id:app

    property var importedObjects:({})
    property var timeStamp: "?"+new Date().getTime() // timestamp is helpful to avoid clearing the browser's cache every time a file is edited

    function _Timer() {
        return Qt.createQmlObject("import QtQuick 2.0; Timer {}", app);
    }

    function injectQML(target, name, file, properties) {
        file = file + timeStamp

        var i = 0
        var newComponent = Qt.createComponent(file);

        var timer = new _Timer(); timer.interval = 1, timer.repeat = true, timer.start();

        timer.triggered.connect(function () {
            i++;
            var status = isOBJloaded(newComponent, target,i);

            if (status !=="loading") {
                timer.destroy();

                importedObjects[name] = status;
                for (var a in properties) importedObjects[name][a] = properties[a];
            };
        })
    }


    function isOBJloaded(obj, target,i=0) {
        if (obj.status !== Component.Ready) return "loading";

        console.log("it took "+i+ (i === 1 ? " try ":" tries ") +"to load")
        return obj.createObject(target)
    }

    function destroyLastObject() {
        var lastObjectName = Object.keys(importedObjects)[Object.keys(importedObjects).length - 1]

        if (!importedObjects[lastObjectName]) return

        importedObjects[lastObjectName].destroy()
        delete importedObjects[lastObjectName]
    }


    header:Row {
        id: headerMainContainer
    }
    Column {
        Button {
            text:"run injectQML( <font color='red'>parent</font>,<font color='red'> name</font>, <font color='red'>file</font>, <font color='red'>{properties}</font> )"

            onPressed: {
                var randomColor = Math.floor(16777215 * Math.random()).toString(16)
                var newObject = {
                    name:"rectangle_"+ randomColor,
                    source:"https://jetrotal.github.io/easyRPG_UI/scripts/qml/components/rectangleTest.qml",
                    parent:headerMainContainer
                }

                newObject.properties = {
                    "color": "#" + randomColor,
                    "text": newObject.name
                }

                app.injectQML(newObject.parent, newObject.name,newObject.source ,newObject.properties);
            }
        }

        Button {
            text:"Destroy Last Imported Object"

            onPressed: destroyLastObject();
        }
    }
}
