import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import "database.js" as DB


Page {



    Component.onCompleted: {

        console.log( DB.getindex() )
        console.log( DB.readData_by_index( DB.get_current_DB_index() ) )

        page_word_main_show_word.text = DB.readData_by_index( DB.get_current_DB_index() )[1]

        page_word_main_show_word_info.text =
            "\nINDEX: " + DB.readData_by_index( DB.get_current_DB_index() )[0] +
            "\nWORD: " + DB.readData_by_index( DB.get_current_DB_index() )[1] +
            "\nSOUNDMARK: " +DB.readData_by_index(DB.get_current_DB_index())[2]+
            "\nMEANING: "+DB.readData_by_index( DB.get_current_DB_index())[3]
    }


    Rectangle {
        id: page_word_rec_main
        width: parent.width
        height: parent.height * 9 / 10
//                color: "green"




        Rectangle {

            id: page_word_main_show_word_rec
            color: "green"
            width: parent.width
            height: parent.height * 3 / 15

            Text {
                id: page_word_main_show_word
                anchors.fill: parent

                text: DB.readData_by_index( 100 )[1]


                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter

                font.family: "Source Code Pro"
                font.pixelSize: Qt.application.font.pixelSize * 3


            }
        }





        Rectangle {
            id: page_word_main_show_word_info_rec
            color: "#66ccff"

            width: parent.width
            height: parent.height * 12 / 15

            anchors.bottom:  page_word_rec_main.bottom

            Text {

                id: page_word_main_show_word_info
                anchors.fill: parent

                wrapMode: Text.WordWrap
                text: "情生两端绿野水向南，林深处岁月不流转"
                font.family: "Source Code Pro"
                font.pixelSize: Qt.application.font.pixelSize * 2
                opacity: 0

                MouseArea {
                    anchors.fill: parent
                    onClicked: {
                        console.log("MouseArea Trigger,"+
                                    "X: " + mouseX +
                                    "Y: " + mouseY);
                        page_word_main_show_word_info.opacity = !page_word_main_show_word_info.opacity
                    }
                }


            }

        }
    }




    Rectangle {
        id: page_word_rec_ctrl_btn
        anchors.top: page_word_rec_main.bottom
        width: parent.width
        height: parent.height / 10

        color: "yellow"

        Rectangle {
            width: parent.width/4
            height: parent.height

            anchors.left: parent.left
            id: page_word_btn_prior_rec

            Button {
                anchors.fill: parent
                id: page_word_btn_prior
                text: "上一个"

                onClicked: {

                    DB.set_current_DB_index(DB.get_current_DB_index() - 1)
                    if( DB.get_current_DB_index() >= 1 )
                    {

                        page_word_main_show_word.text = DB.readData_by_index( DB.get_current_DB_index())[1]

                        page_word_main_show_word_info.text =
                            "\nINDEX: " + DB.readData_by_index( DB.get_current_DB_index() )[0] +
                            "\nWORD: " + DB.readData_by_index( DB.get_current_DB_index() )[1] +
                            "\nSOUNDMARK: " +DB.readData_by_index(DB.get_current_DB_index())[2]+
                            "\nMEANING: "+DB.readData_by_index( DB.get_current_DB_index())[3]

                    }

                }

            }

        }

        Rectangle {
            width: parent.width/4
            height: parent.height
            id: page_word_btn_mark_rec

            anchors.left: page_word_btn_prior_rec.right

            Button {

                id: page_word_btn_mark
                anchors.fill: parent
                text: "标记"
            }

        }

        Rectangle {

            width: parent.width/4
            height: parent.height
            id: page_word_btn_kill_rec

            anchors.left: page_word_btn_mark_rec.right
            Button {
                id: page_word_btn_kill
                anchors.fill: parent
                text: "秒杀"
            }
        }


        Rectangle {
            width: parent.width/4
            height: parent.height
            id: page_word_btn_next_rec
            anchors.left: page_word_btn_kill_rec.right

            Button {

                id: page_word_btn_next
                anchors.fill: parent
                text: "下一个"

                onClicked: {

                    DB.set_current_DB_index(DB.get_current_DB_index() + 1)
                    if( DB.get_current_DB_index() >= 1 )
                    {

                        page_word_main_show_word.text = DB.readData_by_index( DB.get_current_DB_index())[1]

                        page_word_main_show_word_info.text =
                            "\nINDEX    : " + DB.readData_by_index( DB.get_current_DB_index() )[0] +
                            "\nWORD     : " + DB.readData_by_index( DB.get_current_DB_index() )[1] +
                            "\nSOUNDMARK: " +DB.readData_by_index(DB.get_current_DB_index())[2]+
                            "\nMEANING  : "+DB.readData_by_index( DB.get_current_DB_index())[3]

                    }

                }
            }
        }

    }

}
