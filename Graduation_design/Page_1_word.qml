import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import QtMultimedia 5.12
import "database.js" as DB


Page {

    Component.onCompleted: {

        console.log( DB.getindex() )
        console.log( DB.readData_by_index( DB.get_current_DB_index() ) )

        page_word_main_show_word.text = DB.readData_by_index( DB.get_current_DB_index() )[1]

        page_word_main_show_word_info.text =
            "\n序号: " + DB.readData_by_index( DB.get_current_DB_index() )[0] +
            "\n单词: " + DB.readData_by_index( DB.get_current_DB_index() )[1] +
            "\n音标: " +DB.readData_by_index(DB.get_current_DB_index())[2]+
            "\n意思: "+DB.readData_by_index( DB.get_current_DB_index())[3]
    }


    Audio {
        id: play_words_audio

        property var audio_src: "null"
        property var word_literay: "null"

        source: "http://dict.youdao.com/dictvoice?audio="+word_literay

//        autoPlay: true
//        loops: 3
    }




    Timer {

        property var is_dictation: false


        id: auto_switch_word_tiemr
        interval: 3000

        running: false
        repeat: true

        onTriggered: {

            var current_index = DB.get_current_DB_index();
            console.log( "auto switch word trigger!, current index="+current_index)

            DB.set_current_DB_index( current_index + 1)
            current_index = DB.get_current_DB_index();

            var word_literacy;

            if( current_index >= 1 )
            {

                page_word_main_show_word.text = DB.readData_by_index( current_index)[1]
                word_literacy = DB.readData_by_index( current_index )[1]
                page_word_main_show_word_info.text =
                    "\序号: " + DB.readData_by_index( current_index )[0] +
                    "\n单词: " + DB.readData_by_index( current_index)[1] +
                    "\n音标: " +DB.readData_by_index(current_index)[2]+
                    "\n意思: "+DB.readData_by_index( current_index)[3]
            }
            if( is_dictation === true )
            {
                play_words_audio.audio_src = "http://dict.youdao.com/dictvoice?audio="
                play_words_audio.word_literay = word_literacy
                play_words_audio.play()
                console.log(word_literacy)
            }
        }

    }

    Dialog {
        id: switch_study_mode_dialog
        title: "Setting"
        height: main_window.height/3

        property var is_auto_switch_word: false

        ComboBox {
            id: select_study_mode_to_switch

            width: parent.width/2
            height: 50

            currentIndex: 0
            textRole: "mode"
            font.family: "Source Code Pro"
            font.pixelSize: Qt.application.font.pixel
//            flat: true
            anchors.margins: 20

            model: ListModel {
                ListElement{ mode:"看词说意"}
                ListElement{ mode:"看意说词"}
                ListElement{ mode:"自动过词"}
                ListElement{ mode:"读词听写"}
                ListElement{ mode:"隐藏footer"}
//                ListElement{ mode:"看词说意"}
            }

            onCurrentIndexChanged: {
            }
        }

        Slider
        {
            id: word_switch_speed_slider
            width: parent.width/2
            height: 50


            from: 1
            to: 9
            stepSize: 1
            value: 3

            anchors.top: select_study_mode_to_switch.bottom
            anchors.margins: 20

            onValueChanged:
            {
                auto_switch_word_tiemr.interval = value*1000
//                word_switch_show_label_tip.text = "速率:"+3+" s/w"

            }
        }

        RadioButton {
            id: radio_btn_1
            text: "增加"
            width: switch_study_mode_dialog.width/4
            height: 50

            anchors.top: switch_study_mode_dialog.top
            anchors.left: select_study_mode_to_switch.right
            anchors.topMargin: 20
            anchors.bottomMargin: 20
        }
        RadioButton {
            text: "减少"
            width: switch_study_mode_dialog.width/4
            height: 50

            anchors.top: switch_study_mode_dialog.top
            anchors.left:radio_btn_1.right
            anchors.topMargin: 20
            anchors.bottomMargin: 20
        }


        Label {
            id: word_switch_show_label_tip
            width: parent.width/2
            height: 50

            anchors.left: word_switch_speed_slider.right
            anchors.top: select_study_mode_to_switch.bottom
            anchors.margins: 20

            Text {
                anchors.centerIn: parent

                text: "速率:"+word_switch_speed_slider.value+" s/w"
                font.family: "Source Code Pro"
                font.pixelSize: Qt.application.font.pixel*2
            }
        }

        Button {
            id: hide_footer_btn
            width: parent.width*2/5
            height: 50

            anchors.top: word_switch_speed_slider.bottom
            anchors.left: word_switch_speed_slider.left

            anchors.margins: 20
//            anchors.topMargin: 20
//            anchors.bottomMargin: 20
            text: "开启/隐藏footer"
            onClicked: {
                tabBar.visible = !tabBar.visible
            }
        }

        Button {
            id: refresh_db_and_page_btn
            width: parent.width/3
            height: 50

            anchors.top: word_switch_speed_slider.bottom
            anchors.left: hide_footer_btn.right

            anchors.margins: 20
//            anchors.topMargin: 20
//            anchors.bottomMargin: 20
            text: "刷新数据"
            onClicked: {
                page_word_main_show_word.text = DB.readData_by_index( DB.get_current_DB_index() )[1]

                page_word_main_show_word_info.text =
                    "\n序号: " + DB.readData_by_index( DB.get_current_DB_index() )[0] +
                    "\n单词: " + DB.readData_by_index( DB.get_current_DB_index() )[1] +
                    "\n音标: " +DB.readData_by_index(DB.get_current_DB_index())[2]+
                    "\n意思: "+DB.readData_by_index( DB.get_current_DB_index())[3]


            }

        }









        standardButtons: Dialog.Reset | Dialog.Ok |Dialog.Cancel
        onAccepted: {
            var study_mode = select_study_mode_to_switch.currentText


            if( study_mode === "看词说意")
            {
                page_word_show_study_mode.text = "学习方式:"+study_mode
            }
            else if( study_mode === "看意说词")
            {
                page_word_show_study_mode.text = "学习方式:"+study_mode
            }
            else if( study_mode === "自动过词" )
            {
                page_word_show_study_mode.text = "学习方式:"+study_mode
                if( is_auto_switch_word === false )
                {
                    auto_switch_word_tiemr.running = true

                }
                else
                {
                    auto_switch_word_tiemr.running = false
                }



                is_auto_switch_word = !is_auto_switch_word;

            }
            else if( study_mode === "隐藏footer" )
            {
                tabBar.visible = !tabBar.visible
            }
            else if( study_mode === "读词听写" )
            {
                page_word_show_study_mode.text = "学习方式:"+study_mode
                if( is_auto_switch_word === false )
                {
                    auto_switch_word_tiemr.running = true
//                    play_words_audio.play()
                }
                else
                {
                    auto_switch_word_tiemr.running = false
                }

                is_auto_switch_word = !is_auto_switch_word;
                auto_switch_word_tiemr.is_dictation = !auto_switch_word_tiemr.is_dictation

            }


        }

    }


    Image {
        id: page_word_background
        source: "qrc:/image/pic_5_phone.jpg"
        anchors.fill: parent
    }


    Rectangle {
        id: page_word_rec_main
        width: parent.width
        height: parent.height * 9 / 10
        color: "transparent"





        Rectangle {
            id: page_word_main_show_mode_rec
            color: "transparent"
//            opacity: 1
            width: parent.width
            height: parent.height * 2 / 15
            anchors.top: parent.top

            Rectangle {
                width: parent.width*11/13
                height: parent.height*2/3

                anchors.top: parent.top
                anchors.left: parent.left
                color: "transparent"

                Label {
//                    anchors.fill: parent
                    id: page_word_show_study_mode
                    anchors.centerIn: parent

                    text: "学习方式:看词说义"
                    font.pixelSize: Qt.application.font.pixelSize*2
                    font.family: "Source Code Pro"

                }
            }


            Comp_Icon_buttom {

                width: parent.width*2/13
                height: parent.height*2/3
                anchors.top: parent.top
                anchors.right: parent.right
                image_path: "qrc:/image/setting.svg"
                btn_function: "switch_study_mode"


            }


        }


        Rectangle {

            id: page_word_main_show_word_rec
            color: "transparent"
            width: parent.width
            anchors.top: page_word_main_show_mode_rec.bottom
            height: parent.height * 3 / 15

//            Image {
//                id: page_word_main_show_word_background
//                source: "qrc:/image/pic_1.jpg"
//                anchors.fill: parent
//            }

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
            color: "transparent"
//            Image {
//                id: page_word_main_show_word_info_background
//                source: "qrc:/image/tager_background.jpg"
//                anchors.fill: parent

//            }

            width: parent.width
            height: parent.height * 10 / 15

            anchors.bottom:  page_word_rec_main.bottom

            Text {

                id: page_word_main_show_word_info
                anchors.fill: parent

                wrapMode: Text.WordWrap
                text: "null"
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

        color: "transparent"

        Rectangle {
            width: parent.width/4
            height: parent.height

            anchors.left: parent.left
            id: page_word_btn_prior_rec
            color: "transparent"

            Comp_Icon_buttom {
                anchors.fill: parent
                id: page_word_btn_prior
//                text: "上一个"
                btn_function: "word_prior"
                image_path: "qrc:/image/left_tr.png"

            }

        }

        Rectangle {
            width: parent.width/4
            height: parent.height
            id: page_word_btn_mark_rec
            color: "transparent"

            anchors.left: page_word_btn_prior_rec.right

            Comp_Icon_buttom {

                id: page_word_btn_mark
                anchors.fill: parent
//                text: "标记"
                image_path: "qrc:/image/mark_tr.png"

            }

        }

        Rectangle {

            width: parent.width/4
            height: parent.height
            id: page_word_btn_kill_rec
            color: "transparent"

            anchors.left: page_word_btn_mark_rec.right
            Comp_Icon_buttom {
                id: page_word_btn_kill
                anchors.fill: parent
                image_path: "qrc:/image/success_tr.png"
//                text: "秒杀"
            }
        }


        Rectangle {
            width: parent.width/4
            height: parent.height
            id: page_word_btn_next_rec
            anchors.left: page_word_btn_kill_rec.right
            color: "transparent"

            Comp_Icon_buttom {

                id: page_word_btn_next
                anchors.fill: parent
//                text: "下一个"

                btn_function: "word_next"
                image_path: "qrc:/image/right_tr.png"


            }
        }
    }
}



