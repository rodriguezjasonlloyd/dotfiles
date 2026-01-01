import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
    PanelWindow {
        color: "#1e1e1e"
        id: panel
        implicitHeight: 24

        anchors {
            left: true
            right: true
            top: true
        }

        property int cpuUsage: 0
        property int memUsage: 0
        property var lastCpuIdle: 0
        property var lastCpuTotal: 0

        Process {
            id: cpuProc
            command: ["sh", "-c", "head -1 /proc/stat"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) {
                        return
                    }

                    var p = data.trim().split(/\s+/)
                    var idle = parseInt(p[4]) + parseInt(p[5])
                    var total = p.slice(1, 8).reduce((a, b) => a + parseInt(b), 0)
                    if (panel.lastCpuTotal > 0) {
                        panel.cpuUsage = Math.round(100 * (1 - (idle - panel.lastCpuIdle) / (total - panel.lastCpuTotal)))
                    }
                    panel.lastCpuTotal = total
                    panel.lastCpuIdle = idle
                }
            }
            Component.onCompleted: running = true
        }

        Process {
            id: memProc
            command: ["sh", "-c", "free | grep Mem"]
            stdout: SplitParser {
                onRead: data => {
                    if (!data) return
                    var parts = data.trim().split(/\s+/)
                    var total = parseInt(parts[1]) || 1
                    var used = parseInt(parts[2]) || 0
                    panel.memUsage = Math.round(100 * used / total)
                }
            }
            Component.onCompleted: running = true
        }

        Timer {
            interval: 2000
            running: true
            repeat: true
            onTriggered: {
                cpuProc.running = true
                memProc.running = true
            }
        } 

        Row {
            anchors.left: parent.left
            anchors.leftMargin: 4
            anchors.verticalCenter: parent.verticalCenter
            spacing: 4

            Repeater {
                model: NiriWorkspaceMonitor.workspaces

                Rectangle {
                    color: "#1e1e1e"
                    implicitHeight: 16
                    implicitWidth: 16
                    Text {
                        anchors.centerIn: parent
                        text: modelData.idx
                        color: "white"
                        font.bold: modelData.is_active
                    }
                }
            }

            Rectangle {
                color: "#1e1e1e"
                implicitHeight: 16
                implicitWidth: systemMonitorRow.width + 8
                radius: 3

                Row {
                    id: systemMonitorRow
                    anchors.centerIn: parent
                    spacing: 8

                    Text {
                        text: "CPU: " + panel.cpuUsage + "%"
                        color: panel.cpuUsage > 80 ? "#ff6b6b" : 
                        panel.cpuUsage > 50 ? "#ffd93d" : "#6bcf7f"
                        font.pixelSize: 11
                    }

                    Text {
                        text: "RAM: " + panel.memUsage + "%"
                        color: panel.memUsage > 80 ? "#ff6b6b" : 
                        panel.memUsage > 50 ? "#ffd93d" : "#6bcf7f"
                        font.pixelSize: 11
                    }
                }
            }
        }

        Text {
            anchors.centerIn: parent
            color: "white"
            text: NiriWindowMonitor.focusedWindowTitle
        }

        Text {
            anchors.right: parent.right
            anchors.rightMargin: 8
            anchors.verticalCenter: parent.verticalCenter
            color: "white"
            id: dateText
            text: Qt.formatDateTime(new Date(), "MM/dd/yy - hh:mm")

            Timer {
                interval: 60000
                onTriggered: dateText.text = Qt.formatDateTime(new Date(), "MM/dd/yy - hh:mm")
                repeat: true
                running: true
            }
        }
    }
}
