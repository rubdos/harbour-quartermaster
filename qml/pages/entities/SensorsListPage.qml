import QtQuick 2.0
import Sailfish.Silica 1.0

import org.nubecula.harbour.quartermaster 1.0

import "../../components/"

Page {
    property string title
    property int type
    property string icon

    id: page

    allowedOrientations: Orientation.All

    PageBusyIndicator {
        id: busyIndicator
        size: BusyIndicatorSize.Large
        running: Client.entitiesProvider().loading
    }

    SilicaFlickable {
        PullDownMenu {
            MenuItem {
                text: qsTr("Refresh")
                onClicked: Client.entitiesProvider().updateModel(type)
            }
            MenuItem {
                text: qsTr("Search")
                onClicked: listView.showSearch = true
            }
        }

        anchors.fill: parent

        Column {
            id: header
            width: parent.width

            PageHeader {
                title: page.title
            }

            SearchField {
                id: searchField
                width: parent.width
                height: listView.showSearch ? implicitHeight : 0
                opacity: listView.showSearch ? 1 : 0
                onTextChanged: {
                    filterModel.setFilterFixedString(text)
                }

                Connections {
                    target: listView
                    onShowSearchChanged: {
                        searchField.forceActiveFocus()
                    }
                }

                Behavior on height {
                    NumberAnimation { duration: 300 }
                }
                Behavior on opacity {
                    NumberAnimation { duration: 300 }
                }
            }
        }

        SilicaListView {
            property bool showSearch: false

            id: listView

            visible: !busyIndicator.running

            width: parent.width
            anchors.top: header.bottom
            anchors.bottom: parent.bottom

            clip: true

            model: EntitiesSortFilterModel {
                id: filterModel
                sourceModel: Client.entitiesProvider().model(type)
            }

            delegate: ListItem {
                id: delegate
                width: parent.width
                contentHeight: Theme.itemSizeLarge

                Row {
                    x: Theme.horizontalPageMargin
                    width: parent.width - 2 * x
                    height: parent.height
                    anchors.verticalCenter: parent.verticalCenter

                    Image {
                        id: itemIcon
                        source: page.icon
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Item {
                        width: Theme.paddingMedium
                        height: 1
                    }

                    Column {
                        width: parent.width - itemIcon.width - Theme.paddingMedium
                        anchors.verticalCenter: itemIcon.verticalCenter

                        Label {
                            width: parent.width
                            text: name
                            color: pressed ? Theme.secondaryHighlightColor : Theme.highlightColor
                            font.pixelSize: Theme.fontSizeLarge
                        }
                        Label {
                            text: {
                                if (entity_state === undefined)
                                    return qsTr("No sensor data available")

                                if (entity_state === "unavailable")
                                    return qsTr("Unavailable")

                                var str = entity_state
                                if (attributes.unit_of_measurement !== undefined) {
                                    str += " "
                                    str += attributes.unit_of_measurement
                                }

                                return str
                            }

                            color: Theme.secondaryColor
                            font.pixelSize: Theme.fontSizeMedium
                        }
                    }
                }
            }
        }
    }

    Component.onCompleted: {
        if ((Client.updateModes & Client.UpdateModeEntityModel) === Client.UpdateModeEntityModel) Client.entitiesProvider().updateModel(type)
    }
}
