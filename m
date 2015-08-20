From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3] nand: Add NAND driver for Mikrotik RB4xx series boards
Date: Thu, 20 Aug 2015 15:31:05 -0700
Message-ID: <20150820223105.GB81844@google.com>
References: <1431689631-7217-1-git-send-email-bert@biot.com>
 <20150721202904.GK24125@google.com>
 <55C1DF18.4090800@biot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, fransklaver-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
To: Bert Vermeulen <bert-Nh2F35Ii2RQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55C1DF18.4090800-Nh2F35Ii2RQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Aug 05, 2015 at 12:02:00PM +0200, Bert Vermeulen wrote:
> On 07/21/2015 10:29 PM, Brian Norris wrote:
> 
> >> +static struct spi_driver rb4xx_cpld_driver = {
> >> +	.probe = rb4xx_cpld_probe,
> >> +	.remove = rb4xx_cpld_remove,
> >> +	.driver = {
> >> +		.name = "rb4xx-cpld",
> >> +		.owner = THIS_MODULE,
> >> +	},
> >> +};
> > 
> > I feel some deja vu here (did I make this comment before?); why do you
> > need to embed both a SPI and a platform driver here? It appears that the
> > NAND controller actually sits on the SPI bus, so this really is not a
> > platform driver; it's a SPI driver. Can you just kill off all the
> > platform_driver stuff and merge the probe functions?
> > 
> > Or if I'm missing something big, please do enlighten.
> 
> This driver was specifically refused by the SPI subsystem maintainer:
> 
>   http://www.linux-mips.org/archives/linux-mips/2015-03/msg00422.html

We're speaking past each other here a bit: I was recommending a SPI
*device* driver, not a host controller driver [1]. (This device is
definitely not a SPI controller!)

> He suggested the MFD subsystem, where it was also refused:
> 
>   http://lkml.iu.edu/hypermail/linux/kernel/1504.0/03162.html

I honestly can't straighten out what the definition of an MFD is, so I
can't blame you for getting that one "wrong."

> Andy Shevchenko suggested drivers/misc, so I mailed Arnd Bergmann and asked
> if he would accept it there.
> 
> Arnd took a good look at the driver and suggested the MTD/NAND subsystem.
> This is after all a driver for a NAND chip controller. The controller just
> happens to reside in a CPLD with custom firmware, which is controlled via
> SPI and has some GPIO controller functionality thrown in.

I think Arnd was right, from the looks of it. I don't mind the GPIO
controller functionality thrown in, as long as someone from linux-gpio
can review that part. I just minded the structure of the driver itself,
in which you register both a platfrom and a spi driver
(spi_register_driver() and module_platform_driver()).

AFAICT, the driver structure and your above comment suggest that the
entire device essentially sits on the SPI bus (not the platform bus), so
it seems like it can all be initialized behind module_spi_driver().

> I realize it's an odd hardware setup, and I can't fix that, but this really
> does seem to be the best place for it.
> 
> I can deal with your other comments on the patch, but I'd really like some
> agreement on where this driver will be accepted first. I've come full circle
> with getting referred back to the SPI subsystem.

Sorry again for the confusion. To be clear, I'm *not* suggesting sending
this back to the SPI subsystem.

Brian

[1] I guess the SPI documentation (Documentation/spi/spi-summary) calls
    these "controller" vs. "protocol" drivers; your driver is a
    "protocol" driver and can find a home wherever that protocol makes
    sense. In this case, you're mostly doing NAND flash, therefore it
    goes in drivers/mtd/.
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
