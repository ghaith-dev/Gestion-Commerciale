//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <responsive_table/responsive_table_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) responsive_table_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ResponsiveTablePlugin");
  responsive_table_plugin_register_with_registrar(responsive_table_registrar);
}
