From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: spi-imx: add support for single burst mode (8,16,32)
Date: Wed, 1 Jun 2016 08:30:29 +0200
Message-ID: <20160601063029.GB11074@pengutronix.de>
References: <574D5C2B.1000400@gtsys.com.hk>
 <CAOMZO5CiW3J+naHfitjv59i4xisYB1R3ATs2qvz4mLh_FMyf+g@mail.gmail.com>
 <20160531110608.GG31666@pengutronix.de>
 <574E405F.9090000@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Anton Bondarenko <anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <574E405F.9090000-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 01, 2016 at 09:54:39AM +0800, Chris Ruehl wrote:
> On Tuesday, May 31, 2016 07:06 PM, Sascha Hauer wrote:
> >On Tue, May 31, 2016 at 07:43:37AM -0300, Fabio Estevam wrote:
> >>[Adding Sascha and Anton in Cc]
> >>
> >>On Tue, May 31, 2016 at 6:40 AM, Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org> wrote:
> >>>Hi,
> >>>
> >>>as imx6 using multiple burst to send data to spi slaves and drop the
> >>>chipselect between the words by default my sensor NXP MPL115A1 wasn't
> >>>working.
> >
> >I generally recommend to use GPIO Chip selects. The SPI controller has
> >its own ideas when to assert the chipselects which is hard to match (if
> >possible at all) with what Linux SPI expects. See the cs-gpios device
> >tree property.
> >
> >Sascha
> 
> Sascha that's a good approach to fight this problem, if you have the
> choice. Sadly my hardware design is finished and I can only switch to
> a gpio by run wires on the finished PCB.. and that's not what I want.

I'm not suggesting to change your hardware. Every chipselect pin can be
configured as GPIO aswell, i.e. exchange
MX6QDL_PAD_DISP0_DAT3__ECSPI3_SS0 with MX6QDL_PAD_DISP0_DAT3__GPIO4_IO24
and be done with it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
