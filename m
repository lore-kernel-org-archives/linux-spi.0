From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCHv3 1/2] spi: imx: fix use of native chip-selects with
 devicetree
Date: Thu, 10 Aug 2017 17:17:33 +0200
Message-ID: <20170810151733.u6r7ex3ng5kolgfb@pengutronix.de>
References: <2892f819-f1a2-b68d-be01-e8ac7f4b4222@linux-m68k.org>
 <20170724062147.o7tccwskxfuls3ej@pengutronix.de>
 <239ae959-ce96-711b-dbfb-4e892b7eab3b@linux-m68k.org>
 <8ccba0c6-cd35-db2e-6a3f-32b79609271d@pengutronix.de>
 <b3e80e47-d1e5-41f9-a744-dc01e51d779e@mentor.com>
 <b0b60f4a-7ee9-c0e5-9eb0-ac6a29555e5c@linux-m68k.org>
 <20170810114938.bsuztdxmngys2ekg@pengutronix.de>
 <6dea9014-6e45-199b-16de-418728757662@linux-m68k.org>
 <20170810124049.msmi2pfqmpoafsml@pengutronix.de>
 <ac92f8ad-3ba6-a577-dc9c-9e8b6689afd4@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Cc: Oleksij Rempel <ore-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Vladimir Zapolskiy <vladimir_zapolskiy-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Greg Ungerer <gerg-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <ac92f8ad-3ba6-a577-dc9c-9e8b6689afd4-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

On Thu, Aug 10, 2017 at 11:21:14PM +1000, Greg Ungerer wrote:
> > If I understood correctly the current state is the following:
> > 
> > The spi-imx driver supports GPIOs as CS and a "native" mode where the
> > hardware drives the CS line. If you write:
> > 
> > 	cs-gpios = <&gpio2 0 0>, <0>, <&gpio1 17 0>
> > 
> > That means: Use gpio2.0 as CS 0, native CS as CS 1 and gpio1.17 as CS 2.
> 
> That is correct, yes. But the current driver is buggy and does not
> handle the "native" mode correctly - the intention of the patch
> at the start of this thread is to fix this.

Right, and I had the impression, that this "fix" was discussed away with
"if the dtb is broken, there is no hope and so nothing to fix". That's
what I wanted to speak up against.
 
> > So what the driver can check here: Does the dtb request a native CS at a
> > position that is not supported by the hardware. Of course even if there
> 
> How does the driver know how many chip-selects are natively supported
> by the hardware?
> 
> I am not familar with all iMX parts and their spi controllers, but
> Oleksij suggested in an earlier email that some have 3 native chip
> selects, some have 4, other variants may have some other number.

Via the compatible is the obvious way to determine that.
 
Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
