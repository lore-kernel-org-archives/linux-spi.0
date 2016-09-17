From: Heiner Kallweit <heiner.kallweit-S0/GAf8tV78@public.gmane.org>
Subject: [PATCH 0/4] spi: fsl-espi: further smaller improvements
Date: Sat, 17 Sep 2016 15:42:31 +0200
Message-ID: <670a3e70-d53e-5474-f458-2bc506b2c366@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Before coming to functional extensions, here come four more
smaller improvements.

Heiner Kallweit (4):
  spi: fsl-espi: remove unused variable in fsl_espi_setup
  spi: fsl-espi: simplify of_fsl_espi_probe
  spi: fsl-espi: improve return value handling in fsl_espi_probe
  spi: fsl-espi: replace of_get_property with of_property_read_u32

 drivers/spi/spi-fsl-espi.c | 82 ++++++++++++++++++----------------------------
 1 file changed, 32 insertions(+), 50 deletions(-)

-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
