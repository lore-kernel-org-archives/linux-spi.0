From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH v2] Add Dallas DS1390 RTC chip
Date: Mon, 20 Oct 2008 09:59:03 -0700
Message-ID: <200810200959.03486.david-b@pacbell.net>
References: <48FC442E.9070206@mimc.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Alessandro Zummo <alessandro.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>,
	lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
To: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48FC442E.9070206-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
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

On Monday 20 October 2008, Mark Jackson wrote:
> +config RTC_DRV_DS1390
> +=A0=A0=A0=A0=A0=A0=A0tristate "Dallas/Maxim DS1390"
> +=A0=A0=A0=A0=A0=A0=A0help
> +=A0=A0=A0=A0=A0=A0=A0 =A0If you say yes here you get support for the DS1=
390 and probably
> +=A0=A0=A0=A0=A0=A0=A0 =A0other chips connected with SPI.

According to the datasheet at

  http://www.maxim-ic.com/quick_view2.cfm/qv_pk/4359

the DS1390, DS1391, DS1392, DS1393, and DS1394 chips are essentially
all the same except that the control register for the '91 and '92
has different bits.

So it looks like this driver should already support three chips, if
the spi_board_info has the right spi->mode bits set:  SPI_MODE_* and
SPI_3WIRE.  And if there were platform_data defined to hold the
initial control register setting, two more ... configuring that
trickle charger would already justify having platform_data too.

Please strike the "probably" and list at least those three chips.


> +=A0=A0=A0=A0=A0=A0=A0 =A0The first seven registers on these chips hold a=
n RTC, and other
> +=A0=A0=A0=A0=A0=A0=A0 =A0registers may add features such as NVRAM, a tri=
ckle charger for
> +=A0=A0=A0=A0=A0=A0=A0 =A0the RTC/NVRAM backup power, and alarms. =A0This=
 driver may not
> +=A0=A0=A0=A0=A0=A0=A0 =A0expose all those available chip features.

The "these chips" language bothers me.  This looks like cut'n'paste
from the rtc-ds1307 language, but you don't actually describe what
chips the driver handles.

I'd rather see the description say which other chips it expects to
handle, and have the description match.  All of these have alarms
and a trickle charger for backup power, but none have NVRAM.


> +/* drivers/rtc/rtc-ds1390.c

It's a bit of a nit, but the convention is =


	/*
	 * rtc-ds1390.c -- driver for DS1390 and related SPI RTCs
	 *
	 * Copyright (C) ... etc

Maybe with a separate "written by Mark Jackson" next to the copyright.

> + *
> + * Copyright (C) 2008 Mercury IMC Ltd
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * Driver for DS1390 spi RTC
> + *

And to keep changelogs out of source code; that's what GIT is for!


> + * Changelog:
> + *
> + * 04-Apr-2008: Mark Jackson <mpfj-kZtEnBLzDKq1Qrn1Bg8BZw@public.gmane.org>
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0- Initial version based on rtc-=
max6902
> + *=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0- No alarm support though !!
> + */

My personal taste is to have the copyright comment cover ONLY the
copyright (and licensing) issues, and have a separate comment
describing open issues with the code.  In this case, that would
be no support for the alarm, any other aspect of the control
register, or (unless it was set up by pre-OS code) the trickle
charger ... =



> +static int ds1390_get_datetime(struct device *dev, struct rtc_time *dt)
> +{
> +=A0=A0=A0=A0=A0=A0=A0...
> +=A0=A0=A0=A0=A0=A0=A0return 0;

Especially since you don't currently have logic to handle the
initialization from first power up (clearing OSF etc), it'd be
good to "return rtc_valid_tm(dt);".


> +=A0=A0=A0=A0=A0=A0=A0status =3D spi_sync(spi, &message);
> +=A0=A0=A0=A0=A0=A0=A0if (status =3D=3D 0)
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return message.status;
> +
> +=A0=A0=A0=A0=A0=A0=A0return 0;

Nowadays that can just be "return spi_sync(...)".

Although ... you can make this code be a bunch simpler
by using spi_write_then_read().


> +static struct spi_driver ds1390_driver =3D {
> +=A0=A0=A0=A0=A0=A0=A0.driver =3D {
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.name=A0=A0=A0=3D "rtc-ds13=
90",
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.bus=A0=A0=A0=A0=3D &spi_bu=
s_type,

Rule of thumb:  always let the bus code set driver->bus,
never set it yourself.

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0.owner=A0=A0=3D THIS_MODULE,
> +=A0=A0=A0=A0=A0=A0=A0},
> +=A0=A0=A0=A0=A0=A0=A0.probe=A0=A0=3D ds1390_probe,
> +=A0=A0=A0=A0=A0=A0=A0.remove =3D __devexit_p(ds1390_remove),
> +};


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
