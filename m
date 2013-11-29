From: Michal Nazarewicz <mpn-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: tegra: avoid unsigned->signed->unsigned promotion
Date: Fri, 29 Nov 2013 18:12:44 +0100
Message-ID: <1385745164-10534-1-git-send-email-mpn@google.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>

u8 type, which is unsigned, is promoted to int, which is singned, when
doing a binary shift.  Then, on 64-bit machines, it is further promoted
to unsigned long which may lead to more significant half of the value
to be all ones.  To avoid this, explicitly promote to an unsigned type.

Signed-off-by: Michal Nazarewicz <mina86-deATy8a+UHjQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-tegra114.c      | 4 ++--
 drivers/spi/spi-tegra20-slink.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-tegra114.c b/drivers/spi/spi-tegra114.c
index aaecfb3..2dadc3f 100644
--- a/drivers/spi/spi-tegra114.c
+++ b/drivers/spi/spi-tegra114.c
@@ -315,7 +315,7 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 		for (count = 0; count < max_n_32bit; count++) {
 			x = 0;
 			for (i = 0; (i < 4) && nbytes; i++, nbytes--)
-				x |= (*tx_buf++) << (i*8);
+				x |= (unsigned)(*tx_buf++) << (i*8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
 	} else {
@@ -326,7 +326,7 @@ static unsigned tegra_spi_fill_tx_fifo_from_client_txbuf(
 			x = 0;
 			for (i = 0; nbytes && (i < tspi->bytes_per_word);
 							i++, nbytes--)
-				x |= ((*tx_buf++) << i*8);
+				x |= (unsigned)(*tx_buf++) << (i*8);
 			tegra_spi_writel(tspi, x, SPI_TX_FIFO);
 		}
 	}
diff --git a/drivers/spi/spi-tegra20-slink.c b/drivers/spi/spi-tegra20-slink.c
index e66715b..0fc4f7d 100644
--- a/drivers/spi/spi-tegra20-slink.c
+++ b/drivers/spi/spi-tegra20-slink.c
@@ -331,7 +331,7 @@ static unsigned tegra_slink_fill_tx_fifo_from_client_txbuf(
 		for (count = 0; count < max_n_32bit; count++) {
 			x = 0;
 			for (i = 0; (i < 4) && nbytes; i++, nbytes--)
-				x |= (*tx_buf++) << (i*8);
+				x |= (unsigned)(*tx_buf++) << (i*8);
 			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
 		}
 	} else {
@@ -342,7 +342,7 @@ static unsigned tegra_slink_fill_tx_fifo_from_client_txbuf(
 			x = 0;
 			for (i = 0; nbytes && (i < tspi->bytes_per_word);
 							i++, nbytes--)
-				x |= ((*tx_buf++) << i*8);
+				x |= (unsigned)(*tx_buf++) << (i*8);
 			tegra_slink_writel(tspi, x, SLINK_TX_FIFO);
 		}
 	}
-- 
1.8.4.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
