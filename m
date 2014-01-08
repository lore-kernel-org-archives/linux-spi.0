From: Richard Genoud <richard.genoud-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: atmel: add support for changing message transfer speed
Date: Wed, 8 Jan 2014 11:15:13 +0100
Message-ID: <CACQ1gAhsKeQUB_vN9iJDbBsJ+7CiOZH8O=ZPg96pP8qRDHf15g@mail.gmail.com>
References: <1383816846-10561-1-git-send-email-richard.genoud@gmail.com> <20131108111152.GL2493@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Nicolas Ferre <nicolas.ferre-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Wenyou Yang <Wenyou.Yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20131108111152.GL2493-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2013/11/8 Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>:
> On Thu, Nov 07, 2013 at 10:34:06AM +0100, Richard Genoud wrote:
>> The only speed available was max_speed (the maximum speed declared for a
>> device).
>> This patch adds the support for spi_tranfer->speed_hz parameter.
>> We can now set a different speed for each spi message.
>
> Applied, thanks.

It seems that this patch got lost (or I missed something).
As it will now conflict with Wenyou patch "Refactor spi-atmel to use
SPI framework queue",
should I resent it based on wenyou's path ?
or on broonie/spi.git for-next and wenyou will rebase his patch on mine ?
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
