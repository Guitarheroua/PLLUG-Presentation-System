import QtQuick 2.4

Layout
{
    itemsCount: 6
    columnsCount: 3
    itemWidth: (parent) ? parent.width * 0.257 : /*340*/ helper.mainViewWidth()*0.257
    itemHeight: (parent) ? parent.height * 0.358 : /*250*/ helper.mainViewHeight()*0.358
}




