From: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] spi: altera: Add empty implementation of setup_transfer callback
Date: Thu,  9 Apr 2015 17:54:13 +0200
Message-ID: <1428594853-24640-1-git-send-email-per.nilsson@xelmo.com>
References: <1428591822-24279-1-git-send-email-per.nilsson@xelmo.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	nios2-dev-g9ZBwUv/Ih/yUk5EbOjzuce+I+R0W71w@public.gmane.org
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1428591822-24279-1-git-send-email-per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

spi-altera driver is broken and causes a kernel panic due to a NULL
pointer dereference during first SPI transaction. The setup_transfer()
bitbang callback is mandatory when the txrx_bufs() callback is
present. It was therefore an error to remove it in commit
30af9b558a56. This patch simply adds back an empty implementation of
the callback.

Signed-off-by: Pelle Nilsson <per.nilsson-5TWeZ6kPplYAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/spi-altera.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-altera.c b/drivers/spi/spi-altera.c
index b95010e..6d72b1d 100644
--- a/drivers/spi/spi-altera.c
+++ b/drivers/spi/spi-altera.c
@@ -197,6 +197,11 @@ static irqreturn_t altera_spi_irq(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+static int altera_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	return 0;
+}
+
 static int altera_spi_probe(struct platform_device *pdev)
 {
 	struct altera_spi *hw;
@@ -220,6 +225,7 @@ static int altera_spi_probe(struct platform_device *pdev)
 
 	/* setup the state for the bitbang driver */
 	hw->bitbang.master = master;
+	hw->bitbang.setup_transfer = altera_spi_setupxfer;
 	hw->bitbang.chipselect = altera_spi_chipsel;
 	hw->bitbang.txrx_bufs = altera_spi_txrx;
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
