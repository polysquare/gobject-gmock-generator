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

#include <gmock/gmock.h>

#include <glib-object.h>

#include <gobject-gmock-generator/gobject-resource.h>
#include <gobject-gmock-generator/gobject-properties.h>
#include <gobject-gmock-generator/gobject-resource-mock.h>
#include <gobject-gmock-generator/gobject-resource-stub.h>
#include <gobject-gmock-generator/gobject-properties-mock.h>
#include <gobject-gmock-generator/gobject-properties-stub.h>

namespace ggm = gobject_gmock_generator;

namespace
{
    typedef ggm::ObjectResource::ConstructParams ConstructParams;
}

ggm::mock::ObjectResource::ObjectResource ()
{
}

ggm::mock::ObjectProperties::ObjectProperties ()
{
}

void
ggm::stub::ObjectResource::constructor (const ConstructParams &) const
{
}

void
ggm::stub::ObjectResource::dispose () const
{
}

void
ggm::stub::ObjectResource::finalize () const
{
}

void
ggm::stub::ObjectProperties::setProperty (guint, const GValue *, GParamSpec *) const
{
}

GValue *
ggm::stub::ObjectProperties::getProperty (guint, GParamSpec *) const
{
    return NULL;
}
