#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "controller.h"

int main(int argc, char *argv[]) {
    QGuiApplication app(argc, argv);

    // Create the QML application engine
    QQmlApplicationEngine engine;

    // Create an instance of the Controller class
    Controller controller;

    // Expose the Controller instance to QML as a context property
    engine.rootContext()->setContextProperty("backend", &controller);

    // Load the QML file
    const QUrl qmlUrl(QUrl::fromLocalFile("/usr/share/qt-pwm-app/main.qml"));
    //const QUrl qmlUrl(QStringLiteral("qrc:/main.qml"));
    engine.load(qmlUrl);

    // Check if the QML file was loaded successfully
    if (engine.rootObjects().isEmpty()) {
        qWarning() << "Failed to load QML file:" << qmlUrl;
        return -1;
    }

    // Start the application event loop
    return app.exec();
}
