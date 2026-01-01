pragma Singleton

import QtQuick
import Quickshell

Singleton {
    id: root

    property var workspaces: []

    Component.onCompleted: {
        NiriSocketConnection.sendRequest({"Workspaces": null})

        NiriSocketConnection.eventReceived.connect(function(event) {
            if (event.Ok && event.Ok.Workspaces) {
                root.workspaces = event.Ok.Workspaces.sort(function(a, b) { return a.idx - b.idx })
            } else if (event.WorkspaceActivated) {
                const activatedWorkspace = event.WorkspaceActivated
                const newWorkspaces = []

                for (let index = 0; index < root.workspaces.length; index++) {
                    const workspace = root.workspaces[index]
                    workspace.is_active = workspace.id === activatedWorkspace.id
                    workspace.is_focused = workspace.id === activatedWorkspace.id

                    newWorkspaces.push(workspace)
                }

                root.workspaces = newWorkspaces
            } else if (event.WorkspacesChanged) {
                root.workspaces = event.WorkspacesChanged.workspaces.sort(function(a, b) { return a.idx - b.idx })
            }
        })
    }
}
