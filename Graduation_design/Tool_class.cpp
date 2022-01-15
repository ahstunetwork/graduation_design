#include "Tool_interaction.h"
#include "Tool_class.h"
#include "Word.h"
#include <QAxObject>
#include <iomanip>
#include <iostream>
#include <QSqlDatabase>
#include <QMessageBox>
#include <QSqlQuery>


QString Tool_class::getSignal_type() const
{
    return signal_type;
}

void Tool_class::setSignal_type(const QString &value)
{
    signal_type = value;
}

void Tool_class::read_excel_to_db(QString file_path_qml)
{
    if( file_path_qml.isEmpty() )
    {
        qDebug() << "you have not choose any excel file !";
        return;
    }

    QVector<Word> word_vec;

//    file_path_qml = "C:/Code/resource/word_list_test.xlsx";
    if( file_path_qml.isNull() )
    {
        return;
    }

    QString filePath = file_path_qml;

    QAxObject excel("Excel.Application");
    excel.setProperty("Visible", false);
    QAxObject *work_books = excel.querySubObject("WorkBooks");
    work_books->dynamicCall("Open (const QString&)", filePath);
    QAxObject *work_book = excel.querySubObject("ActiveWorkBook");
    QAxObject *work_sheets = work_book->querySubObject("Sheets");  //Sheets也可换用WorkSheets

    int sheet_count = work_sheets->property("Count").toInt();  //获取工作表数目
    if(sheet_count > 0)
    {
        QAxObject *work_sheet = work_book->querySubObject("Sheets(int)", 1);
        QAxObject *used_range = work_sheet->querySubObject("UsedRange");

        QAxObject *rows = used_range->querySubObject("Rows");
        int row_count = rows->property("Count").toInt();  //获取行数
        QAxObject *cols = used_range->querySubObject("Columns");
        int col_count = cols->property("Count").toInt();  //获取列数



        qDebug() << "rows:" << row_count << "  cols: " << col_count;

        int word_count = 0;
        for( int i = 1; i < row_count; i++ )
        {
            Word word_temp;
            ++ word_count;

            int index_ = word_count;
//                int index_ = work_sheet->querySubObject("Cells(int,int)", i, 1)->property("Value").toInt();
            QString word_ = work_sheet->querySubObject("Cells(int,int)", i, 1)->property("Value").toString();
            QString soundmark_ = work_sheet->querySubObject("Cells(int,int)", i, 2)->property("Value").toString();
            QString meaning_ = work_sheet->querySubObject("Cells(int,int)", i, 3)->property("Value").toString();

            word_temp.setIndex(index_);
            word_temp.setWord( word_ );
            word_temp.setSoundmark(soundmark_);
            word_temp.setMeaning(meaning_);
            word_temp.setStudy_count( 0 );
            word_temp.setIs_marked( false );


            word_vec.push_back( word_temp );
        }

        for( int i = 0; i < word_vec.size() ; i++ )
        {
//            std::cout << "hello world" << endl;
            qDebug() << "vec[" << i << "]"
                     << word_vec.at(i).getIndex()
                     << word_vec.at(i).getWord()
                     << word_vec.at(i).getSoundmark()
                     << word_vec.at(i).getMeaning()
                     << word_vec.at(i).getStudy_count()
                     << word_vec.at(i).getIs_marked();
        }
        work_book->dynamicCall("Close(Boolean)", false);  //关闭文件
        excel.dynamicCall("Quit(void)");  //退出
    }


    create_db_table( "word_list_unorder" );

    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("word_list.sqlite");


    // check flag to decide create table
//    if(  true  )
//    {
//        create_db_table( "mytable" );
//    }

    db.open();
    if( ! db.isOpen() )
    {
//        QMessageBox msgbox("error","open database error");
        qDebug() << "database not open";
        return;
    }
    QSqlQuery query;

    for( int i = 0; i < word_vec.size(); i++ )
    {
        QString sql_str = QString("INSERT INTO word_list_unorder VALUES("
                          "%1,\"%2\",\"%3\",\"%4\",%5,\"%6\")").arg(word_vec.at(i).getIndex())
                .arg(word_vec.at(i).getWord())
                .arg(word_vec.at(i).getSoundmark())
                .arg(word_vec.at(i).getMeaning())
                .arg(word_vec.at(i).getStudy_count())
                .arg(word_vec.at(i).getIs_marked());
        qDebug() << sql_str;

        if( query.exec( sql_str ) )
        {
            qDebug() << "No." << i << " sql exec success";

        }
        else {
            qDebug() << "sql exec failure";
        }
    }
    db.close();

    return;
}

void Tool_class::create_db_table(QString db_table_name)
{
    // create table
    QSqlDatabase db = QSqlDatabase::addDatabase("QSQLITE");
    db.setDatabaseName("word_list.sqlite");
    db.open();
    if( ! db.isOpen() )
    {
//        QMessageBox msgbox("error","open database error");
        return;
    }

    QString sql_str = "CREATE TABLE " +
                      db_table_name +
                      "( "
                      "word_index INT,"
                      "word VARCHAR,"
                      "soundmark VARCHAR,"
                      "meaning VARCHAR,"
                      "study_count INT,"
                      "is_marked bool)";

    QSqlQuery query;
    qDebug() << sql_str;
    if( query.exec( sql_str ) )
    {
        qDebug() << "create_table success";
    }
    else {
        qDebug() << "create_table failure";
    }
    db.close();
}
