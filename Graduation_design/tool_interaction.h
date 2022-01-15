#ifndef TOOL_INTERACTION_H
#define TOOL_INTERACTION_H
#include <QDebug>
#include <QString>
#include <Tool_class.h>

class Tool_InterAction : public QObject
{
    Q_OBJECT
public:

    Q_PROPERTY(QString signal_type READ getSignal_type WRITE setSignal_type NOTIFY signal_typeChanged)
    Q_PROPERTY(QString signal_info READ getSignal_info WRITE setSignal_info NOTIFY signal_infoChanged)

    QString signal_type;
    QString signal_info;

    Tool_class tool_class;

    Tool_InterAction() {}


    // tool_1    distribute signal to function
    bool schedule_function();


    QString getSignal_type() const;
    void setSignal_type(const QString &value);

    QString getSignal_info() const;
    void setSignal_info(const QString &value);

    virtual ~Tool_InterAction() {}


signals:
    void signal_typeChanged();
    void signal_infoChanged();

};


#endif // TOOL_INTERACTION_H
