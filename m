From: Sifan Naeem <sifan.naeem@imgtec.com>
Subject: [PATCH] spi: img-spfi: same edge bit set to double spfi speeds
Date: Tue, 3 Feb 2015 17:46:05 +0000
Message-ID: <1422985565-14163-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	Sifan Naeem <sifan.naeem@imgtec.com>
To: <broonie@kernel.org>, <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Setting the same edge bit is required for operating at full bitrate
programmed into the SPFI control register. Without this bit set the
max operating bitrate supported would be half the maximum bitrate
supported by the img-spfi block.
It's safe to set this bit for all transactions.

Signed-off-by: Sifan Naeem <sifan.naeem@imgtec.com>
---
 drivers/spi/spi-img-spfi.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index c01567d..e6f77b8 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -39,6 +39,7 @@
 #define SPFI_CONTROL_SOFT_RESET			BIT(11)
 #define SPFI_CONTROL_SEND_DMA			BIT(10)
 #define SPFI_CONTROL_GET_DMA			BIT(9)
+#define SPFI_CONTROL_SE			BIT(8)
 #define SPFI_CONTROL_TMODE_SHIFT		5
 #define SPFI_CONTROL_TMODE_MASK			0x7
 #define SPFI_CONTROL_TMODE_SINGLE		0
@@ -435,6 +436,9 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 		val |= SPFI_CONTROL_CONTINUE;
 	spfi_writel(spfi, val, SPFI_CONTROL);
 
+	/* Double the transfer speed by setting Same Edge. */
+	val |= SPFI_CONTROL_SE;
+
 	val = spfi_readl(spfi, SPFI_PORT_STATE);
 	if (spi->mode & SPI_CPHA)
 		val |= SPFI_PORT_STATE_CK_PHASE(spi->chip_select);
-- 
1.7.9.5
