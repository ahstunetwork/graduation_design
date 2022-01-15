import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "database.js" as DB

Page {

//    Rectangle {

//        width: 100
//        height: 40
//        color: "#66ccff"

//        TextInput {
//            anchors.fill: parent
//            id: text_input_search_by_index
//            text: "1"

//            font.pixelSize: 20

//        }

//    }

//    Button {
//        text: "Get Data"
//        anchors.top: parent.top
//        anchors.right: parent.right

//        onClicked: {
//            tabBar.currentIndex = 0
//            var res = DB.readData_by_index( text_input_search_by_index.text  )
//            console.log( res )
//        }

//    }

    Rectangle {
        id: test_rec
        width: parent.width
        height: parent.height
        anchors.bottom: parent.bottom
        color: "#bbffaa"

        Comp_Icon_buttom {
            x: 10
            y: 10
            width: 100
            height: 100
        }


//        Comp_drawer {

//        }

    }

}
