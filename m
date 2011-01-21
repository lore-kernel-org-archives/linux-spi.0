From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH 3/3] SPI: spi_sh_msiof: fix wrong address calculation, which
 leads to an Oops
Date: Fri, 21 Jan 2011 16:56:47 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101211655550.18867@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

NULL + <small offset> != NULL, but reading from that <small offset> address
is usually not a very good idea and often leads to problems, like kernel
Oopses in this case, easily reproducible by writing to an SD-card, used in
SPI mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/spi/spi_sh_msiof.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi_sh_msiof.c b/drivers/spi/spi_sh_msiof.c
index 658bd05..6d30829 100644
--- a/drivers/spi/spi_sh_msiof.c
+++ b/drivers/spi/spi_sh_msiof.c
@@ -568,9 +568,11 @@ static int sh_msiof_spi_txrx(struct spi_device *spi, struct spi_transfer *t)
 	bytes_done = 0;
 
 	while (bytes_done < t->len) {
+		void *rx_buf = t->rx_buf ? t->rx_buf + bytes_done : NULL;
+		const void *tx_buf = t->tx_buf ? t->tx_buf + bytes_done : NULL;
 		n = sh_msiof_spi_txrx_once(p, tx_fifo, rx_fifo,
-					   t->tx_buf + bytes_done,
-					   t->rx_buf + bytes_done,
+					   tx_buf,
+					   rx_buf,
 					   words, bits);
 		if (n < 0)
 			break;
-- 
1.7.2.3

