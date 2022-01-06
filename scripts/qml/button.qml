import QtQuick 2.0; 
Rectangle  {
property alias _text: textArea.text
color: "red"; 
implicitWidth: textArea.width+10;
implicitHeight: 20;

Text {
id:textArea
    text: 'newItem'
    anchors.centerIn: parent
}
}
