From: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Wed, 1 Jun 2016 09:48:20 +0800
Message-ID: <574E3EE4.2030806@gtsys.com.hk>
References: <574D5C2B.1000400@gtsys.com.hk> <574D7366.5050203@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <574D7366.5050203-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tuesday, May 31, 2016 07:20 PM, Vladimir Zapolskiy wrote:
> On 31.05.2016 12:40, Chris Ruehl wrote:
>> Hi,
>>
>> as imx6 using multiple burst to send data to spi slaves and drop the chipselect
>> between the words by default my sensor NXP MPL115A1 wasn't working.
>> The hint comes from a discussion in the Freescale forum from 2013 where Jeff
>> Coffman posted his solution for a 3.x kernel.
>> I'd pick-up the idea behind and develop something which works "so far" with
>> 4.6 and linux-next
>>
>> Up front - I'm not happy using the xfer->cs_change to get set the single burst
>> I more likely want add a new xfer bit which allow to dedicated set a single burst.
>> To replace todays:
>>           xfer[0].cs_change = 0;
>> with a
>> 	xfer[0].singleburst = 1;
>>
>> An other issue with is not yet solved; when I have a odd number of bytes (8 bpw)
>> in a transfer, its result in 3 bytes eaten on the start and 0x00 added on the
>> tail -
>
> Do you use PIO or DMA transfer mode? The problem description resembles
> a known issue within SDMA firmware (referenced as TKT238285 or ERR008517)
> and you should not be able to face it, if SPI controller operates in PIO
> mode.

Board is a imx6d and its runs in DMA mode. I have the MPL115A working properly
when I keep an eye on even numbers of bytes in a transfer (which is always the 
case in a half duplex mode <cmd><00>..)

But any how thanks for this interesting info!


Chris
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
