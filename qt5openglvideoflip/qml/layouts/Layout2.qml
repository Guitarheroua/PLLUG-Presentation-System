import QtQuick 2.4

Layout
{
    itemsCount: 4
    columnsCount: 2
    itemWidth: (parent) ? parent.width*0.3303 : /*410*/ /*1241*0.3303*/ helper.mainViewWidth()*0.3303
    itemHeight: (parent) ? parent.height*0.372 : /*260*//*698*0.372*/ helper.mainViewHeight()*0.372
}

