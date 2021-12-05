import QtQuick 2.7
import QtQuick.Layouts 1
import QtQuick.Controls 2.15
import org.kde.kirigami 2.4 as Kirigami
//import "https://raw.githubusercontent.com/jetrotal/easyRPG_layout/main/js/test.qml"

GridLayout {

    //VARIABLES SETUP {

    property var appButtons: {
        "workSpace":[ {
            obj:"appHome", hasSeparator:1, display:"Home", action:""
        }, {
            obj:"mapEditor", hasSeparator:0, display:"Map Editor", action:""
        }, {
            obj:"databaseEditor", hasSeparator:0, display:"Database Editor", action:""
        }, {
            obj:"eventsEditor", hasSeparator:1, display:"Events Editor", action:""
        }, {
            obj:"resourceManager", hasSeparator:0, display:"Resource Manager", action:""
        }, {
            obj:"gameSearch", hasSeparator:1, display:"Search", action:""
        }, {
            obj:"bgmTest", hasSeparator:1, display:"BGM test", action:""
        }, {
            obj:"gameSettings", hasSeparator:0, display:"Playtest Settings", action:""
        }, {
            obj:"gamePlay", hasSeparator:0, display:"Begin Playtest", action:""
        }],
        "window":[ {
            obj:"min", action:""
        },
            {
                obj:"max", action:""
            },
            {
                obj: "close", action:""
            }],
        "header":[{
            /*TODO DYNAMIC HEADER MENU*/
        }]
    };//

    property var assets: "https://raw.githubusercontent.com/jetrotal/easyRPG_layout/main/"

    property var colors: {
        "bg":"#292b2f",
        "header":"#242529",
        "textA":"#97999C",
        "textB":"#FFF",
        "highlight":"#8AFF4E",
        "separator":"#555",
        "darkBorders":"#1e1e1e"
    }

    property var images: {
        "logo":assets + "img/ez-logo.svg",
        "bg":assets + "img/bg/tile.svg",
        "icons": {
            "win": {
                "url":assets + "img/icons/window/", size:16
            },
            "top": {
                "url":assets + "img/icons/top/", size:39
            }
        },


    }

    function identifyButton(bt,type) {
        console.log("You clicked: " + bt.obj)
        if (type =="workspace") return changeWorkspace(bt)
        if (type =="window") return console.log(bt.obj +" - nothing yet")
    }

    function changeWorkspace(e) {

        currWorkspace.text = "<pre><font color='"+colors.textA+"'>  "+e.display+"  </pre>"
    }

    //}

    id : root
    rows : 2
    columns : 1
    anchors.fill : parent
    columnSpacing : 0
    rowSpacing : 0

    Rectangle {
        id : header
        color : colors.header
        Layout.fillWidth : true
        height : root.height / root.rows /6.5

        GridLayout {
            rows : 2
            columns : 2
            anchors.fill : parent
            columnSpacing : 0
            rowSpacing : 0
            anchors.bottom: parent.top

            Row {
                spacing:10
                Layout.fillWidth : true

                Text {

                    text:"&nbsp; <img src='"+ images.logo + "' width='18' height='18'></img>"
                    font.pointSize: 8
                    font.family: "Helvetica"
                    color: "white"
                    Layout.fillWidth : true
                }


                Repeater {
                    model : ["Game","Projects","Maps","View","Tools","Game","Help","Debug"]

                    RoundButton {
                        radius:0
                        height:13
                        background.opacity:0
                        text:"<font color='"+colors.textB+"'>"+modelData
                        font.pointSize: 8
                        Layout.fillWidth : true
                    }
                }
            }
            Row {
                Layout.topMargin:-10
                Repeater {
                    model : appButtons.window

                    RoundButton {
                        radius:0;
                        background.opacity : 0
                        icon.height:images.icons.win.size
                        icon.width:images.icons.win.size

                        icon.source:images.icons.win.url + modelData.obj + ".svg"
                        icon.color : this.hovered ? colors.highlight : colors.textB
                        onClicked: root.identifyButton(modelData,"window")



                    }



                }
                Text {
                    text:" "
                }
            }
            Text {} // Hack to fix the grid Layout



        }

        Layout.bottomMargin:1
        Row {
            anchors.bottom: parent.bottom
            Layout.fillWidth : true
            leftPadding:14

            TabBar {
                id:headerMenu
                spacing: 0
                background.opacity : 0


                Repeater {

                    model :appButtons.workSpace

                    TabButton {
                        property var separator: modelData.hasSeparator

                        icon.source :images.icons.top.url + modelData.obj + ".svg"
                        width : images.icons.top.size + (22 *separator)
                        height : width
                        icon.color : checked ? colors.highlight : colors.textA
                        text:"<font color='"+colors.separator+"'><pre>"+" |"+"</font>"
                        font.pointSize: 12
                        background.opacity : 0
                        onClicked: root.identifyButton(modelData,"workspace")
                    }
                }
            }
        }

    }// HEADER END

    Rectangle {
        id : body
        color : colors.bg
        Layout.fillWidth : true
        Layout.fillHeight : true
        Layout.topMargin:-2

        Image {
            id:bgPattern

            width: 2000; height: 2000
            fillMode: Image.Tile
            horizontalAlignment: Image.AlignLeft
            verticalAlignment: Image.AlignTop
            source: images.bg
            opacity:0.05
            Layout.fillWidth : true
            Layout.fillHeight : true
        }
        TabBar {
            Layout.fillWidth : true
            spacing:10
            topPadding:10; leftPadding:-5
            background.opacity:0

            TabButton {
                id:currWorkspace
                height:30
                enabled:false
                font.pointSize: 9
                text:"<pre><font color='"+colors.textA+"'>  "+"Home"+"  </pre>"
                width: text.length *3
                background:Rectangle {
                    radius:3; color:colors.header
                    border.color:colors.darkBorders; border.width:1; //"#36373A"
                }
            } // WORKSPACE-TITLE END

            
                Repeater {

                    model :["MAP0001", "MAP0002","MAP0003","MAP0456",   ]

            TabButton {
                height:30
                font.pointSize: 9
                icon.source :images.icons.top.url+"mapEditor.svg"
                icon.color : checked ? colors.highlight : colors.textA
                text:"<pre><font color='"+(checked ? colors.textB : colors.textA)+"'>"+modelData+" "
                background:Rectangle {
                    radius:3; color:colors.darkBorders
                    border.color:parent.checked ? colors.highlight: colors.header
                    border.width:1; //"#36373A"
                }
            } // TESTING DUMMY BUTTONS
            }
        }


    } // BODY END

    Rectangle {
        id : footer

        color : colors.header
        Layout.fillWidth : true
        height : root.height / root.rows / 15
        Layout.bottomMargin:-1

        GridLayout {
            rows : 3
            columns : 2
            anchors.fill : parent
            columnSpacing : 0
            rowSpacing : 0
            anchors.bottom: parent.top

            Text {
                Layout.fillWidth : true

            }
            Text {

                text:"<font color='"+colors.textA+"'>easyRPG.org </font>   ~"
                font.pointSize: 8
                opacity:0.2
            }


        }
    } // FOOTER END
}
