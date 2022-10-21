import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.3
//import Qt.labs.platform 1.1
//import QtQuick.Dialogs 1.3
import QtQuick.Dialogs 1.0
import Qt.labs.settings 1.0
import QtQml.Models 2.12

Window
{
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    property string colorKey: "#f087f5"

    property var dropAraeList: []

    signal chechDrop(var obj)
    onChechDrop: {


        if(dropArea_left.contains(Qt.point(obj.mouseXpos - root.x, obj.mouseYpos - root.y))){

            itm_drop.state = "dock_left"
            if(obj.dropParent !== dropArea_left) obj.dropParent = dropArea_left
        }
        else{
            itm_drop.state = "dock_null"
            if(obj.dropParent !== dropArea_null) obj.dropParent = dropArea_null

        }

    }


    /*ObjectModel {
        id: listDropArea

    }*/


    Item {
        id: itm_drop
        anchors.fill: parent

        state: "dock_null"
        states: [
            State {
                name: "dock_null"
                PropertyChanges {
                    target: dropArea_left
                    isActive: false
                }
            },
            State {
                name: "dock_left"
                PropertyChanges {
                    target: dropArea_left
                    isActive: true
                }
            },
            State {
                name: "dock_right"
                PropertyChanges {
                    target: dropArea_left
                    isActive: false
                }
            }
        ]

        Rectangle{
            id: containerDock_left

            width: 200
            height: parent.height

            ListModel{
                id: model_tab_left
                ListElement{
                    tabName: "tab1"
                }
                ListElement{
                    tabName: "tab2"
                }
                ListElement{
                    tabName: "tab3"
                }
            }

            ColumnLayout{
                anchors.fill: parent

                //-- tabs --//
                Rectangle{
                    id: tab_left

                    Layout.fillWidth: true
                    Layout.preferredHeight: 50

                    color: "#33ff0000"

                    ListView{
                        anchors.fill: parent

                        model: model_tab_left
                        orientation: ListView.Horizontal

                        delegate: ItemDelegate{
                            width: 50
                            height: parent.height

                            Label{
                                text: tabName
                                anchors.centerIn: parent

                            }

                            Rectangle{
                                anchors.fill: parent
                                color: "transparent"
                                border.color: "black"
                                border.width: 1
                            }
                        }
                    }
                }


                //-- bodys --//
                Rectangle{
                    id: tab_body_left

                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    color: "#33ffff00"
                }


            }

            Rectangle{
                id: dropArea_left
                property alias isActive: dropArea_left.visible

    //            property var childList: []

                Component.onCompleted: {
                    dropAraeList.push(dropArea_left)
                }

                objectName: "leftDropArea"

                property int posx: x + root.x
                property int posy: y + root.y

                width: 20
                height: parent.height

                color: "blue"

                Label{
                    text: dropArea_left.x + "-" + dropArea_left.y
                }
            }
        }


        Item{id: dropArea_null; objectName: "nullDropArea"}


    }



    DockableItem{
        id: win1
        objectName: "win1"

    }

    DockableItem{
        id: win2
        objectName: "win2"
    }

    Button{
        text: "test"
        anchors.right: parent.right
        onClicked: {
            print(itm_state.state)
            //            itm_state.state = itm_state.state === "dock" ? "dock" : "unDock"
            itm_state.state = itm_state.state === "dock" ? "unDock" : "dock"
        }
    }

}
