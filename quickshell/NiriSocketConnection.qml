pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Io

Singleton {
    id: root

    signal eventReceived(var event)

    property Socket socket: Socket {
        connected: true
        id: socket
        path: Quickshell.env("NIRI_SOCKET")
        parser: SplitParser {
            onRead: function(data) {
                if (data.trim() === "") {
                    return
                }

                try {
                    root.eventReceived(JSON.parse(data))
                } catch (error) {
                    console.error("Failed to parse event:", data, error)
                }
            }
        }
    }

    function sendRequest(request) {
        socket.write(JSON.stringify(request) + "\n")
        socket.flush()
    }

    Component.onCompleted: {
        sendRequest({"EventStream": null})
    }
}
