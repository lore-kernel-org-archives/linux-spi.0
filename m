From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: psdev: add passive serial driver
Date: Fri, 14 Mar 2014 14:59:47 +0100
Message-ID: <CACRpkdZoO_hXw-p5ZHeUzMHULq_DEJNzpim0mcO5DBOgP=d60A@mail.gmail.com>
References: <1394639617-26917-1-git-send-email-m.grzeschik@pengutronix.de>
	<1394639617-26917-4-git-send-email-m.grzeschik@pengutronix.de>
	<20140312163427.GV28112@sirena.org.uk>
	<20140314101907.GF4234@pengutronix.de>
	<20140314102223.GR366@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140314102223.GR366-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Fri, Mar 14, 2014 at 11:22 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Fri, Mar 14, 2014 at 11:19:07AM +0100, Michael Grzeschik wrote:
>
>> It is actually not more than that. I took the spidev character device
>> driver as reference implementation. Any Idea where to put this driver
>> instead.
>
> Like I say somewhere where it sits with other FPGA programming stuff (if
> that's what it does) would be my first thought.

I'd suggest you try to use drivers/firmware.

That subsystem is a bit x86-centrix at the moment but looking at the
stuff that is in there (like supporting BIOS updates through sysfs and
other low-level firmware communication) this stuff is close enough.

Yours,
Linus Walleij
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
