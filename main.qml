import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import QtGraphicalEffects 1.15

ApplicationWindow {
    id: window
    minimumWidth: 360
    minimumHeight: 640
    maximumHeight: minimumHeight
    maximumWidth: minimumWidth
    visible: true
    title: qsTr("Calculator")
    color: "#024873"

    property string currentOperation: ""
    property double firstOperand: 0
    property bool isSecondOperand: false
    property string expression: ""

    property bool secretMenuTriggered: false
    property string inputSequence: ""

    FontLoader {
        id: customFont
        source: "fonts/ofont.ru_Open Sans.ttf"
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 0

        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: parent.height / 3.5
            color: "#04BFAD"
            radius: 20

            Rectangle {
                anchors.top: parent.top
                anchors.right: parent.right
                anchors.left: parent.left
                width: parent.width
                height: parent.height / 2
                color: "#04BFAD"
            }
            Text {
                id: previousText
                color: "#FFFFFF"
                font.family: customFont.name
                font.pixelSize: 30
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: input.top
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                anchors.bottomMargin: 10
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                visible: true
            }
            TextInput {
                id: input
                text: qsTr("0")
                color: "#FFFFFF"
                font.family: customFont.name
                font.pixelSize: 60
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 20
                anchors.rightMargin: 20
                anchors.leftMargin: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
                readOnly: true
                maximumLength: 25

                onTextChanged: {
                    if (input.text.length > 11) {
                        input.font.pixelSize = 50 - (input.text.length - 11)
                    } else {
                        input.font.pixelSize = 50
                    }

                    if (secretMenuTriggered) {
                        inputSequence += input.text[input.text.length - 1];
                        if (inputSequence === "123") {
                            secretMenuPopup.open()
                            secretMenuTriggered = false
                            inputSequence = ""
                            secretInputTimer.stop()
                        }
                    }
                }
            }
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.margins: 20
            GridLayout {
                anchors.centerIn: parent
                columns: 4
                rows: 5
                columnSpacing: 24
                rowSpacing: 24

                // Строка 1

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("()")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        enabled: false
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("+/-")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handlePlusMinus()
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("%")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handlePercentage()
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("÷")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleOperation("/")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }

                // Строка 2

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("7")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("7")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("8")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("8")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("9")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("9")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("x")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleOperation("*")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }

                // Строка 3

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("4")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("4")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("5")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("5")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("6")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("6")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("-")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleOperation("-")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }

                // Строка 4

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("1")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("1")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("2")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("2")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("3")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("3")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("+")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleOperation("+")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#F7E425"
                            else
                                parent.color = "#0889A6"
                        }
                    }
                }

                // Строка 5

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#F25E5E"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("C")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleClear()
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = Qt.lighter("#F25E5E", 0.9)
                            else
                                parent.color = "#F25E5E"
                        }
                    }
                }

                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("0")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleNumberInput("0")
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#B0D1D8"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr(".")
                        color: "#024873"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleDecimalPoint()
                        }
                        onPressedChanged: {
                            if (pressed)
                                parent.color = "#04BFAD"
                            else
                                parent.color = "#B0D1D8"
                        }
                    }
                }
                Rectangle {
                    width: 60
                    height: 60
                    radius: width / 2
                    color: "#0889A6"
                    Text {
                        anchors.centerIn: parent
                        font.pointSize: 20
                        text: qsTr("=")
                        color: "#FFFFFF"
                        font.family: customFont.name
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            handleEquals()
                        }
                        onPressedChanged: {
                            if (pressed) {
                                parent.color = "#F7E425"
                                equalPressTimer.start()
                            } else {
                                parent.color = "#0889A6"
                            }
                        }
                    }
                }
            }
        }
    }

        Popup {
            id: secretMenuPopup
            anchors.centerIn: parent
            width: parent.width * 0.8
            height: parent.height * 0.4
            modal: true
            focus: true
            Rectangle {
                anchors.fill: parent
                color: "#024873"
                radius: 10
                ColumnLayout {
                    anchors.centerIn: parent
                    spacing: 20
                    Text {
                        text: qsTr("Секретное меню")
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        color: "#FFFFFF"
                        font.pixelSize: 30
                    }
                    Button {
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        text: qsTr("Назад")
                        onClicked: {
                            secretMenuPopup.close()
                        }
                    }
                }
            }
        }

        Timer {
            id: equalPressTimer
            interval: 4000
            repeat: false
            onTriggered: {
                secretMenuTriggered = true
                inputSequence = ""
                secretInputTimer.start()
            }
        }

        Timer {
            id: secretInputTimer
            interval: 5000
            repeat: false
            onTriggered: {
                secretMenuTriggered = false
                inputSequence = ""
            }
        }

    function handleNumberInput(number) {
        if (input.text === "0" || input.text === "-0") {
            input.text = number
        } else {
            input.text += number
        }
    }

    function handleDecimalPoint() {
        if (input.text.indexOf(".") === -1) {
            input.text += "."
        }
    }

    function handleClear() {
        input.text = "0"
        previousText.text = ""
        currentOperation = ""
        firstOperand = 0
        isSecondOperand = false
    }

    function handlePlusMinus() {
        if (input.text.startsWith("-")) {
            input.text = input.text.substring(1)
        } else {
            input.text = "-" + input.text
        }
    }

    function handlePercentage() {
        input.text = (parseFloat(input.text) / 100).toString()
    }

    function handleOperation(operation) {
        if (currentOperation !== "" && isSecondOperand) {
            handleEquals()
        }
        firstOperand = parseFloat(input.text)
        currentOperation = operation
        isSecondOperand = true
        previousText.text = firstOperand + " " + currentOperation
        input.text = "0"
    }

    function handleEquals() {
        if (!isSecondOperand) {
            return
        }
        var secondOperand = parseFloat(input.text)
        var result = 0
        switch (currentOperation) {
            case "+":
                result = firstOperand + secondOperand
                break
            case "-":
                result = firstOperand - secondOperand
                break
            case "*":
                result = firstOperand * secondOperand
                break
            case "/":
                result = firstOperand / secondOperand
                break
        }
        input.text = result.toString()
        previousText.text = firstOperand + " " + currentOperation + " " + secondOperand + " = " + result
        currentOperation = ""
        isSecondOperand = false
    }
}
