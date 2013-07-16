From: <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>
Subject: RE: support DUAL and QUAD[patch v1]
Date: Tue, 16 Jul 2013 12:18:06 +0000
Message-ID: <593AEF6C47F46446852B067021A273D6D93B4B33@MUCSE039.lantiq.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
	<593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, sourav.poddar-l0cyMroinI0@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: <pekon-l0cyMroinI0@public.gmane.org>, <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E85D0-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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
> > Hello Pekon,
> >
> > Gupta, Pekon wrote on 2013-07-16:
> > > >
> > > > Hi, Gupta
> > > >
> > > >
> > > > > [Pekon]: Instead of adding new fields you can use existing 'mode'
> field
> > to
> > > > > pass on the platform specific configurations. And if 'u8 mode' do=
es
> not
> > > > > suffice you can increase it to 'u32'.
> > > > > #define QSPI_MODE       1 << 5; // just check which bit-fields ar=
e un-
> > used
> > > > > spi_board_info->mode |=3D QSPI_MODE;
> > > > >
> > > >
> > > > well, can dual and quad be regarded as a spi mode? if so, your comm=
ent
> > > > seems
> > > > to be right.
> > >
> > > Yes, Quad and Dual modes should be regarded as extension of SPI
> > protocol.
> > > - They follow the same basic principle of synchronous data transfer. =
Right
> ?
> > > - These modes are not adding any extra side-band | In-band signaling =
or
> > > controls to modify the protocol. They are just increasing the width of
> > >  data-channel for better throughput.
> > >
> > > with regards, pekon
> > >
> >
> > In general, yes. But I think, for the interface we have to take care of=
 more
> > details.
> >
> > For example, what happens in the following situation:
> > We have a spi-controller, which supports the QSPI mode, and a spi-flash,
> > which fulfils
> > the requirements, but the board has not connected all signals?
> >
> [Pekon]: So, actual implementation should set QSPI_MODE based on both
> (1) device capabilities (detected in probe)
> (2) board-DT properties (this would take care of your other constrains)
> =

yes, and in the end the slave (as of m25p80) can decide, which actions/mode=
s are usable
and should only use them.

> > And the interface for the slave-driver (like m25p80) should allow to sp=
ecify
> > the transfer mode
> > for each spi_message.
> > This will be necessary, because it depends on the flash and mode, how
> each
> > phase of "cmd",
> > "address", and "data" will be transferred.
> >
> [Pekon]: Are you saying that same controller can send interleaved
> Quad-SPI and Single-SPI spi_messages to same device (here flash device)?
Yes, for example the S25FL129P from Spansion always expects the command (fi=
rst 8 bit)
on a single wire and then, depending on the command, switching to dual or q=
uad-mode
for the address and/or data phase.
And other flashes I have seen (don't remember name or manufacturer) support=
 to be switched
into a quad-mode, in which they expect all data (including the command) as =
quad transfer.
> =

> Is it due to flash-device constrain that it accepts some flash-commands
> (like erase, etc) only on Single-wire-SPI, whereas  data transfers can be
> Performed on Quad-SPI mode ?
> In such case you need to add 'mode' field in struct spi_message, so that
> this information moves along with the spi_message in queue. And then
> when that message reaches spi_pump_message() and
> transfer_one_message() is called, then you can do needful configs.
Yes, I think this would be a good way to allow the flash driver to control =
these details.

> =

> However, I still don't think you need to control 'QSPI_MODE' at granulari=
ty
> of spi_transfer level, because m25p80 flash-driver use spi_write() API to
> pass data to SPI driver, which internally creates a spi_message in each c=
all.
I expect some changes to this driver for adding this modes, but as discusse=
d above,
it should be enough to have the mode per message.

> =

> Following best explains use of spi_message in /include/linux/spi.h
> ---------------------------------------------------
> * A @spi_message is used to execute an atomic sequence of data transfers,
>  * each represented by a struct spi_transfer.  The sequence is "atomic"
>  * in the sense that no other spi_message may use that SPI bus until that
>  * sequence completes.  On some systems, many such sequences can
> execute as
>  * as single programmed DMA transfer.  On all systems, these messages are
>  * queued, and might complete after transactions to other devices.
> Messages
>  * sent to a given spi_device are alway executed in FIFO order.
> ---------------------------------------------------
> =

> =

> > I don't know, if it is only me, but I would like to see some more abstr=
act
> > description for all
> > these scenarios, before the details of an interface really could be dis=
cussed
> > and decided.
> >
> Agree.. Does above matches your requirement ?
> =

Yes, looks better. Thanks!

> =

> with regards, pekon

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
