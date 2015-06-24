import QtQuick 2.4

Layout
{
    itemsCount: 2
    columnsCount: 2
    itemWidth: (parent) ? parent.width*0.386 : /*480*/ helper.mainViewWidth()*0.386
    itemHeight: (parent) ? parent.height*0.745 : /*520*/ helper.mainViewHeight()*0.745
}



