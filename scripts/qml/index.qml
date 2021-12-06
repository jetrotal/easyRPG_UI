import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import org.kde.kirigami 2.4 as Kirigami

//import "https://raw.githubusercontent.com/jetrotal/easyRPG_layout/main/scripts/qml/test.qml"

MainApp {
    id: mainApp
//aaaaaah{
    property string assets: "https://raw.githubusercontent.com/jetrotal/easyRPG_layout/main/"

    component LoadStyles : QtObject {
        id: styles



        property var colors: {
            "bg": "#292b2f",
            "header": "#242529",
            "textA": "#97999C",
            "textB": "#FFF",
            "highlight": "#8AFF4E",
            "separator": "#555",
            "darkBorders": "#1e1e1e"
        }

        property var images: {
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
    component LoadVariables: QtObject {
        id: variables

        property var appButtons: {
            "workSpace": [{
                "obj": "appHome",
                "hasSeparator": 1,
                "display": "Home",
                "action": ""
            }, {
                "obj": "mapEditor",
                "hasSeparator": 0,
                "display": "Map Editor",
                "action": ""
            }, {
                "obj": "databaseEditor",
                "hasSeparator": 0,
                "display": "Database Editor",
                "action": ""
            }, {
                "obj": "eventsEditor",
                "hasSeparator": 1,
                "display": "Events Editor",
                "action": ""
            }, {
                "obj": "resourceManager",
                "hasSeparator": 0,
                "display": "Resource Manager",
                "action": ""
            }, {
                "obj": "gameSearch",
                "hasSeparator": 1,
                "display": "Search",
                "action": ""
            }, {
                "obj": "bgmTest",
                "hasSeparator": 1,
                "display": "BGM test",
                "action": ""
            }, {
                "obj": "gameSettings",
                "hasSeparator": 0,
                "display": "Playtest Settings",
                "action": ""
            }, {
                "obj": "gamePlay",
                "hasSeparator": 0,
                "display": "Begin Playtest",
                "action": ""
            }],
            "window": [{
                "obj": "min",
                "action": ""
            }, {
                "obj": "max",
                "action": ""
            }, {
                "obj": "close",
                "action": ""
            }],
            "header": [{
                /*TODO DYNAMIC HEADER MENU*/
            }]
        }
    } // VARIABLES
    component LoadFunctions: QtObject {
        id: functions

        function detectCommand(bt, type) {
            console.log("You clicked: " + bt.obj)
            if (type === "workspace")
                return changeWorkspace(bt)
            if (type === "window")
                return console.log(bt.obj + " - nothing yet")
        }

        function changeWorkspace(e) {

            currWorkspace.text = "<pre><font color='" + styles.colors.textB + "'>  " + e.display + "  </pre>"
        }
    } // FUNCTIONS
    component LoadComponents: QtObject {
        // Check Load "Components {}" for the components itselves
    }


    LoadStyles {
        id:styles
    }
    LoadVariables {
        id:variables
    }
    LoadFunctions {
        id:functions
    } //}
    LoadComponents {
        id:components




        component MainApp : GridLayout {
            id: mainApp

            rows: 2
            columns: 1
            anchors.fill: parent
            columnSpacing: 0
            rowSpacing: 0
        }

        component Logo:Text {
            y: -font.pixelSize/3
            property var size:18
            text: "&nbsp; <img src='" + styles.images.logo + "' width='"+size+"' height='"+size+"'></img>"

        }
        component BGimage : Image {
            id: bgPattern

            width: 2000
            height: 2000
            fillMode: Image.Tile
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop
            source: styles.images.bg
            // opacity: 0.05
            Layout.fillWidth: true
            Layout.fillHeight: true
        }

        component WindowCommands : RoundButton {
            radius: 0
            background.visible: false
            icon.height: styles.images.icons.win.size
            icon.width: styles.images.icons.win.size

            icon.source: styles.images.icons.win.url + modelData.obj + ".svg"
            icon.color: this.hovered ? styles.colors.highlight : styles.colors.textB
            onClicked: functions.detectCommand(modelData, "window")
        }

        component Header: Rectangle {
            id: header

            color: styles.colors.header
            Layout.fillWidth: true
            height: 67
            Layout.bottomMargin: 1
        }
        component HeaderTop: GridLayout {
            id:headerTop
            columns: 2
            anchors.fill: parent
            columnSpacing: 0
            rowSpacing: 0
            anchors.bottom: parent.top

        }

        component WorkspaceButton: TabButton {
            //property alias source: image.source

            property var separator: modelData.hasSeparator

            icon.source: styles.images.icons.top.url + modelData.obj + ".svg"
            width: styles.images.icons.top.size + (22 * separator)
            height: width
            icon.color: checked ? styles.colors.highlight : styles.colors.textA
            text: "<font color='" + styles.colors.separator + "'><pre>" + " |" + "</font>"
            font.pointSize: 12
            background.visible: false

        }
    }

    Header {
        id: header

        HeaderTop {
            Row {
                spacing: 10
                Layout.fillWidth: true
                Layout.fillHeight: true
                Layout.topMargin:11

                Logo {
                    size:18
                }

                Repeater {
                    model: ["Game", "Projects", "Maps", "View", "Tools", "Game", "Help", "Debug"]

                    RoundButton {
                        radius: 0
                        height: 13
                        background.visible: false
                        text: "<font color='" + styles.colors.textB + "'>" + modelData
                        font.pointSize: 8
                        Layout.fillWidth: true
                    }
                }
            }
            Row {
                Layout.topMargin: -32

                Repeater {
                
                    model: variables.appButtons.window

                    WindowCommands {
                        onClicked: functions.detectCommand(modelData, "window")
                    }
                }
            }
        }

        Row {
            id:headerBottom

            anchors.bottom: parent.bottom
            Layout.fillWidth: true
            leftPadding: 14

            TabBar {
                id: headerMenu
                spacing: 0
                background.visible: false

                Repeater {

                    model: variables.appButtons.workSpace

                    WorkspaceButton {
                        onClicked: functions.detectCommand(modelData, "workspace")

                    }
                }
            }
        }
    } // HEADER END

    Rectangle {
        id: body

        color: styles.colors.bg
        Layout.fillWidth: true
        Layout.fillHeight: true
        Layout.topMargin: -2

        BGimage {
            opacity:0.05
        }
        TabBar {
            id:openElementslist

            Layout.fillWidth: true
            spacing: 10
            topPadding: 10
            leftPadding: -5
            background.visible: false

            TabButton {
                id: currWorkspace
                height: 30
                enabled: false
                font.pointSize: 8
                text: "<pre><font color='" + styles.colors.textB + "'>  " + "Home" + "  </pre>"
                width: text.length * 3
                background: Rectangle {
                    radius: 3
                    color: styles.colors.header
                    border.color: styles.colors.darkBorders
                    border.width: 1 //"#36373A"
                }
            } // WORKSPACE-TITLE END

            Repeater {

                model: ["MAP0001", "MAP0002", "MAP0003", "MAP0456"]

                TabButton {
                    height: 30
                    font.pointSize: 8
                    icon.source: styles.images.icons.top.url + "mapEditor.svg"
                    icon.color: checked ? styles.colors.highlight : styles.colors.textA
                    icon.height: styles.images.icons.win.size
                    icon.width: styles.images.icons.win.size

                    text: "<pre><font color='" + (checked ? styles.colors.textB : styles.colors.textA) + "'>" + modelData + " "
                    background: Rectangle {
                        radius: 3
                        color: styles.colors.darkBorders
                        border.color: parent.checked ? styles.colors.highlight : styles.colors.header
                        border.width: 1 //"#36373A"
                        Component.onCompleted: console.log(model)
                    }
                } // TESTING DUMMY BUTTONS
            }
        }
    } // BODY END

    Rectangle {
        id: footer

        color: styles.colors.header
        Layout.fillWidth: true
        height: 27
        Layout.bottomMargin: -1

        GridLayout {
            rows: 3
            columns: 2
            anchors.fill: parent
            columnSpacing: 0
            rowSpacing: 0
            anchors.bottom: parent.top

            Text {
                Layout.fillWidth: true
            }
            Text {

                text: "<font color='" + styles.colors.textA + "'>easyRPG.org </font>   ~"
                font.pointSize: 8
            }
        }
    } // FOOTER END
}
