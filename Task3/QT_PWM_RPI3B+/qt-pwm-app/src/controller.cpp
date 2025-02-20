// Controller.cpp
#include "controller.h"


Controller::Controller(QObject *parent) : QObject(parent),
    dutyCyclePWM0(0), period(20000000),
    pwm0Running(false), increasing(true) {

    // Initialize PWM
    QString pwmChip = "/sys/class/pwm/pwmchip0/";
    pwm0Path = pwmChip + "pwm0/";

    if (!QFile(pwm0Path + "enable").exists()) {
        writeToFile(pwmChip + "export", "0");
    }

    setPeriod(period);
    setDutyCyclePWM0(0);
    writeToFile(pwm0Path + "enable", "1");
   
    pwm0Timer.setInterval(100);
    connect(&pwm0Timer, &QTimer::timeout, this, &Controller::updatePWM0);

    // Initialize GPIO
    exportGPIO(535);
    exportGPIO(536);
    setGPIODirection(535, "out");
    setGPIODirection(536, "out");
    setGPIOValue(535, true); // Initialize GPIO23 to LOW
    setGPIOValue(536, true); // Initialize GPIO24 to LOW
}

Controller::~Controller() {
    // Clean up PWM
    writeToFile(pwm0Path + "enable", "0");
    writeToFile("/sys/class/pwm/pwmchip0/unexport", "0");

    // Clean up GPIO
    setGPIOValue(535, false);
    setGPIOValue(536, false);
    writeToFile("/sys/class/gpio/unexport", "535");
    writeToFile("/sys/class/gpio/unexport", "536");
}

// PWM methods (unchanged)
void Controller::togglePWM0() {
    if (pwm0Running) {
        stopPWM();
    } else {
        startPWM();
    }
}


void Controller::startPWM() {
    if (!pwm0Running) {
        pwm0Timer.start();
        pwm0Running = true;
        qDebug() << "PWM started";
    }
}

void Controller::stopPWM() {
    if (pwm0Running) {
        pwm0Timer.stop();
        pwm0Running = false;
        qDebug() << "PWM stopped";
    }
}

void Controller::setDutyCyclePWM0(int percentage) {
    if (percentage < 0) percentage = 0;
    if (percentage > 100) percentage = 100;
    dutyCyclePWM0 = percentage;
    writeToFile(pwm0Path + "duty_cycle", QString::number((dutyCyclePWM0 * period) / 100));
}

void Controller::setPeriod(int periodNs) {
    period = periodNs;
    writeToFile(pwm0Path + "period", QString::number(periodNs)); // Set PWM0 period
}

void Controller::updatePWM0() {
    if (increasing) {
        dutyCyclePWM0 += 5;
        if (dutyCyclePWM0 >= 100) {
            dutyCyclePWM0 = 100;
            increasing = false;
        }
    } else {
        dutyCyclePWM0 -= 5;
        if (dutyCyclePWM0 <= 0) {
            dutyCyclePWM0 = 0;
            increasing = true;
        }
    }
    setDutyCyclePWM0(dutyCyclePWM0); // Update PWM0 duty cycle
}

// GPIO methods
void Controller::exportGPIO(int gpioNumber) {
    QString exportPath = "/sys/class/gpio/export";
    if (!QFile("/sys/class/gpio/gpio" + QString::number(gpioNumber)).exists()) {
        writeToFile(exportPath, QString::number(gpioNumber));
    }
}

void Controller::setGPIODirection(int gpioNumber, const QString &direction) {
    QString directionPath = "/sys/class/gpio/gpio" + QString::number(gpioNumber) + "/direction";
    writeToFile(directionPath, direction);
}

void Controller::setGPIOValue(int gpioNumber, bool value) {
    QString valuePath = "/sys/class/gpio/gpio" + QString::number(gpioNumber) + "/value";
    writeToFile(valuePath, value ? "1" : "0");
}

// Turn GPIO23 on
void Controller::turnOnGPIO23() {
    setGPIOValue(535, false);
    qDebug() << "GPIO23 turned ON";
}

// Turn GPIO23 off
void Controller::turnOffGPIO23() {
    setGPIOValue(535, true);
    qDebug() << "GPIO23 turned OFF";
}

// Turn GPIO24 on
void Controller::turnOnGPIO24() {
    setGPIOValue(536, false);
    qDebug() << "GPIO24 turned ON";
}

// Turn GPIO24 off
void Controller::turnOffGPIO24() {
    setGPIOValue(536, true);
    qDebug() << "GPIO24 turned OFF";
}

// Helper method (unchanged)
void Controller::writeToFile(const QString &path, const QString &value) {
    QFile file(path);
    if (file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        QTextStream out(&file);
        out << value;
        file.close();
    } else {
        qWarning() << "Failed to write to" << path;
    }
}
