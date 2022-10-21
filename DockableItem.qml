import QtQuick 2.0
import QtQuick.Controls 2.12


ApplicationWindow{
    id: wind_dock

    property var dropParent
    onDropParentChanged: {
        print(dropParent.objectName)
    }

    property int mouseXpos: -1
    property int mouseYpos: -1


    visible: true

    //        flags:  Qt.FramelessWindowHint

    width: 500
    height: 500
    objectName: "win2"

    //        x: 100
    //        y: 100
//        Drag.active: mouseArea.drag.active

    Rectangle{
        anchors.fill: parent
        color: "#33FF0000"
    }

    Item {
        id: itm_state
        anchors.fill: parent

/*
        DropArea{
            id: dropArea_root
            width: 20
            height: parent.height

            onContainsDragChanged: {
                print("---------------")
            }

            Rectangle{
                id: dropRectangle
                anchors.fill: parent
                color: "#330000ff"

                states: [
                    State {
                        when: dropArea_root.containsDrag
                        PropertyChanges {
                            target: dropRectangle
                            color: "grey"
                        }
                    }
                ]
            }
        }

        Rectangle{
            id: itm2

            width: 80
            height: 80

            x: handler.centroid.position.x //win2.x - 10 //200
            y: handler.centroid.position.y //win2.y //200

            Drag.active: ma_itm2.drag.active
            Drag.keys: [ colorKey ]
            color: "green"

            MouseArea{
                id: ma_itm2
                anchors.fill: parent

                drag.target: parent
            }
        }

        MouseArea {
            id: mouseArea

            width: 64; height: 64
            anchors.centerIn: parent


            drag.target: tile

//            onReleased: parent = tile.Drag.target !== null ? tile.Drag.target : root

            Rectangle {
                id: tile

                width: 64; height: 64
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter

                color: colorKey

                Drag.keys: [ colorKey ]
                Drag.active: mouseArea.drag.active
                Drag.hotSpot.x: 32
                Drag.hotSpot.y: 32
                states: State {
                    when: mouseArea.drag.active
//                    ParentChange { target: tile; parent: root }
                    AnchorChanges { target: tile; anchors.verticalCenter: undefined; anchors.horizontalCenter: undefined }
                }

            }
        }
*/


        state: "unDock"

        states: [
            State {
                name: "dock"
                PropertyChanges {
                    target: wind_dock
                    flags: Qt.FramelessWindowHint
                    x: dropParent.posx
                    y: dropParent.posy
                }
            },
            State {
                name: "unDock"
                PropertyChanges {
                    target: wind_dock
                    flags: Qt.Sheet //Window //Sheet

                }
            }
        ]
    }

    Rectangle{
        id: head_win2
        anchors.top: parent.top
        color: "green"
        width: parent.width
        height: 50


        MouseArea{
            id: ma_win2

            property int posX: -1
            property int posY: -1

            anchors.fill: parent

            //                drag.target: parent.parent

            onPressed: {
                posX = mouse.x
                posY = mouse.y
            }

            onPositionChanged: {
                itm_state.state = "unDock"
                //                    print(mouse.x,mouse.y)
                //                    print(mouse.x - posX,mouse.y - posY)
                wind_dock.x += (mouse.x - posX)
                wind_dock.y += (mouse.y - posY)
//                print(wind_dock.x+mouse.x,wind_dock.y+mouse.y , " == " , root.x,root.y)
                mouseXpos = wind_dock.x + mouse.x
                mouseYpos = wind_dock.y + mouse.y

                chechDrop(wind_dock)
            }

            onReleased: {

                if(dropParent.objectName !== "nullDropArea"){
                    itm_state.state = "dock"
                    print(dropParent.posx, dropParent.posy)
                }
                else{
                    itm_state.state = "unDock"

                }
            }
        }
    }



}

