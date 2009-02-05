From: Bryan Wu <cooloney@kernel.org>
Subject: [PATCH 2/5] Blackfin SPI Driver: add comment about full duplex dma according to David Brownell
Date: Thu,  5 Feb 2009 18:07:30 +0800
Message-ID: <1233828453-13311-3-git-send-email-cooloney@kernel.org>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Mike Frysinger <vapier.adi@gmail.com>,
	Bryan Wu <cooloney@kernel.org>
To: dbrownell@users.sourceforge.net,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759516AbZBEKGi@vger.kernel.org>
In-Reply-To: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Mike Frysinger <vapier.adi@gmail.com>

Signed-off-by: Mike Frysinger <vapier.adi@gmail.com>
Signed-off-by: Bryan Wu <cooloney@kernel.org>
---
 drivers/spi/spi_bfin5xx.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
index 74c5bb9..ce24d5e 100644
--- a/drivers/spi/spi_bfin5xx.c
+++ b/drivers/spi/spi_bfin5xx.c
@@ -766,9 +766,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		width, transfer->len);
 
 	/*
-	 * Try to map dma buffer and do a dma transfer if
-	 * successful use different way to r/w according to
-	 * drv_data->cur_chip->enable_dma
+	 * Try to map dma buffer and do a dma transfer.  If successful use,
+	 * different way to r/w according to the enable_dma settings and if
+	 * we are not doing a full duplex transfer (since the hardware does
+	 * not support full duplex DMA transfers).
 	 */
 	if (!full_duplex && drv_data->cur_chip->enable_dma
 				&& drv_data->len > 6) {
-- 
1.5.6.3
