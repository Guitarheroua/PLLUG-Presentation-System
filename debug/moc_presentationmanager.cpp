/****************************************************************************
** Meta object code from reading C++ file 'presentationmanager.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../presentationmanager.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'presentationmanager.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_PresentationManager_t {
    QByteArrayData data[7];
    char stringdata0[123];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_PresentationManager_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_PresentationManager_t qt_meta_stringdata_PresentationManager = {
    {
QT_MOC_LITERAL(0, 0, 19), // "PresentationManager"
QT_MOC_LITERAL(1, 20, 16), // "openPresentation"
QT_MOC_LITERAL(2, 37, 0), // ""
QT_MOC_LITERAL(3, 38, 18), // "setBlockProperties"
QT_MOC_LITERAL(4, 57, 11), // "QQuickItem*"
QT_MOC_LITERAL(5, 69, 29), // "setCreateEditPresentationMode"
QT_MOC_LITERAL(6, 99, 23) // "setShowPresentationMode"

    },
    "PresentationManager\0openPresentation\0"
    "\0setBlockProperties\0QQuickItem*\0"
    "setCreateEditPresentationMode\0"
    "setShowPresentationMode"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_PresentationManager[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       4,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       0,       // signalCount

 // slots: name, argc, parameters, tag, flags
       1,    1,   34,    2, 0x0a /* Public */,
       3,    2,   37,    2, 0x0a /* Public */,
       5,    0,   42,    2, 0x0a /* Public */,
       6,    0,   43,    2, 0x0a /* Public */,

 // slots: parameters
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void, 0x80000000 | 4, QMetaType::QVariantMap,    2,    2,
    QMetaType::Void,
    QMetaType::Void,

       0        // eod
};

void PresentationManager::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        PresentationManager *_t = static_cast<PresentationManager *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->openPresentation((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->setBlockProperties((*reinterpret_cast< QQuickItem*(*)>(_a[1])),(*reinterpret_cast< QVariantMap(*)>(_a[2]))); break;
        case 2: _t->setCreateEditPresentationMode(); break;
        case 3: _t->setShowPresentationMode(); break;
        default: ;
        }
    }
}

const QMetaObject PresentationManager::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_PresentationManager.data,
      qt_meta_data_PresentationManager,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *PresentationManager::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *PresentationManager::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_PresentationManager.stringdata0))
        return static_cast<void*>(const_cast< PresentationManager*>(this));
    return QObject::qt_metacast(_clname);
}

int PresentationManager::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 4)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 4;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 4)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 4;
    }
    return _id;
}
QT_END_MOC_NAMESPACE
