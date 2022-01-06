import QtQuick 2.0; 
Rectangle  {
color: "red"; 
implicitWidth: textArea.width+10;
implicitHeight: 20;

Text {
id:textArea
    text: 'newGuy'
    anchors.centerIn: parent
}
}
