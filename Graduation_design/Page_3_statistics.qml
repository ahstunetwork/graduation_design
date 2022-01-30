import QtQuick 2.12
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import Tool_InterAction 1.0
import QtQuick.LocalStorage 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12
import "database.js" as DB
import "tools_func.js" as TF
import QtCharts 2.3
import QtGraphicalEffects 1.0

Page {

    Rectangle {
        id: page_3_statistics_btn_rec
        width: parent.width
        height: parent.height/4
        color: "white"


        ButtonGroup {
            id: page_chart_btn_group
        }




        RadioButton {
            id: radio_button_line_series

            width: parent.width/3
                        height: 50
            anchors.left: parent.left
            anchors.top: parent.top
//            anchors.margins: 20

            text: "统计折线图"
            ButtonGroup.group: page_chart_btn_group
            onClicked: {
//                    spline_series_chart.visible = ! spline_series_chart.visible
                chart_view_line_series.append(TF.to_msec_since_epoic( new Date(2019,TF.test_count,TF.test_count) ),10+TF.test_count++)
                date_time_chart_view.scrollRight(2)
            }
        }
        RadioButton {
            id: radio_button_bar_chart

            width: parent.width/3
            height: 50
            anchors.left: parent.left
            anchors.top: radio_button_line_series.bottom
//            anchors.margins: 20

            text: "统计柱状图"
            ButtonGroup.group: page_chart_btn_group
            onClicked: {
//                    bar_chart.visible = !bar_chart.visible
                chart_view_line_series.replace(TF.to_msec_since_epoic( new Date(2019,0,4) )
                                               ,18,TF.to_msec_since_epoic( new Date(2019,0,4) ),28)

            }
        }
        RadioButton {
            id: radio_button_pie_chart

            width: parent.width/3
            height: 50
            anchors.left: parent.left
            anchors.top: radio_button_bar_chart.bottom
//            anchors.margins: 20

            text: "统计饼图"
            ButtonGroup.group: page_chart_btn_group

            onClicked: {
                date_time_chart_view.visible = !date_time_chart_view.visible
            }
        }

        Button {
            id: btn_1
            text: "BTN1"
            width: parent.width/3
            height: 50

            anchors.top: parent.top
            anchors.right: parent.right
        }

        ComboBox {
            id: chart_style_comboBox

            textRole: "style_name"
            width: parent.width/3
            height: 50

            anchors.top: btn_1.bottom
            anchors.right: parent.right

            model: ListModel {
                id: chart_style_comboBox_model
                ListElement {
                    style_name: "浅色"
                    style_str: "ChartView.ChartThemeLight"
                }
                ListElement {
                    style_name: "天蓝色"
                    style_str: "ChartView.ChartThemeBlueCerulean"
                }
                ListElement {
                    style_name: "深色"
                    style_str: "ChartView.ChartThemeDark"
                }
                ListElement {
                    style_name: "沙褐色"
                    style_str: "ChartView.ChartThemeBrownSand"
                }
                ListElement {
                    style_name: "自然色NCS"
                    style_str: "ChartView.ChartThemeBlueNcs"
                }
                ListElement {
                    style_name: "高对比度"
                    style_str: "ChartView.ChartThemeHighContrast"
                }
                ListElement {
                    style_name: "冰蓝色"
                    style_str: "ChartView.ChartThemeBlueIcy"
                }
                ListElement {
                    style_name: "Qt"
                    style_str: "ChartView.ChartThemeQt"
                }


            }

            onCurrentIndexChanged: {
                console.log( chart_style_comboBox_model.get(currentIndex).style_str );
//                date_time_chart_view.theme = chart_style_comboBox_model.get(currentIndex).style;
                if( chart_style_comboBox_model.get( currentIndex).style_name === "浅色" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeLight;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "天蓝色" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeBlueCerulean;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "深色" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeDark;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "沙褐色" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeBrownSand;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "自然色NCS" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeBlueNcs;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "高对比度" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeHighContrast;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "冰蓝色" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeBlueIcy;
                }
                else if( chart_style_comboBox_model.get( currentIndex).style_name === "Qt" )
                {
                    date_time_chart_view.theme = ChartView.ChartThemeQt;
                }

            }
        }

        Button {
            id: btn_flush_chart
            text: "刷新"
            width: parent.width/3
            height: 50

            anchors.top: chart_style_comboBox.bottom
            anchors.right: parent.right

            onClicked: {
                chart_view_line_series.clear()
                var date_time_arr = DB.get_all_info_from_statistics_table();
                for( var i = 0; i < date_time_arr.length; i++ )
                {
                    console.log("=============================")
                    console.log( date_time_arr[i][0]
                                + " "
                                + date_time_arr[i][1]
                                + " "
                                + date_time_arr[i][2] );
                    chart_view_line_series.append(
                                TF.to_msec_since_epoic( new Date( (date_time_arr[i][1] ))) , date_time_arr[i][2] )

                }
            }
        }

    }

    //test
    Timer {
        id: test_timer
        running: false
        interval: 1000
        repeat: true

        onTriggered: {
            console.log( Math.random()*30 )
            chart_view_line_series.append(TF.to_msec_since_epoic( new Date(2019,0,TF.test_count++) ),Math.random()*30)
            date_time_chart_view.scrollRight(20)
//            chart_view_line_series.replace()
//            date_time_chart_view.
        }
    }


    Rectangle {
        id: page_3_statistics_chart_rec
        width: parent.width
        height: parent.height*3/4
//        color: "#bbffaa"
        anchors.top: page_3_statistics_btn_rec.bottom



        ChartView {
            id: date_time_chart_view
            title: "line_series"
            anchors.fill: parent
            antialiasing: true

            theme: ChartView.ChartThemeBlueCerulean

            visible: true

            DateTimeAxis {
                id: axisX_date_time
                format: "MM-dd"
//                orientation:
                tickCount: 10
                min: new Date( "2022-01-24" )
                max: new Date( "2022-01-30" )
            }

            ValueAxis {
                id: axis_Y
                min: 0
                max: 100
                tickCount: 10
            }

            LineSeries {
                id: chart_view_line_series
                name: "lineseries"
                axisX: axisX_date_time
                axisY: axis_Y

                Component.onCompleted: {
                    console.log( "list Series: hello world")

                    var date_time_arr = DB.get_all_info_from_statistics_table();
                    for( var i = 0; i < date_time_arr.length; i++ )
                    {
                        console.log("=============================")
                        console.log( date_time_arr[i][0]
                                    + " "
                                    + date_time_arr[i][1]
                                    + " "
                                    + date_time_arr[i][2] );
                        chart_view_line_series.append(
                                    TF.to_msec_since_epoic( new Date( (date_time_arr[i][1] ))) , date_time_arr[i][2] )


                    }

                }

//                XYPoint {
//                    x: TF.to_msec_since_epoic( new Date("2019-01-01".replace(/-/g,'/')  ) )
//                    y: 6
//                }
//                XYPoint {
//                    x: TF.to_msec_since_epoic( new Date("2019-01-04".replace(/-/g,'/') ) )
//                    y: 18
//                }
//                XYPoint {
//                    x: TF.to_msec_since_epoic( new Date(2019,0,9) )
//                    y: 30
//                }
            }

        }







//        MouseArea {
//            anchors.fill: parent
//            onClicked: {
//                axisX.applyNiceNumbers()
//            }
//        }





    }



}
