From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 0/2] spi: Fix multi probing with overlays
Date: Mon, 30 Nov 2015 15:28:05 +0100
Message-ID: <1448893687-9159-1-git-send-email-geert+renesas@glider.be>
Cc: Michael Fiore <mfjord02-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Pantelis Antoniou <pantelis.antoniou-OWPKS81ov/FWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

	Hi Mark, Pantelis,

This patch series fixes the issue where an SPI slave device is
registered twice when loading a DT overlay that enables or adds an SPI
master with a populated SPI bus:

    spi_sh_msiof e6e10000.spi: chipselect 0 already in use
    spi_master spi2: spi_device register error /spi@e6e10000/spidev@0
    of_spi_notify: failed to create for '/spi@e6e10000/spidev@0'

The approach followed is similar to what's currently done on i2c, as
suggested by Mark.

Thanks!

Geert Uytterhoeven (2):
  spi: Uninline spi_unregister_device()
  spi: Mark instantiated device nodes with OF_POPULATE

 drivers/spi/spi.c       | 29 +++++++++++++++++++++++++++++
 include/linux/spi/spi.h |  7 +------
 2 files changed, 30 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
