/****************************************************************************
** Meta object code from reading C++ file 'slide.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../slide.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'slide.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Slide_t {
    QByteArrayData data[9];
    char stringdata0[119];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Slide_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Slide_t qt_meta_stringdata_Slide = {
    {
QT_MOC_LITERAL(0, 0, 5), // "Slide"
QT_MOC_LITERAL(1, 6, 12), // "modelChanged"
QT_MOC_LITERAL(2, 19, 0), // ""
QT_MOC_LITERAL(3, 20, 11), // "fullBrowser"
QT_MOC_LITERAL(4, 32, 11), // "QQuickItem*"
QT_MOC_LITERAL(5, 44, 12), // "createBlocks"
QT_MOC_LITERAL(6, 57, 21), // "slotPageWidgthChanged"
QT_MOC_LITERAL(7, 79, 21), // "slotPageHeightChanged"
QT_MOC_LITERAL(8, 101, 17) // "webViewUrlChanged"

    },
    "Slide\0modelChanged\0\0fullBrowser\0"
    "QQuickItem*\0createBlocks\0slotPageWidgthChanged\0"
    "slotPageHeightChanged\0webViewUrlChanged"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Slide[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    0,   44,    2, 0x06 /* Public */,
       3,    1,   45,    2, 0x06 /* Public */,

 // slots: name, argc, parameters, tag, flags
       5,    0,   48,    2, 0x0a /* Public */,
       6,    0,   49,    2, 0x0a /* Public */,
       7,    0,   50,    2, 0x0a /* Public */,
       8,    1,   51,    2, 0x0a /* Public */,

 // signals: parameters
    QMetaType::Void,
    QMetaType::Void, 0x80000000 | 4,    2,

 // slots: parameters
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void,
    QMetaType::Void, QMetaType::QString,    2,

       0        // eod
};

void Slide::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Slide *_t = static_cast<Slide *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->modelChanged(); break;
        case 1: _t->fullBrowser((*reinterpret_cast< QQuickItem*(*)>(_a[1]))); break;
        case 2: _t->createBlocks(); break;
        case 3: _t->slotPageWidgthChanged(); break;
        case 4: _t->slotPageHeightChanged(); break;
        case 5: _t->webViewUrlChanged((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        switch (_id) {
        default: *reinterpret_cast<int*>(_a[0]) = -1; break;
        case 1:
            switch (*reinterpret_cast<int*>(_a[1])) {
            default: *reinterpret_cast<int*>(_a[0]) = -1; break;
            case 0:
                *reinterpret_cast<int*>(_a[0]) = qRegisterMetaType< QQuickItem* >(); break;
            }
            break;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Slide::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Slide::modelChanged)) {
                *result = 0;
            }
        }
        {
            typedef void (Slide::*_t)(QQuickItem * );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Slide::fullBrowser)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject Slide::staticMetaObject = {
    { &QQuickItem::staticMetaObject, qt_meta_stringdata_Slide.data,
      qt_meta_data_Slide,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Slide::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Slide::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Slide.stringdata0))
        return static_cast<void*>(const_cast< Slide*>(this));
    return QQuickItem::qt_metacast(_clname);
}

int Slide::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QQuickItem::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
    return _id;
}

// SIGNAL 0
void Slide::modelChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, Q_NULLPTR);
}

// SIGNAL 1
void Slide::fullBrowser(QQuickItem * _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 1, _a);
}
QT_END_MOC_NAMESPACE
