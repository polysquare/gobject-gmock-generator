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

#include "sample-interface.h"

static void
ggm_sample_interface_default_init (GGMSampleInterface *interface);

G_DEFINE_INTERFACE (GGMSample, ggm_sample_interface, G_TYPE_OBJECT);

static void
ggm_sample_interface_default_init (GGMSampleInterface *interface)
{
}

void
ggm_sample_void_function (GGMSample *sample)
{
    GGMSampleInterface *interface = GGM_SAMPLE_GET_INTERFACE (sample);
    (*interface->void_function) (sample);
}

gboolean
ggm_sample_bool_function (GGMSample *sample)
{
    GGMSampleInterface *interface = GGM_SAMPLE_GET_INTERFACE (sample);
    return (*interface->bool_function) (sample);
}

void
ggm_sample_void_function_arg (GGMSample *sample, gboolean arg)
{
    GGMSampleInterface *interface = GGM_SAMPLE_GET_INTERFACE (sample);
    (*interface->void_function_arg) (sample, arg);
}

void
ggm_sample_void_function_const_arg (GGMSample *sample, const gint *arg)
{
    GGMSampleInterface *interface = GGM_SAMPLE_GET_INTERFACE (sample);
    (*interface->void_function_const_arg) (sample, arg);
}

void
ggm_sample_void_function_args (GGMSample *sample, gint *arg1, gint *arg2)
{
    GGMSampleInterface *interface = GGM_SAMPLE_GET_INTERFACE (sample);
    (*interface->void_function_args) (sample, arg1, arg2);
}

