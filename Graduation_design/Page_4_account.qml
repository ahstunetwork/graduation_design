import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import "database.js" as DB


Page {

    FileDialog {
        id: file_dialog
        title: "select a file"
        nameFilters: ["excel(*.xls *.xlsx)"]
        folder: shortcuts.desktop

        onAccepted: {
            tool_interaction.signal_type = "read_excel_to_db"
            tool_interaction.signal_info = fileUrl
        }

    }

    MessageDialog {
        id: about_dlg
        title: "about"

        Label {
            anchors.fill: parent
            text: "time: 2022/1/14/21:25\n"+
                  "tech stack:\n" +
                  "C++/Qt\n"+
                  "JavaScript & Qml\n"+
                  "sql"
            font.pixelSize: Qt.application.font.pixelSize*1.5;
            font.family: "Source Code Pro"

        }

    }

    Rectangle {
        id: page_account_show_user_info_rec
        width: parent.width
        height: parent.height / 3
        anchors.top: parent.top
        color: "#bbffaa"
    }

    Rectangle {

        id: page_account_setting_rec
        width: parent.width
        height: parent.height*2 / 3
        anchors.top: page_account_show_user_info_rec.bottom
        color: "yellow"

        Button {
            id: select_file_btn
            text: "select file(desktop)"
            width: parent.width
            height: parent.height / 7
            anchors.top: parent.top
            onClicked: {
                var file_path = file_dialog.open()
            }
        }
        Button {
            id: setting_btn
            text: "setting"
            width: parent.width
            height: parent.height / 7
            anchors.top: select_file_btn.bottom
        }
        Button {
            id: about_software_btn
            text: "about"
            width: parent.width
            height: parent.height / 7
            anchors.top: setting_btn.bottom

            onClicked: {
                about_dlg.open();

            }

        }
        Button {
            id: exit_proc_btn
            text: "exit"
            width: parent.width
            height: parent.height / 7
            anchors.top: about_software_btn.bottom

            onClicked: {
                Qt.quit();
            }

        }
    }



}
