function initQMLloader(target) {
        const qml = new QmlOnline("qmlonline")
        qml.registerCall({
            qmlMessage: function(msg) {
                console.log(`qml message: ${msg}`)
            },
            qmlError: function(data) {
                console.log(`qml error: ${JSON.stringify(data)}`)
            },
            posInit: function() {
                qml.setCode(target)
            },
        })
        qml.init()
        }
