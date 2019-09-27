/*
 * Copyright (c) 2013-2019 Meltytech, LLC
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import QtQuick 2.0
import QtQuick.Controls 1.0

Rectangle {
    property real timeScale: 1.0
    property int adjustment: 0
    property real intervalSeconds: 5 * Math.max(1, Math.floor(1.5 / timeScale)) + adjustment

    SystemPalette { id: activePalette }

    id: rulerTop
    enabled: false
    height: 28
    color: activePalette.base

    Repeater {
        model: parent.width / (intervalSeconds * profile.fps * timeScale)
        Rectangle {
            anchors.bottom: rulerTop.bottom
            height: 18
            width: 1
            color: activePalette.windowText
            x: index * intervalSeconds * profile.fps * timeScale
            Label {
                anchors.left: parent.right
                anchors.leftMargin: 2
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 2
                color: activePalette.windowText
                text: application.timecode(index * intervalSeconds * profile.fps + 2).substr(0, 8)
            }
        }
    }

    Connections {
        target: profile
        onProfileChanged: {
            // Force a repeater model change to update the labels.
            ++adjustment
            --adjustment
        }
    }
}