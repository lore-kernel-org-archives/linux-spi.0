From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH] spi: core: Ignore unsupported spi-[tr]x-bus-width property values
Date: Mon, 26 May 2014 14:05:25 +0200
Message-ID: <1401105925-16528-1-git-send-email-geert+renesas@glider.be>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Rejecting unsupported values of spi-tx-bus-width and spi-rx-bus-width
may break compatibility with future DTs. Just ignore them, falling back
to Single SPI Transfers.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
I thought I sent this before, but I can't find any evidence

 drivers/spi/spi.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 074f55f5d5ec..d4f9670b51bc 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1270,11 +1270,10 @@ static void of_register_spi_devices(struct spi_master *master)
 				spi->mode |= SPI_TX_QUAD;
 				break;
 			default:
-				dev_err(&master->dev,
-					"spi-tx-bus-width %d not supported\n",
-					value);
-				spi_dev_put(spi);
-				continue;
+				dev_warn(&master->dev,
+					 "spi-tx-bus-width %d not supported\n",
+					 value);
+				break;
 			}
 		}
 
@@ -1289,11 +1288,10 @@ static void of_register_spi_devices(struct spi_master *master)
 				spi->mode |= SPI_RX_QUAD;
 				break;
 			default:
-				dev_err(&master->dev,
-					"spi-rx-bus-width %d not supported\n",
-					value);
-				spi_dev_put(spi);
-				continue;
+				dev_warn(&master->dev,
+					 "spi-rx-bus-width %d not supported\n",
+					 value);
+				break;
 			}
 		}
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
