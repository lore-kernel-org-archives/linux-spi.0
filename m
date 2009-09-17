From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/5] Blackfin SPI: force sane state at boot
Date: Thu, 17 Sep 2009 19:47:51 -0400
Message-ID: <1253231273-16423-3-git-send-email-vapier@gentoo.org>
References: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Wolfgang Muees <wolfgang.mues@auerswald.de>
To: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754602AbZIQXsH@vger.kernel.org>
In-Reply-To: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

We should make sure the SPI controller is in a sane state in case the
boot loader left it in a crappy state.  Such as DMA pending which causes
interrupts to fire on us.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/spi/spi_bfin5xx.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 5591bce..3249c5d 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -1334,6 +1334,12 @@ static int __init bfin_spi_probe(struct platform_device *pdev)
 		goto out_error_queue_alloc;
 	}
 
+	/* Reset SPI registers. If these registers were used by the boot loader,
+	 * the sky may fall on your head if you enable the dma controller.
+	 */
+	write_CTRL(drv_data, 0x0400);
+	write_FLAG(drv_data, 0xFF00);
+
 	/* Register with the SPI framework */
 	platform_set_drvdata(pdev, drv_data);
 	status = spi_register_master(master);
-- 
1.6.5.rc1
