/****************************************************************************
** Meta object code from reading C++ file 'helper.h'
**
** Created by: The Qt Meta Object Compiler version 67 (Qt 5.5.0)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "../helper.h"
#include <QtCore/qbytearray.h>
#include <QtCore/qmetatype.h>
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'helper.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 67
#error "This file was generated using the moc from 5.5.0. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
struct qt_meta_stringdata_Helper_t {
    QByteArrayData data[18];
    char stringdata0[203];
};
#define QT_MOC_LITERAL(idx, ofs, len) \
    Q_STATIC_BYTE_ARRAY_DATA_HEADER_INITIALIZER_WITH_OFFSET(len, \
    qptrdiff(offsetof(qt_meta_stringdata_Helper_t, stringdata0) + ofs \
        - idx * sizeof(QByteArrayData)) \
    )
static const qt_meta_stringdata_Helper_t qt_meta_stringdata_Helper = {
    {
QT_MOC_LITERAL(0, 0, 6), // "Helper"
QT_MOC_LITERAL(1, 7, 4), // "open"
QT_MOC_LITERAL(2, 12, 0), // ""
QT_MOC_LITERAL(3, 13, 22), // "createPresentationMode"
QT_MOC_LITERAL(4, 36, 10), // "readShader"
QT_MOC_LITERAL(5, 47, 3), // "hue"
QT_MOC_LITERAL(6, 51, 10), // "saturation"
QT_MOC_LITERAL(7, 62, 10), // "brightness"
QT_MOC_LITERAL(8, 73, 5), // "alpha"
QT_MOC_LITERAL(9, 79, 5), // "fonts"
QT_MOC_LITERAL(10, 85, 9), // "fontIndex"
QT_MOC_LITERAL(11, 95, 16), // "openPresentation"
QT_MOC_LITERAL(12, 112, 25), // "setCreatePresentationMode"
QT_MOC_LITERAL(13, 138, 10), // "enableEdit"
QT_MOC_LITERAL(14, 149, 10), // "screenSize"
QT_MOC_LITERAL(15, 160, 13), // "mainViewWidth"
QT_MOC_LITERAL(16, 174, 14), // "mainViewHeight"
QT_MOC_LITERAL(17, 189, 13) // "setEnableEdit"

    },
    "Helper\0open\0\0createPresentationMode\0"
    "readShader\0hue\0saturation\0brightness\0"
    "alpha\0fonts\0fontIndex\0openPresentation\0"
    "setCreatePresentationMode\0enableEdit\0"
    "screenSize\0mainViewWidth\0mainViewHeight\0"
    "setEnableEdit"
};
#undef QT_MOC_LITERAL

static const uint qt_meta_data_Helper[] = {

 // content:
       7,       // revision
       0,       // classname
       0,    0, // classinfo
      16,   14, // methods
       0,    0, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       2,       // signalCount

 // signals: name, argc, parameters, tag, flags
       1,    1,   94,    2, 0x06 /* Public */,
       3,    0,   97,    2, 0x06 /* Public */,

 // methods: name, argc, parameters, tag, flags
       4,    1,   98,    2, 0x02 /* Public */,
       5,    1,  101,    2, 0x02 /* Public */,
       6,    1,  104,    2, 0x02 /* Public */,
       7,    1,  107,    2, 0x02 /* Public */,
       8,    1,  110,    2, 0x02 /* Public */,
       9,    0,  113,    2, 0x02 /* Public */,
      10,    1,  114,    2, 0x02 /* Public */,
      11,    1,  117,    2, 0x02 /* Public */,
      12,    0,  120,    2, 0x02 /* Public */,
      13,    0,  121,    2, 0x02 /* Public */,
      14,    0,  122,    2, 0x02 /* Public */,
      15,    0,  123,    2, 0x02 /* Public */,
      16,    0,  124,    2, 0x02 /* Public */,
      17,    1,  125,    2, 0x02 /* Public */,

 // signals: parameters
    QMetaType::Void, QMetaType::QString,    2,
    QMetaType::Void,

 // methods: parameters
    QMetaType::QString, QMetaType::QString,    2,
    QMetaType::QReal, QMetaType::QString,    2,
    QMetaType::QReal, QMetaType::QString,    2,
    QMetaType::QReal, QMetaType::QString,    2,
    QMetaType::QReal, QMetaType::QString,    2,
    QMetaType::QStringList,
    QMetaType::Int, QMetaType::QString,    2,
    QMetaType::Void, QMetaType::QUrl,    2,
    QMetaType::Void,
    QMetaType::Bool,
    QMetaType::QSize,
    QMetaType::QReal,
    QMetaType::QReal,
    QMetaType::Void, QMetaType::Bool,    2,

       0        // eod
};

void Helper::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Helper *_t = static_cast<Helper *>(_o);
        Q_UNUSED(_t)
        switch (_id) {
        case 0: _t->open((*reinterpret_cast< const QString(*)>(_a[1]))); break;
        case 1: _t->createPresentationMode(); break;
        case 2: { QString _r = _t->readShader((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< QString*>(_a[0]) = _r; }  break;
        case 3: { qreal _r = _t->hue((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 4: { qreal _r = _t->saturation((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 5: { qreal _r = _t->brightness((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 6: { qreal _r = _t->alpha((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 7: { QStringList _r = _t->fonts();
            if (_a[0]) *reinterpret_cast< QStringList*>(_a[0]) = _r; }  break;
        case 8: { int _r = _t->fontIndex((*reinterpret_cast< const QString(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< int*>(_a[0]) = _r; }  break;
        case 9: _t->openPresentation((*reinterpret_cast< const QUrl(*)>(_a[1]))); break;
        case 10: _t->setCreatePresentationMode(); break;
        case 11: { bool _r = _t->enableEdit();
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        case 12: { QSize _r = _t->screenSize();
            if (_a[0]) *reinterpret_cast< QSize*>(_a[0]) = _r; }  break;
        case 13: { qreal _r = _t->mainViewWidth();
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 14: { qreal _r = _t->mainViewHeight();
            if (_a[0]) *reinterpret_cast< qreal*>(_a[0]) = _r; }  break;
        case 15: _t->setEnableEdit((*reinterpret_cast< bool(*)>(_a[1]))); break;
        default: ;
        }
    } else if (_c == QMetaObject::IndexOfMethod) {
        int *result = reinterpret_cast<int *>(_a[0]);
        void **func = reinterpret_cast<void **>(_a[1]);
        {
            typedef void (Helper::*_t)(const QString & );
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Helper::open)) {
                *result = 0;
            }
        }
        {
            typedef void (Helper::*_t)();
            if (*reinterpret_cast<_t *>(func) == static_cast<_t>(&Helper::createPresentationMode)) {
                *result = 1;
            }
        }
    }
}

const QMetaObject Helper::staticMetaObject = {
    { &QObject::staticMetaObject, qt_meta_stringdata_Helper.data,
      qt_meta_data_Helper,  qt_static_metacall, Q_NULLPTR, Q_NULLPTR}
};


const QMetaObject *Helper::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->dynamicMetaObject() : &staticMetaObject;
}

void *Helper::qt_metacast(const char *_clname)
{
    if (!_clname) return Q_NULLPTR;
    if (!strcmp(_clname, qt_meta_stringdata_Helper.stringdata0))
        return static_cast<void*>(const_cast< Helper*>(this));
    return QObject::qt_metacast(_clname);
}

int Helper::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QObject::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 16)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 16;
    } else if (_c == QMetaObject::RegisterMethodArgumentMetaType) {
        if (_id < 16)
            *reinterpret_cast<int*>(_a[0]) = -1;
        _id -= 16;
    }
    return _id;
}

// SIGNAL 0
void Helper::open(const QString & _t1)
{
    void *_a[] = { Q_NULLPTR, const_cast<void*>(reinterpret_cast<const void*>(&_t1)) };
    QMetaObject::activate(this, &staticMetaObject, 0, _a);
}

// SIGNAL 1
void Helper::createPresentationMode()
{
    QMetaObject::activate(this, &staticMetaObject, 1, Q_NULLPTR);
}
QT_END_MOC_NAMESPACE
