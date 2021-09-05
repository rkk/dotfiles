#!/bin/python3

"""Isolates all windows onto a single workspace."""

import i3ipc

def moveToWorkspace(target, containers):
    """Move to the target workspace, all windows in the containers list."""
    for w in containers:
        w.command("move container to workspace %s" % target)

def connect():
    return i3ipc.Connection()

def workspaces(c):
    """Provide a list of workspaces in the given connection."""
    return c.get_workspaces()

def windows(w):
    """Provides a list of all windows in the given workspace."""
    return w.leaves()

def allWindows(c):
    """Provides a list of all windows on all workspaces in the given connection."""
    all = []
    w = workspaces(c)
    for i in w:
        all.extend(i.leaves())

    return all


if __name__ == "__main__":
    c = connect()
    moveToWorkspace("1", allWindows(c))


