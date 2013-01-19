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
#ifndef _GOBJECT_GMOCK_GENERATOR_RESOURCE_H
#define _GOBJECT_GMOCK_GENERATOR_RESOURCE_H

#include <vector>
#include <glib.h>

namespace gobject_gmock_generator
{
class ObjectResource
{
    public:

        typedef std::vector <GObjectConstructParam *> ConstructParams;

        virtual ~ObjectResource () {};

        virtual void constructor (const ConstructParams &) const = 0;
        virtual void dispose () const = 0;
        virtual void finalize () const = 0;
};
}

#endif
