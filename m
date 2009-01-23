From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: RFC: Working around dynamic device
	allocation in i2c. Interaction with other subystems.
Date: Thu, 22 Jan 2009 22:14:22 -0800
Message-ID: <200901222214.22806.david-b@pacbell.net>
References: <4974D20F.20209@cam.ac.uk> <49786CA6.8010303@cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: eric miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Ben Dooks <ben-linux-elnMNo+KYs3YtjvyW6yDsg@public.gmane.org>,
	Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Jonathan Cameron <jic23-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <49786CA6.8010303-KWPb1pKIrIJaa/9Udqfwiw@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday 22 January 2009, Jonathan Cameron wrote:
> > Within board configuration files, i2c devices are currently allocated
> > using i2c_board_info structures. =A0The only element of these that reta=
ins
> > it's memory address once the struct device elements are allocated (upon
> > adapter initialization) is the platform data pointer.
> >
> > Several subsystems (regulator and clock for example) use an association
> > method based upon a device specific string associated with a pointer to
> > a device structure. =A0Unfortunately as things currently stand there is=
 no
> > means of obtaining a suitable device for i2c devices at the point when
> > it is required (in the board config).

Yeah, kind of awkward.  Multi-Function Device (MFD) drivers have
this kind of problem a lot.  A given I2C device might have a few
dozen child devices -- including regulators and clock generators,
RTCs, GPIOs, input devices, etc -- that can't be set up until the
parent I2C device is probed.

It's solved easily enough by making sure the associations and their
devices get set up after the core of the MFD comes up ... in the
probe() routine.  And by making sure the MFD and its subsystem
initializes early enough that those other devices don't fail too
many hidden assumptions.


> > What do people think? In particular can anyone come up with any other /
> > better way round this issue. (or am I missing something?)
> > In particular, are there any similar cases already in kernel that would
> > suggest a particular approach to solving this issue?

This is a special case of a general problem:  init sequencing.
The initcall levels don't provide sufficient control, so you
need to work around them.

Static device allocation is a bit problematic, and some folk
really dislike it ... I'm not that averse to it, but since
the cost of a device keeps growing I'd rather avoid that in
most cases.  A couple dozen bytes of board_info, especially
if it's __initdata, versus several hundred bytes of "struct
foo_device", multiplied by even just a dozen devices that
won't always be present, adds up.

That leaves a dynamic solution for setting up linkage between
various devices.  In the past I've done that using callbacks
to board-specific code that knows what linkages to establish.

You can see that with the GPIO controllers that use I2C or SPI
communications:  they have setup callbacks that receive the
device and GPIO information, which can continue to set the
stage for the main event ... and teardown callbacks to break
it all down after the show is done.

So for example those callbacks can be used to configure and
then register the devices which rely on those GPIOs ... like
LED banks, MMC/SD card sense switches, voltage regulator
enables, and so on.

- Dave


---------------------------------------------------------------------------=
---
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
