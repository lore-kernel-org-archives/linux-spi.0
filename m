From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 2/5] Blackfin SPI: work around anomaly 05000119
Date: Thu, 17 Sep 2009 19:47:50 -0400
Message-ID: <1253231273-16423-2-git-send-email-vapier@gentoo.org>
References: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
Cc: linux-kernel@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Sonic Zhang <sonic.zhang@analog.com>
To: spi-devel-general@lists.sourceforge.net,
	David Brownell <dbrownell@users.sourceforge.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754221AbZIQXry@vger.kernel.org>
In-Reply-To: <1253231273-16423-1-git-send-email-vapier@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Anomaly 05000119 states that the DMA_RUN bit with peripherals isn't
reliable.  However, the way the driver is currently written (DMA IRQ
callback), we don't need the polling in the first place, so drop it.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/spi/spi_bfin5xx.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 8ec4969..5591bce 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -539,10 +539,6 @@ static irqreturn_t bfin_spi_dma_irq_handler(int irq, void *dev_id)
 
 	clear_dma_irqstat(drv_data->dma_channel);
 
-	/* Wait for DMA to complete */
-	while (get_dma_curr_irqstat(drv_data->dma_channel) & DMA_RUN)
-		cpu_relax();
-
 	/*
 	 * wait for the last transaction shifted out.  HRM states:
 	 * at this point there may still be data in the SPI DMA FIFO waiting
-- 
1.6.5.rc1
