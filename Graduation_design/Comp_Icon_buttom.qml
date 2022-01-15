import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import "database.js" as DB


Rectangle {
    id: rec

    property alias img_src: icon.source
    property var btn_function: "null"
//    property alias btn_txt: button.text

    property color clr_enter: "#dcdcdc"
    property color clr_exit: "#ffffff"
    property color clr_click: "#aba9b2"
    property color clr_release: "#ffffff"

    //自定义点击信号
    signal clickedLeft()
    signal clickedRight()
    signal release()

    color: "transparent"

//    width: 130
//    height: 130
//    radius: 10

    Image {
        id: icon
        anchors.fill: parent
        anchors.margins: 10
        source: "qrc:/image/mark_transparent.png"
        fillMode: Image.PreserveAspectFit
//        fillMode: Image.Tile
        clip: true

    }

//    Text {
//        id: button
//        text: qsTr("button")

//        anchors.top: icon.bottom
//        anchors.topMargin: 5
//        anchors.horizontalCenter: icon.horizontalCenter
//        anchors.bottom: icon.bottom
//        anchors.bottomMargin: 5

//        font.bold: true
//        font.pointSize: 14
//    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true

        //接受左键和右键输入
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        onClicked: {
            if( btn_function == "word" )
            {
                console.log("hello word")
                swipe_view.currentIndex = 0
            }
            else if( btn_function == "word_list" )
            {
                console.log("hello qml")
                swipe_view.currentIndex = 1
            }
            else if( btn_function == "statistics" )
            {
                console.log("hello qml")
                swipe_view.currentIndex = 2
            }
            else if( btn_function == "account" )
            {
                console.log("hello qml")
                swipe_view.currentIndex = 3
            }
            else
            {
                console.log("no action")

            }
        }

        //按下
        onPressed: {
            color = clr_click
        }

        //释放
        onReleased: {
            color = clr_enter
            color = "transparent"
            parent.release()
            console.log("Release")
        }

        //指针进入
        onEntered: {
            color = clr_enter
//            console.log(button.text + " mouse entered")
        }

        //指针退出
        onExited: {
            color = clr_exit
            color = "transparent"
//            console.log(button.text + " mouse exited")
        }
    }
}

