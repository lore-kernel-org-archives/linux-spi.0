From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC][PATCH] spi: bcm53xx: driver for SPI controller on Broadcom
 bcma SoC
Date: Wed, 13 Aug 2014 15:28:11 +0200
Message-ID: <CACna6rxfunGa6WGRjpTkv8MO-Y6pDpxidoy_8qjyq-U5UOkGWw@mail.gmail.com>
References: <1407933212-20530-1-git-send-email-zajec5@gmail.com>
	<20140813124342.GU17528@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140813124342.GU17528-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13 August 2014 14:43, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Aug 13, 2014 at 02:33:32PM +0200, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>> Broadcom 53xx ARM SoCs use bcma bus that contains various cores (AKA
>> devices). If board has a serial flash, it's connected over SPI and t=
he
>> bcma bus includes a SPI controller. Example log from such a board:
>> bus0: Found chip with id 53010, rev 0x00 and package 0x02
>> (...)
>> bus0: Core 18 found: SPI flash controller (manuf 0x4BF, id 0x50A, re=
v 0x01, class 0x0)
>>
>> This patch adds a bcma driver for SPI core, it registers SPI master
>> controller and "bcm53xxspiflash" SPI device.
>> ---
>
> You need to sign off your changes, please see Documentation/Submittin=
gPatches
> for details.

Sure, I know, I just dropped S-o-B because it was RFC :)

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
