import QtQuick 2.0;
import calamares.slideshow 1.0;

Presentation
{
    id: presentation

    Timer {
        interval: 5000
        running: true
        repeat: true
        onTriggered: presentation.goToNextSlide()
    }

    Slide {
        Image { source: "slide1.png"; anchors.centerIn: parent }
        Text {
            text: "به PCADIB OS خوش آمدید"
            font.pixelSize: 28
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.verticalCenter
        }
    }
    Slide {
        Text {
            text: "می‌توانید نصب‌کننده‌های ویندوز (.exe) را با Wine اجرا کنید"
            font.pixelSize: 24
            anchors.centerIn: parent
            wrapMode: Text.WordWrap
            width: parent.width * 0.8
            horizontalAlignment: Text.AlignHCenter
        }
    }
    Slide {
        Text {
            text: "نصب PCADIB OS در حال آماده‌سازی سیستم شماست..."
            font.pixelSize: 24
            anchors.centerIn: parent
            wrapMode: Text.WordWrap
            width: parent.width * 0.8
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
