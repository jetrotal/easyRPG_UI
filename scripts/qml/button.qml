import QtQuick 2.0; 
Rectangle  {
color: "red"; 
implicitWidth: this.textArea.width;
implicitHeight: 20;

Text {
id:textArea
    text: 'newTest'
    anchors.centerIn: parent
}
}
