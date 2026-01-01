pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    property var windows: []
    property string focusedWindowTitle: ""

    Component.onCompleted: {
        NiriSocketConnection.sendRequest({"Windows": null})

        NiriSocketConnection.eventReceived.connect(function(event) {
            if (event.Ok && event.Ok.Windows) {
                root.windows = event.Ok.Windows

                for (let index = 0; index < root.windows.length; index++) {
                    if (root.windows[index].is_focused) {
                        root.focusedWindowTitle = root.windows[index].title
                        return
                    }
                }

                root.focusedWindowTitle = "Desktop"
            } else if (event.WindowFocusChanged) {
                let isAnyWindowFocused = false

                for (let index = 0; index < root.windows.length; index++) {
                    root.windows[index].is_focused = root.windows[index].id === event.WindowFocusChanged.id

                    if (root.windows[index].is_focused) {
                        root.focusedWindowTitle = root.windows[index].title
                        isAnyWindowFocused = true
                    }
                }

                if (!isAnyWindowFocused) {
                    focusedWindowTitle = "Desktop"
                }
            } else if (event.WindowOpenedOrChanged) {
                root.windows.push(event.WindowOpenedOrChanged.window)

                for (let index = 0; index < root.windows.length; index++) {
                    root.windows[index].is_focused = root.windows[index].id === event.WindowOpenedOrChanged.window.id

                    if (root.windows[index].is_focused) {
                        root.focusedWindowTitle = root.windows[index].title
                    }
                }
            } else if (event.WindowsChanged) {
                root.windows = event.WindowsChanged.windows

                for (let index = 0; index < root.windows.length; index++) {
                    if (root.windows[index].is_focused) {
                        root.focusedWindowTitle = root.windows[index].title
                        return
                    }
                }

                root.focusedWindowTitle = "Desktop"
            } else if (event.WindowClosed) {
                root.windows = root.windows.filter(function(window) { return window.id !== event.WindowClosed.id })

                for (let index = 0; index < root.windows.length; index++) {
                    root.windows[index].is_focused = root.windows[index].id === event.WindowClosed.id

                    if (root.windows[index].is_focused) {
                        root.focusedWindowTitle = root.windows[index].title
                        return
                    }
                }

                root.focusedWindowTitle = "Desktop"
            }
        })
    }
}
