#include "machelper.h"
#include <Cocoa/Cocoa.h>
#include <QDebug>


MacHelper::MacHelper()
{
}

void MacHelper::setAspectRatio(WId id)
{
    NSView *view = (NSView*)id;
    NSWindow *window = [view window];
    [window setAspectRatio: window.frame.size];

}
