From: Michael Grzeschik <mgr-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH 0/3] spi: bitbang fixes and passive serial driver
Date: Wed, 12 Mar 2014 16:42:22 +0100
Message-ID: <20140312154222.GA4234@pengutronix.de>
References: <1394637636-29042-1-git-send-email-m.grzeschik@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-arm-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org
To: Michael Grzeschik <m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1394637636-29042-1-git-send-email-m.grzeschik-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Mar 12, 2014 at 04:20:33PM +0100, Michael Grzeschik wrote:
> This series includes a bugfix and adds LSB mode for the bitbang driver.
> It also includes a new character device driver to passively clock a
> firmware into an FPGA.
> 
> Michael Grzeschik (3):
>   spi: bitbang: fix shift for getmosi
>   spi: bitbang: add lsb first support
>   spi: psdev: add passive serial driver
> 
>  drivers/spi/Kconfig            |   9 +
>  drivers/spi/Makefile           |   1 +
>  drivers/spi/spi-bitbang-txrx.h |  98 +++++---
>  drivers/spi/spi-bitbang.c      |   3 +-
>  drivers/spi/spipsdev.c         | 520 +++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 601 insertions(+), 30 deletions(-)
>  create mode 100644 drivers/spi/spipsdev.c
> 
> -- 
> 1.9.0

Got the linux-arm-kernel list wrong. Will resend.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
