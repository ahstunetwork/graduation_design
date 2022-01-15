import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import "database.js" as DB

Page {
    Rectangle {
        width: parent.width
        height: parent.height / 10

        anchors.top: parent.top



        Rectangle {
            id: page_word_list_Title_rec
            width: parent.width*3/5
            height: parent.height
            anchors.left: parent.left
            color: "green"

            Label {
                width: parent.width
                height: parent.height
                anchors.fill: parent

                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                text: "Word List"
                font.family: "Source Code Pro"
                font.pixelSize: Qt.application.font.pixel*3
            }

        }


        Rectangle {
            id: page_word_list_ComboBox_rec
            width: parent.width*2/5
            height: parent.height
            anchors.right: parent.right
            opacity: 1

            ComboBox {
                id: page_word_list_ComboBox

                width: parent.width
                height: parent.height
                currentIndex: 0
                textRole: "text"
                font.family: "Source Code Pro"
                font.pixelSize: Qt.application.font.pixel*2

                model: ListModel {
                    id: page_word_list_ComboBox_listModel
                    ListElement { text: "Show List" ; color: "yellow" }
                    ListElement { text: "Add New"  ; color: "red" }

                    ListElement { text: "Delete"  ; color: "red" }
                    ListElement { text: "Import"; color: "brown" }
                }
                onCurrentIndexChanged: {
                    console.debug( page_word_list_ComboBox_listModel.get(currentIndex).text + ","
                                 + page_word_list_ComboBox_listModel.get(currentIndex).color)
                }
            }
        }



    }


    Rectangle {

        id: page_word_list_main_rec

        width: parent.width
        height: parent.height * 9 / 10
        color: "#66ccff"
        anchors.bottom: parent.bottom

        ScrollView {
            anchors.fill: parent

            ListView {
                width: parent.width
                model: 20
                delegate: ItemDelegate {
                    text: "Item " + (index + 1)
                    width: parent.width
                }
            }
        }
    }
}
