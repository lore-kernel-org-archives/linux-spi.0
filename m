From: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support in
 Zynq MPSoC GQSPI controller
Date: Tue, 14 Jul 2015 09:54:28 +0530
Message-ID: <CAFcVEC+yqK37YjsrN_KZ2KrXydvg=Tx_ur9hhvM1g9kdfTCRVQ@mail.gmail.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
	<OFDDDA0AA7.A583461A-ONC1257E81.0030FCED-C1257E81.003761EE@rohde-schwarz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ranjit Waghmode <ranjit.waghmode-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	linux-mtd <linux-mtd-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	=?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex-ynQEQJNshbs@public.gmane.org>,
	ben-/+tVBieCtBitmTQ+vhA3Yw@public.gmane.org, zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	=?UTF-8?Q?S=C3=B6ren_Brinkmann?= <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	shijie.huang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	Punnaiah Choudary Kalluri <punnaia-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	Ranjit Waghmode <ran27jit-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Michal Simek <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <OFDDDA0AA7.A583461A-ONC1257E81.0030FCED-C1257E81.003761EE-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Thomas,

On Mon, Jul 13, 2015 at 3:34 PM,  <Thomas.Betker-Bf/A/FSCP0w3s4ca2cGeAgC/G2K4zDHf@public.gmane.org> wrote:
> Hello Ranjit:
>
>> What is dual parallel mode?
>> ---------------------------
>> ZynqMP GQSPI controller supports Dual Parallel mode with following
>> functionalities:
>> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
>> 2) Chip selects and clock are shared to both the flash devices
>> 3) This mode is targeted for faster read/write speed and also doubles
> the size
>> 4) Commands/data can be transmitted/received from both the
> devices(mirror),
>>    or only upper or only lower flash memory devices.
>> 5) Data arrangement:
>>    With stripe enabled,
>>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.
>
> In the dual-parallel configuration, odd and even _bits_ of each byte are
> distributed over the flash chips; I am assuming this works just as in Zynq
> QSPI (apparently, the TRM for ZynqMP isn't out yet).
>
> Striping seems to be a different mechanism, though. Can you explain it a
> bit more? Also, the wording seems to indicate that it belongs to
> dual-stacked rather than dual-parallel.

This differs between Zynq and ZynqMP.
Bytes are alternated between the two flash devices in ZynqMP.
In Zynq, bits were alternated.
This is dual parallel because both the chips can be selected at the same time
and have two separate data bus connected. One of the two can be done:
1. Enable Stripe - data bytes 0,2,4... to one flash and data bytes
1,3,5.. to the other
This is typically used for read and write memory operations.
2. Disable Stripe (Mirror) - all the bytes are sent to both flash devices.
This is typically used for control operations such as WriteEnable etc.

>
>> Suggestions on MTD layer support
>> --------------------------------
>> In order to add above two specified modes, we may required to get some
>> support from MTD layer.
>>
>> I'm trying to list the dependencies as follows:
>> 1) Support for two flashes
>> 2) Enable/Disable data stripe as and when required.
>> 3) May need to update read_sr() to get status of both flashes
>> 4) May also need to update read_fsr() to get status of both flashes
>> 5) Adjustment of offset value based on the parallel/stacked mode
> configuration
>> 6) Setting either parallel or stacked mode during the scan process.
>> 7) In case of stacked mode, is there a MTD concatenation support?
>
> In addition to 5), the MTD driver using a dual-parallel QSPI flash has to
> 5a) add padding at the start of data for unaligned addresses,
> 5b) add padding at the end of data for unaligned lengths.

In dual-parallel in ZynqMP, we no longer stripe bits, eliminating
the need for padding unaligned lengths.

Regards,
Harini

>
> Best regards,
> Thomas Betker
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
