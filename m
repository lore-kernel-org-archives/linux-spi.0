From: Sonic Zhang <sonic.adi@gmail.com>
Subject: [PATCH] spi:spi_bfin5xx: SPI SSEL deasserted too early in soft irq mode.
Date: Thu, 11 Aug 2011 18:49:21 +0800
Message-ID: <1313059761-24703-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <spi-devel-general@lists.sourceforge.net>,
	LKML <linux-kernel@vger.kernel.org>,
	<uclinux-dist-devel@blackfin.uclinux.org>,
	Sonic Zhang <sonic.zhang@analog.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Sonic Zhang <sonic.zhang@analog.com>

Poll the FIFO till it is empty before deassert SSEL in pump_transfers in
soft irq mode. No polling is necessary in interrupt mode and error handling.

Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
---
 drivers/spi/spi-bfin5xx.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
index b8d25f2..b9e7e4d 100644
--- a/drivers/spi/spi-bfin5xx.c
+++ b/drivers/spi/spi-bfin5xx.c
@@ -870,8 +870,10 @@ static void bfin_spi_pump_transfers(unsigned long data)
 		message->actual_length += drv_data->len_in_bytes;
 		/* Move to next transfer of this msg */
 		message->state = bfin_spi_next_transfer(drv_data);
-		if (drv_data->cs_change)
+		if (drv_data->cs_change) {
+			bfin_spi_flush(drv_data);
 			bfin_spi_cs_deactive(drv_data, chip);
+		}
 	}
 
 	/* Schedule next transfer tasklet */
-- 
1.7.0.4
