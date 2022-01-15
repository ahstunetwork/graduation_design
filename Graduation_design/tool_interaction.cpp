#include "Tool_interaction.h"
#include "Tool_class.h"
#include "Word.h"
#include <QDebug>



QString Tool_InterAction::getSignal_type() const
{
    return signal_type;
}

void Tool_InterAction::setSignal_type(const QString &value)
{
    signal_type = value;

    qDebug() << "trigger setSignal_type" << endl;
    qDebug() << signal_type << endl;
}


QString Tool_InterAction::getSignal_info() const
{
    return signal_info;
}

void Tool_InterAction::setSignal_info(const QString &value)
{
    signal_info = value;
    qDebug() << "trigger setSignal_type" << endl;
    qDebug() << signal_info << endl;


    // schedule
    schedule_function();

}



// check signal type to choose a function
bool Tool_InterAction::schedule_function()
{
    qDebug() << "signal_type: " << signal_info;
    if( signal_type == "read_excel_to_db" )
    {
         qDebug() << "read_excel_to_db schedule";

//         tool_class.read_excel_to_db( signal_info );
    }


    return true;
}













