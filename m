From: Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH] spi-imx: imx6q add single burst transfer support
Date: Wed, 1 Jun 2016 08:54:37 +0200
Message-ID: <20160601065437.GI31666@pengutronix.de>
References: <1464756628-25463-1-git-send-email-chris.ruehl@gtsys.com.hk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	anton.bondarenko.sama-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Chris Ruehl <chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1464756628-25463-1-git-send-email-chris.ruehl-CR359r9tUDPXPF5Rlphj1Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Jun 01, 2016 at 12:50:28PM +0800, Chris Ruehl wrote:
> The patch add support for single burst transfer where chipselect will
> hold active until transfer completes with a limit to 2^7 words transferred.
> The single-burst-mode need set the burstlength in ECSPI_CONREG.BURST_LENGTH
> and clear the ecspi channel related ss_ctl flag in ECSPI_CONFIGREG.SS_CTL.
> 
> The single-burst-mode is disabled by default. The activation from spidev
> is implemented by set bit0 of the xfer.speed_hz, which don't break anything
> in the mx51_ecspi_clkdiv() function.
> 
> xfer[0].speed_hz = 2000000 | 0x1; /* enable single burst mode with 1hz */

Erm, no. This is not acceptable in many ways. First of all the SPI API
between the kernel and userspace is driver agnostic. There is simply no
place for passing driver specific quirks from userspace to the spi-imx
driver. Then there is no API change needed because the way SPI
messages should be translated to the wire is well defined, the spi-imx
driver is just doing it wrong in this case which might be worth fixing.
This could be done without passing a "do it right" flag to the driver.

As noted in my response to the previous patch, I don't think we need a
fix for this at all, because we can always use GPIO chip selects which
works reliably not only in this case, but also in other cases where the
controller driven chipselect falls apart.

IMO there is only a single reason to keep controller driven chip select
support at all: On i.MX31 there is one dedicated chip select which can't
be configured as GPIO.

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
