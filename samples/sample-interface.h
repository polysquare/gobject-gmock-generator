/*
 * Copyright (c) Sam Spilsbury <smspillaz@gmail.com>
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.	 See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 *
 * Author: Sam Spilsbury <smspillaz@gmail.com>
 */

#ifndef _GOBJECT_GMOCK_GENERATOR_SAMPLE_INTERFACE_H
#define _GOBJECT_GMOCK_GENERATOR_SAMPLE_INTERFACE_H

#include <glib-object.h>

#define GGM_SAMPLE_INTERFACE(obj) (G_TYPE_CHECK_INSTANCE_CAST ((obj), \
                                   GGM_TYPE_SAMPLE_INTERFACE, \
                                   GGMSampleInterface))
#define GGM_SAMPLE_GET_INTERFACE(obj) (G_TYPE_INSTANCE_GET_INTERFACE(obj, \
                                       GGM_TYPE_SAMPLE_INTERFACE, \
                                       GGMSampleInterface))
#define GGM_TYPE_SAMPLE_INTERFACE (ggm_sample_interface_get_type ())

G_BEGIN_DECLS

typedef struct _GGMSample GGMSample;
typedef struct _GGMSampleInterface GGMSampleInterface;

struct _GGMSampleInterface
{
    GTypeInterface parent;

    void (*void_function) (GGMSample *sample);
    gboolean (*bool_function) (GGMSample *sample);
    void (*void_function_arg) (GGMSample *sample, gboolean arg);
    void (*void_function_const_arg) (GGMSample *sample, const gint *arg);
    void (*void_function_args) (GGMSample *sample, gint *arg1, gint *arg2);
};

void
ggm_sample_void_function (GGMSample *sample);

gboolean
ggm_sample_bool_function (GGMSample *sample);

void
ggm_sample_void_function_arg (GGMSample *sample, gboolean arg);

void
ggm_sample_void_function_const_arg (GGMSample *sample, const gint *arg);

void
ggm_sample_void_function_args (GGMSample *sample, gint *arg1, gint *arg2);

GType ggm_sample_interface_get_type (void);

G_END_DECLS

#endif
