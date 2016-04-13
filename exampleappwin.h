#ifndef __EXAMPLEAPPWIN_H
#define __EXAMPLEAPPWIN_H

#include <gtk/gtk.h>

#define EXAMPLE_APP_WINDOW_TYPE (example_app_window_get_type())
#define EXAMPLE_APP_WINDOW(obj) (G_TYPE_CHECK_INSTANCE_CAST((obj), EXAMPLE_APP_WINDOW_TYPE, ExampleAppWindow))

typedef struct _ExampleAppWindow ExampleAppWindow;
typedef struct _ExampleAppWindowClass ExampleAppWindowClass;
typedef struct _ExampleAppWindowPrivate ExampleAppWindowPrivate;

GType example_app_window_get_type(void);
ExampleAppWindow *example_app_window_new(ExampleApp *app);
void example_app_window_open(ExampleAppWindow *win, GFile *file);

#endif
