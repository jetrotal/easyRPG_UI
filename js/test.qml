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
