import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import QtQuick.Window 2.2
//import org.kde.kirigami 2.9 as Kirigami

ApplicationWindow {
    property string assets:
    (pathIsLocal ? Qt.resolvedUrl(".") : "https://raw.githubusercontent.com/jetrotal/easyRPG_layout/main/")

    id: app
    visible: true

    minimumWidth: 720; minimumHeight: 480
    background:ez.bg;

    component Content : Rectangle {
        anchors.margins:20;
        anchors.fill:parent
        color:"transparent"
        border.color: "red"
        border.width:debug

    }
    component UI_Library : Item {
        visible:false
        property real multi: 1
        property var style: {

            "sizes": {
                "text":9*multi,
                "logo": 16*multi,
                "win":16*multi,
                "icon":24*multi

            },

            "colors": {
                "bg": "#292b2f",
                "header": "#242529",
                "textA": "#97999C",
                "textB": "#FFF",
                "highlight": "#8AFF4E",
                "separator": "#555",
                "darkBorders": "#1e1e1e",
                "shadowColor":"#222327"
            },

            "images": {
                "logo": assets + "img/ez-logo.svg",
                "bg": assets + "img/bg/tile.svg",
                "icons": {
                    "win": {
                        "url": assets + "img/icons/window/",
                        "size": 16
                    },
                    "top": {
                        "url": assets + "img/icons/top/",
                        "size": 39
                    }
                }
            }
        } // STYLES
        property var appButtons: {
            "workSpace": [{
                "obj": "appHome",
                "display": "Home",
            },/*separators*/, {
                "obj": "mapEditor",
                "display": "Map Editor",
            }, {
                "obj": "databaseEditor",
                "display": "Database Editor",
            }, {
                "obj": "eventsEditor",
                "display": "Events Editor",
            },/*separators*/, {
                "obj": "resourceManager",
                "display": "Resource Manager",
            }, {
                "obj": "gameSearch",
                "display": "Search",
            },/*separators*/, {
                "obj": "bgmTest",
                "display": "BGM test",
            },/*separators*/, {
                "obj": "gameSettings",
                "display": "Playtest Settings",
            }, {
                "obj": "gamePlay",
                "display": "Begin Playtest",
            }],
            "window": [{
                "obj": "min",
                "display": "Minimize Window",
            }, {
                "obj": "max",
                "display": "Maximize Window",
            }, {
                "obj": "close",
                "display": "Close Window",
            }],
            "topBar": [{
                "obj": "project",
                "display": "Game Project",
                "contents": [{
                    "obj":"newProject","display":"New Project"
                }, {
                    "obj":"openProject","display":"Open Project"
                }, {
                    "obj":"closeProject","display":"Close Project"
                }]
            }, {
                "obj": "maps",
                "display": "Maps",
                "contents": [""]
            }, {
                "obj": "view",
                "display": "View",
                "contents": [""]
            }, {
                "obj": "tools",
                "display": "Tools",
                "contents": [""]
            }, {
                "obj": "game",
                "display": "Game",
                "contents": [""]
            }, {
                "obj": "help",
                "display": "Help",
                "contents": [""]
            }, {
                "obj": "debug",
                "display": "Debug",
                "contents": [""]
            }]
        }

        function listProperty(item) {
            // debug props
            var result="";
            for (var p in item) result += String(item[p]) !== "function() { [native code] }" ? (p +": " + (String(item[p]) ==="[object Object]" ?" {; "+ listProperty(item[p])+" } " : item[p]) +`;`):"";
            return(result.split(';').join(pathIsLocal ? "\n" : "<br>"))
        }


        function detectCommand(bt, type,qmlItem) {
            if (debug===1) footerMark.text = ("running detectCommand() - You clicked: " + bt.obj + "  |  Type: "+type),
            console.log(ez.listProperty(qmlItem));


            if (type === "workspace")
                return changeWorkspace(bt)
            if (type === "window") {
                if (bt.obj === "min") return app.showMinimized()
                if (bt.obj === "max") return console.log(app.visibility), app.visibility === 4 ? app.showNormal() :app.showMaximized()
                if (bt.obj === "close") return app.close()

            }
        }

        function changeWorkspace(e) {

            currWorkspace.text = "<pre><font color='" + styles.colors.textB + "'>  " + e.display + "  </pre>"
        }

        property Item bg: Rectangle {
            anchors.fill: parent
            color: ez.style.colors.bg
            Image {
                anchors.fill:parent
                fillMode: Image.Tile
                source: ez.style.images.bg
            }
        }


    }
    UI_Library {
        id:ez
    } // ez[variableName] // ez.styles[styleVar] //

    menuBar:Rectangle {
        anchors.left:parent.left
        anchors.right:parent.right
        height:topBar.height
        color: ez.style.colors.header


        Row {

            MenuBar {
                id: topBar
                background.visible:false;
                height:27 * ez.multi
                width:app.width
                contentItem: Row {
                    Text {
                        text:"<img width='"+ez.style.sizes.logo+"' height='"+ez.style.sizes.logo+"' src='"+ez.style.images.logo+"'></img>"

                        font.pointSize: ez.style.sizes.text
                        padding:6 * ez.multi

                    }

                }

                Repeater {
                    model: ez.appButtons.topBar
                    MenuBarItem {
                        font.pointSize: ez.style.sizes.text
                        onClicked:ez.detectCommand(modelData, "topBar")
                        background: Rectangle {
                            color: highlighted ? ez.style.colors.darkBorders : ez.style.colors.header


                        }

                        menu: Menu {

                            id:container
                            property var obj: modelData.obj
                            title: "<font color='"+ (highlighted ? ez.style.colors.textB : ez.style.colors.textA)+"'>" + modelData.display+"</font>"
                            font.pointSize: ez.style.sizes.text


                            background.implicitHeight: ez.style.sizes.text
                            background.visible:false
                            Repeater {
                                id: outerDelegate
                                model: modelData.contents
                                MenuItem {

                                    text: "<font color='"+ (highlighted ? ez.style.colors.textB : ez.style.colors.textA)+"'>"+(modelData ? modelData.display:"")+"</font>"
                                    font.pointSize: ez.style.sizes.text
                                    padding: 3 * ez.multi
                                    horizontalPadding :15 * ez.multi
                                    enabled: modelData? true : false
                                    onClicked: ez.detectCommand(modelData, ["topBar",container.obj],this)
                                    background: Rectangle {

                                        color: highlighted ? ez.style.colors.darkBorders: ez.style.colors.bg

                                    }
                                }
                            }
                        }

                    }
                }


            }
        }


        MenuBar {
            height:parent.height
            width:parent.height*3
            background.visible:false
            anchors.right:parent.right
            Repeater {

                model: ez.appButtons.window

                MenuItem {
                    font.pointSize:ez.style.sizes.text
                    //background.visible: false
                    width:parent.height; height:parent.height
                    icon.source: ez.style.images.icons.win.url + modelData.obj + ".svg"
                    icon.color: this.hovered ? ez.style.colors.textB : ez.style.colors.textA
                    icon.width:ez.style.sizes.icon; icon.height:ez.style.sizes.icon;
                    onClicked: ez.detectCommand(modelData, "window",this)
                    background:Rectangle {
                        color:ez.style.colors.header;
                    }

                }
            }
        }
    }
    header: Rectangle {
        color:ez.style.colors.header
        width:parent.width+4
        x:-2
        height:headerContents.height
        border.color: ez.style.colors.shadowColor
        border.width:2




        TabBar {
            id:headerContents
            padding: 3 * ez.multi
            horizontalPadding :15* ez.multi
            background:Rectangle {
                width:app.width
                visible:false
            }
            Repeater {

                model: ez.appButtons.workSpace
                TabButton {

                    enabled: !modelData ? false : true

                    width:!modelData ? 15: undefined;

                    icon.width:ez.style.sizes.icon; icon.height:ez.style.sizes.icon
                    icon.source: !modelData ? "" : ez.style.images.icons.top.url + modelData.obj+".svg"

                    icon.color: checked ? ez.style.colors.highlight : (hovered ? ez.style.colors.textB :ez.style.colors.textA)
                    font.pointSize: ez.style.sizes.text
                    ToolTip {
                        delay:500
                        text: modelData ? modelData.display : ""
                        visible:modelData? hovered: false
                    }

                    Rectangle {
                        visible: !modelData ? true : false
                        color:ez.style.colors.separator
                        anchors.centerIn: parent
                        width: 1* ez.multi
                        height:20* ez.multi
                    }

                    //background.visible:false
                    background: Rectangle {
                        visible:false
                        color: ez.style.colors.darkBorders
                    }
                    onClicked: ez.detectCommand(modelData, "workspace",this)
                    onHoveredChanged:background.visible = hovered * enabled

                }

            }

        }

    }
    footer: Rectangle {
        color:ez.style.colors.header
        width:parent.width
        height:menuBar.height/1.1

        Text {
            id:footerMark
            anchors.left:parent.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins:10 * ez.multi
            color: ez.style.colors.textA
            text: ""
            font.pointSize: ez.style.sizes.text / 1.05
        }

        Text {
            anchors.right:parent.right
            anchors.verticalCenter: parent.verticalCenter
            anchors.margins:footerMark.anchors.margins
            color: ez.style.colors.textA
            text: "easyRPG.org"
            font.pointSize: footerMark.font.pointSize
        }

    }

    Content {
        Rectangle {}
    }

    property int pathIsLocal: 0
    property int debug:1
}
