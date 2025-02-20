#ifndef CONTROLLER_H
#define CONTROLLER_H

#include <QObject>
#include <QTimer>
#include <QFile>
#include <QTextStream>
#include <QDebug>

class Controller : public QObject {
    Q_OBJECT
public:
    explicit Controller(QObject *parent = nullptr);
    ~Controller();

    // PWM methods
    Q_INVOKABLE void togglePWM0();
    Q_INVOKABLE void startPWM();
    Q_INVOKABLE void stopPWM();
    Q_INVOKABLE void setDutyCyclePWM0(int percentage);
    Q_INVOKABLE void setPeriod(int periodNs);

    // GPIO methods
    Q_INVOKABLE void turnOnGPIO23();
    Q_INVOKABLE void turnOffGPIO23();
    Q_INVOKABLE void turnOnGPIO24();
    Q_INVOKABLE void turnOffGPIO24();

private:
    // PWM properties
    QString pwm0Path;
    int dutyCyclePWM0;
    int period;
    bool pwm0Running;
    bool increasing;
    QTimer pwm0Timer;

    // GPIO properties
    QString gpio23Path;
    QString gpio24Path;

    // Helper methods
    void writeToFile(const QString &path, const QString &value);
    void updatePWM0();
    void exportGPIO(int gpioNumber);
    void setGPIODirection(int gpioNumber, const QString &direction);
    void setGPIOValue(int gpioNumber, bool value);
};

#endif // CONTROLLER_H
