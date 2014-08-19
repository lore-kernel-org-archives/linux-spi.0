From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V2] spi: bcm53xx: driver for SPI controller on Broadcom
 bcma SoC
Date: Tue, 19 Aug 2014 18:56:01 +0200
Message-ID: <CACna6rzO6Heqx98Gpec=g-u0v2gjMPbw1AqkWZ2whOOo1kTm=w@mail.gmail.com>
References: <1408228864-20313-1-git-send-email-zajec5@gmail.com>
	<1408293218-32439-1-git-send-email-zajec5@gmail.com>
	<20140819163106.GM24407@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140819163106.GM24407-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 19 August 2014 18:31, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Sun, Aug 17, 2014 at 06:33:38PM +0200, Rafa=C5=82 Mi=C5=82ecki wro=
te:
>> Broadcom 53xx ARM SoCs use bcma bus that contains various cores (AKA
>> devices). If board has a serial flash, it's connected over SPI and t=
he
>> bcma bus includes a SPI controller. Example log from such a board:
>> bus0: Found chip with id 53010, rev 0x00 and package 0x02
>> (...)
>> bus0: Core 18 found: SPI flash controller (manuf 0x4BF, id 0x50A, re=
v 0x01, class 0x0)
>
> Applied, thanks.

Thank YOU! :)

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
