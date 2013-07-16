From: <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Subject: RE: support DUAL and QUAD[patch v1]
Date: Tue, 16 Jul 2013 10:12:46 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <pekon-l0cyMroinI0@public.gmane.org>, <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E851E-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello Pekon,

Gupta, Pekon wrote on=A02013-07-16:
> >
> > Hi, Gupta
> >
> >
> > > [Pekon]: Instead of adding new fields you can use existing 'mode' fie=
ld to
> > > pass on the platform specific configurations. And if 'u8 mode' does n=
ot
> > > suffice you can increase it to 'u32'.
> > > #define QSPI_MODE       1 << 5; // just check which bit-fields are un=
-used
> > > spi_board_info->mode |=3D QSPI_MODE;
> > >
> >
> > well, can dual and quad be regarded as a spi mode? if so, your comment
> > seems
> > to be right.
> =

> Yes, Quad and Dual modes should be regarded as extension of SPI protocol.
> - They follow the same basic principle of synchronous data transfer. Righ=
t ?
> - These modes are not adding any extra side-band | In-band signaling or
> controls to modify the protocol. They are just increasing the width of
>  data-channel for better throughput.
> =

> with regards, pekon
> =


In general, yes. But I think, for the interface we have to take care of mor=
e details.

For example, what happens in the following situation:
We have a spi-controller, which supports the QSPI mode, and a spi-flash, wh=
ich fulfils =

the requirements, but the board has not connected all signals?

And the interface for the slave-driver (like m25p80) should allow to specif=
y the transfer mode
for each spi_message.
This will be necessary, because it depends on the flash and mode, how each =
phase of "cmd",
"address", and "data" will be transferred.

I don't know, if it is only me, but I would like to see some more abstract =
description for all =

these scenarios, before the details of an interface really could be discuss=
ed and decided.

Best Regards,
Thomas


---------------------------------------------------------------------------=
---
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=3D48808831&iu=3D/4140/ostg.cl=
ktrk
