/*****************************************************************************
 *   Copyright (C) 2018 by Yunusemre Şentürk                                 *
 *   <yunusemre.senturk@pardus.org.tr>                                       *
 *                                                                           *
 *   This program is free software; you can redistribute it and/or modify    *
 *   it under the terms of the GNU General Public License as published by    *
 *   the Free Software Foundation; either version 2 of the License, or       *
 *   (at your option) any later version.                                     *
 *                                                                           *
 *   This program is distributed in the hope that it will be useful,         *
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the           *
 *   GNU General Public License for more details.                            *
 *                                                                           *
 *   You should have received a copy of the GNU General Public License       *
 *   along with this program; if not, write to the                           *
 *   Free Software Foundation, Inc.,                                         *
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA .          *
 *****************************************************************************/

import QtQuick 1.1
import org.kde.plasma.graphicswidgets 0.1 as PlasmaWidgets

Item {
    id: root

    /**
     * Indicates that the font of the texts in the widget.
     */
    property string textFont

    /**
     * Indicates that the minimum width of the widget regarding the screen
     * resolution. The static number 14 represents the actual persentage
     * of the screen width that specified after longterm researches about
     * Interactive White Board.
     */
    property int minimumWidth : paintedWidth

    /**
     * Indicates that the minimum height of the widget regarding the screen
     * resolution.
     */
    property int minimumHeight : volumeChanger.height + bottomseperator.height + closer.height

    /**
     * Indicates that the global veriable for general line alignment
     * regarding the screen resolution.
     */
    property int lineAlign: root.width*7/100

    Column {
        anchors.fill:parent

        Row {
            VolumeChanger {
                id:volumeChanger
                width:  root.width / 4
                height: root.width * 57 /100
                volumeline: root.width * 38 /100
                color:"transparent"
                visible: true
            }

            Column {
                id: toolsContainer
                Row {
                    Rectangle {
                        id:keyboardclient
                        height: volumeChanger.height / 2
                        color:"transparent"
                        width: root.width * 3 / 8
                        PlasmaWidgets.IconWidget {
                            anchors.fill: parent
                            onClicked: {
                                plasmoid.runCommand("qdbus",["org.eta.virtualkeyboard",
                                                             "/VirtualKeyboard",
                                                             "org.eta.virtualkeyboard.toggle"]);
                            }
                            Component.onCompleted: {
                                setIcon("eta-keyboard")
                            }
                        }
                    }
                    Rectangle {
                        id:penclient
                        height: volumeChanger.height / 2
                        width: root.width * 3 / 8
                        color:"transparent"
                        PlasmaWidgets.IconWidget {
                            anchors.fill:parent
                            onClicked: {
                                plasmoid.runCommand("/usr/bin/eta-pen");
                            }
                            Component.onCompleted: {
                                setIcon("eta-pen")
                            }
                        }
                    }
                }
                Row {
                    Rectangle {
                        id:screenshooter
                        height: volumeChanger.height / 2
                        width: root.width * 3 / 8
                        color:"transparent"
                        PlasmaWidgets.IconWidget {
                            anchors.fill:parent
                            onClicked: {
                                plasmoid.runCommand("ksnapshot");
                            }
                            Component.onCompleted: {
                                setIcon("eta-screen-shooter")
                            }
                        }
                    }
                    Rectangle {
                        id:screenblackout
                        height: volumeChanger.height / 2
                        width: root.width * 3 / 8
                        color:"transparent"
                        PlasmaWidgets.IconWidget {
                            id: ekrankarartIcon
                            anchors.fill:parent
                            onClicked: {
                                plasmoid.runCommand("/usr/bin/eta-black",
                                                    ["&"]);
                            }
                            Component.onCompleted: {
                                setIcon("eta-black")
                            }
                        }
                    }
                }
            }
        }

        Rectangle {
            id:bottomseperator
            color:"transparent"
            height: 2
            width: root.width
            Rectangle {
                color: "#cccccc"
                height: 1
                anchors {
                    bottom:parent.bottom
                    bottomMargin:0
                    left:parent.left
                    leftMargin:0
                    right:parent.right
                    rightMargin:0
                }
            }
        }

        Row {
            Rectangle {
                id:helper
                width: root.width/2 -2
                height: root.width *15/100
                color:"transparent"
                Text {
                    id:yardimtext
                    text: "YARDIM"
                    color: "#969699"
                    font.family:textFont
                    font.bold : true
                    font.pointSize: 10
                    elide: Text.ElideLeft
                    horizontalAlignment: Text.AlignLeft
                    anchors {
                        left: parent.left
                        leftMargin: lineAlign -8
                        centerIn:parent
                    }
                }//label
                MouseArea {
                    anchors.fill: parent

                    onPressAndHold: {helper.color= "#383838"; yardimtext.color = "#FF6C00";}
                    onPressed: {helper.color= "#383838"; yardimtext.color = "#FF6C00";}
                    onReleased: {
                        if(root.state == 'visible') {
                            root.state = 'invisible'
                            helper.color= "transparent"
                            yardimtext.color = "#969699";
                        } else {
                            root.state = 'visible'
                            helper.color= "#383838"
                            yardimtext.color = "#FF6C00"
                        }
                    }
                }
            }
            Rectangle {
                height: root.width *15/100
                width: 3
                color:"transparent"
                Rectangle {
                    color: "#cccccc"
                    anchors.horizontalCenterOffset: 0
                    width:1
                    height: root.width *15/100
                    anchors {
                        horizontalCenter:parent.horizontalCenter
                    }
                }
            }
            Rectangle {
                id:closer
                width: root.width/2 -1
                height: root.width *15/100
                color:"transparent"
                Row {
                    anchors {
                        top:parent.top
                        topMargin:0
                        fill:parent
                    }
                    Item {
                        id:toolbuttonkapatcontainer
                        width: root.width *13/100
                        height: root.width *13/100
                        anchors {
                            left : parent.left
                            leftMargin: lineAlign -10
                            verticalCenter: parent.verticalCenter
                        }
                        PlasmaWidgets.IconWidget {
                            id: kapatIcon
                            anchors.fill:parent
                            Component.onCompleted: {
                                setIcon("eta-shutdown")
                            }
                        }
                    }//item toolbuttonappcontainer
                    Item {
                        anchors {
                            left:toolbuttonkapatcontainer.right
                            leftMargin :lineAlign -8
                            verticalCenter: parent.verticalCenter
                        }
                        Text {
                            id:kapattext
                            text: "KAPAT"
                            color: "#969699"
                            font.family:textFont
                            font.bold : true
                            font.pointSize: 10
                            elide: Text.ElideLeft
                            horizontalAlignment: Text.AlignLeft
                            anchors {
                                left: parent.left
                                leftMargin: 0
                                verticalCenter: parent.verticalCenter
                                verticalCenterOffset: 0
                            }
                        }//label
                    }//item labelcontainer
                }//Row
                MouseArea {
                    anchors.fill: parent

                    onPressAndHold: {kapattext.color= "#FF6C00"; }
                    onPressed: {kapattext.color= "#FF6C00"; }
                    onReleased: {
                        plasmoid.runCommand("qdbus", ["org.kde.ksmserver",
                                                      "/KSMServer", "org.kde.KSMServerInterface.logout",
                                                      "1", "-1", "-1"]);
                        kapattext.color= "#969699";
                    }
                }
            }
        }

    }

    Help {
        id:helpRect
        width: root.width
        height: volumeChanger.height
        x:root.x
        y:root.y+height
        z:-1
        opacity: 0
    }

    states: [
        State {
            name: 'visible'
            PropertyChanges {
                target: helpRect
                x: root.x
                y: root.y
                z:100
                opacity:1
            }
            PropertyChanges {
                target: yardimtext
                color: "#FF6C00"
            }
        },
        State {
            name: 'invisible'
            PropertyChanges {
                target: helpRect
                x: root.x
                y: root.y+ helpRect.height
                z:-1
                opacity:0
            }
            PropertyChanges {
                target: yardimtext
                color: "#969699"
            }
        }
    ]
    transitions: [
        Transition {
            NumberAnimation { properties: "x,y,opacity"; duration: 200 }
        }
    ]

    function configChanged()
    {

        textFont = plasmoid.readConfig( "textFont" )
    }

    Component.onCompleted: {
        plasmoid.addEventListener( 'ConfigChanged', configChanged );

        textFont = plasmoid.readConfig( "textFont" )
    }
}//Item root

