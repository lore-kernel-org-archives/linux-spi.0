From: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v3 2/4] spi: imx: Fix failure path leak on GPIO request error
Date: Tue, 31 Oct 2017 12:49:05 -0700
Message-ID: <20171031194907.29108-3-tpiepho@impinj.com>
References: <20171031194907.29108-1-tpiepho@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20171031194907.29108-1-tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

If the code that requests any chip select GPIOs fails, the cleanup of
spi_bitbang_start() by calling spi_bitbang_stop() is not done.  Add this
to the failure path.

Note that spi_bitbang_start() has to be called before requesting GPIOs
because the GPIO data in the spi master is populated when the master is
registed, and that doesn't happen until spi_bitbang_start() is called.

CC: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
CC: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>
CC: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
CC: Oleksij Rempel <o.rempel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Signed-off-by: Trent Piepho <tpiepho-cgc2CodaaHDQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-imx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 76bf0e4fc2c7..ad54f8258513 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -1638,7 +1638,7 @@ static int spi_imx_probe(struct platform_device *pdev)
 			if (ret) {
 				dev_err(&pdev->dev, "Can't get CS GPIO %i\n",
 					master->cs_gpios[i]);
-				goto out_clk_put;
+				goto out_spi_bitbang;
 			}
 		}
 	}
@@ -1649,6 +1649,8 @@ static int spi_imx_probe(struct platform_device *pdev)
 	clk_disable(spi_imx->clk_per);
 	return ret;
 
+out_spi_bitbang:
+	spi_bitbang_stop(&spi_imx->bitbang);
 out_clk_put:
 	clk_disable_unprepare(spi_imx->clk_ipg);
 out_put_per:
-- 
2.14.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
