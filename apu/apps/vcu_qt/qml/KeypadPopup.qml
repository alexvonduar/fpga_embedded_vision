import QtQuick 2.7
import QtQuick.Layouts 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick 2.0
Rectangle{
    visible: false
    height: 165
    width: 450
    color: "lightGray"
    anchors.top: parent.verticalCenter
    anchors.topMargin: -20
    anchors.left:parent.horizontalCenter
    anchors.leftMargin: -225
    MouseArea{
        anchors.fill: parent
    }
    property var textToEdit: ""

    Grid {
        anchors.left: parent.left
        anchors.leftMargin: 8
        anchors.top: parent.top
        anchors.topMargin: 15
        columns: 10
        columnSpacing: 4
        rowSpacing: 5

        Repeater{
            model:  ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0","q", "w", "e", "r", "t", "y", "u", "i", "o", "p", "a", "s","d","f", "g", "h", "j", "k", "l", ":", "z", "x", "c", "v", "b","n","m",".","/","<"]
            Button {
                text: modelData
                width: 40
                height: 30
                onClicked: {
                    if("<" != modelData){
                        textToEdit.text = textToEdit.text + modelData
                    }else{
                        textToEdit.text = textToEdit.text.substring(0, textToEdit.text.length-1)
                    }
                }
            }
        }
    }
}
