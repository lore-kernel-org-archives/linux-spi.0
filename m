From: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: support DUAL and QUAD[patch v1]
Date: Tue, 16 Jul 2013 19:59:13 +0800
Message-ID: <CAHSAbzO-NSt8Gd1PkWf=LM5e+AGL4yKiu8ZFn1zyhQ4vKO5qcQ@mail.gmail.com>
References: <CAHSAbzP0Nc1ahf_ra6yDuMvV998_+EGcUOGDv5ifKaagYf+NOg@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E84D2@DBDE04.ent.ti.com>
	<CAHSAbzMDOWo5oBqUHqMxybuDwUjFbczYwN+85gH+rxZ9z8u2Pw@mail.gmail.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E851E@DBDE04.ent.ti.com>
	<593AEF6C47F46446852B067021A273D6D93B49E1@MUCSE039.lantiq.com>
	<20980858CB6D3A4BAE95CA194937D5E73E9E85D0@DBDE04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org" <thomas.langer-th3ZBGNqt+7QT0dZR+AlfA@public.gmane.org>, "Poddar,
	Sourav" <sourav.poddar-l0cyMroinI0@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Gupta, Pekon" <pekon-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20980858CB6D3A4BAE95CA194937D5E73E9E85D0-yXqyApvAXouIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
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

2013/7/16 Gupta, Pekon <pekon-l0cyMroinI0@public.gmane.org>:
>>
>> Hello Pekon,
>>
>> Gupta, Pekon wrote on 2013-07-16:
>> > >
>> > > Hi, Gupta
>> > >
>> > >
>> > > > [Pekon]: Instead of adding new fields you can use existing 'mode' field
>> to
>> > > > pass on the platform specific configurations. And if 'u8 mode' does not
>> > > > suffice you can increase it to 'u32'.
>> > > > #define QSPI_MODE       1 << 5; // just check which bit-fields are un-
>> used
>> > > > spi_board_info->mode |= QSPI_MODE;
>> > > >
>> > >
>> > > well, can dual and quad be regarded as a spi mode? if so, your comment
>> > > seems
>> > > to be right.
>> >
>> > Yes, Quad and Dual modes should be regarded as extension of SPI
>> protocol.
>> > - They follow the same basic principle of synchronous data transfer. Right ?
>> > - These modes are not adding any extra side-band | In-band signaling or
>> > controls to modify the protocol. They are just increasing the width of
>> >  data-channel for better throughput.
>> >
>> > with regards, pekon
>> >
>>
>> In general, yes. But I think, for the interface we have to take care of more
>> details.
>>
>> For example, what happens in the following situation:
>> We have a spi-controller, which supports the QSPI mode, and a spi-flash,
>> which fulfils
>> the requirements, but the board has not connected all signals?
>>
> [Pekon]: So, actual implementation should set QSPI_MODE based on both
> (1) device capabilities (detected in probe)
> (2) board-DT properties (this would take care of your other constrains)
>
I think the name QSPI_MODE is not siutable. Not only QSPI support dual and quad.

>> And the interface for the slave-driver (like m25p80) should allow to specify
>> the transfer mode
>> for each spi_message.
>> This will be necessary, because it depends on the flash and mode, how each
>> phase of "cmd",
>> "address", and "data" will be transferred.
>>
> [Pekon]: Are you saying that same controller can send interleaved
> Quad-SPI and Single-SPI spi_messages to same device (here flash device)?
>
> Is it due to flash-device constrain that it accepts some flash-commands
> (like erase, etc) only on Single-wire-SPI, whereas  data transfers can be
> Performed on Quad-SPI mode ?
> In such case you need to add 'mode' field in struct spi_message, so that
> this information moves along with the spi_message in queue. And then
> when that message reaches spi_pump_message() and
> transfer_one_message() is called, then you can do needful configs.
>
> However, I still don't think you need to control 'QSPI_MODE' at granularity
> of spi_transfer level, because m25p80 flash-driver use spi_write() API to
> pass data to SPI driver, which internally creates a spi_message in each call.
>
> Following best explains use of spi_message in /include/linux/spi.h
> ---------------------------------------------------
> * A @spi_message is used to execute an atomic sequence of data transfers,
>  * each represented by a struct spi_transfer.  The sequence is "atomic"
>  * in the sense that no other spi_message may use that SPI bus until that
>  * sequence completes.  On some systems, many such sequences can execute as
>  * as single programmed DMA transfer.  On all systems, these messages are
>  * queued, and might complete after transactions to other devices.  Messages
>  * sent to a given spi_device are alway executed in FIFO order.
> ---------------------------------------------------
>
>
what thomas means that some flash device will do read or write in
different mode. example:
cmd with single mode;
addr with quad mode;
data with quad mode;
So we really can not decide how to organise the spi_message just based
on QSPI_MODE.
But to this question, because there is no standard for all the
serial-flash and different serial-flash may have different sequences.
Thus what we can do is to provide the interface in spi framework. To
different slave, we should adjust the driver by ourselves.

>> I don't know, if it is only me, but I would like to see some more abstract
>> description for all
>> these scenarios, before the details of an interface really could be discussed
>> and decided.
>>
> Agree.. Does above matches your requirement ?
>
Thanks for your advice and I will provide a patch later. please help me review.
>
> with regards, pekon
>
>> Best Regards,
>> Thomas
>

------------------------------------------------------------------------------
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=48808831&iu=/4140/ostg.clktrk
