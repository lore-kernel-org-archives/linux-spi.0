From: christophe leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] spi_mpc8xxx: fix writing to adress 0
Date: Thu, 16 Sep 2010 09:04:20 +0200 (CEST)
Message-ID: <20100916070420.95083C7391@messagerie.si.c-s.fr>
To: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This patch applies to 2.6.34.7 (already included in 2.6.35.4)
It fixes an issue when sending only or receiving only (mspi->tx-dma was reset as when no tx_buf is defined, tx_dma is 0)

Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

diff -urN a/drivers/spi/spi_mpc8xxx.c b/drivers/spi/spi_mpc8xxx.c
--- a/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:42:30.000000000 +0200
+++ b/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:43:50.000000000 +0200
@@ -438,7 +438,7 @@
 			dev_err(dev, "unable to map tx dma\n");
 			return -ENOMEM;
 		}
-	} else {
+	} else if (t->tx_buf) {
 		mspi->tx_dma = t->tx_dma;
 	}
 
@@ -449,7 +449,7 @@
 			dev_err(dev, "unable to map rx dma\n");
 			goto err_rx_dma;
 		}
-	} else {
+	} else if (t->rx_buf) {
 		mspi->rx_dma = t->rx_dma;
 	}
