From: Kamal Dasu <kdasu.kdev@gmail.com>
Subject: [PATCH v1 1/2] spi: bcm-qspi: Avoid setting MSPI_CDRAM_PCS for spi-nor master
Date: Wed, 25 Apr 2018 14:28:04 -0400
Message-ID: <1524680885-4600-2-git-send-email-kdasu.kdev@gmail.com>
References: <1524680885-4600-1-git-send-email-kdasu.kdev@gmail.com>
Cc: f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        jon.mason@broadcom.com, yendapally.reddy@broadcom.com,
        Kamal Dasu <kdasu.kdev@gmail.com>
To: broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1524680885-4600-1-git-send-email-kdasu.kdev@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Added fix for probing of spi-nor device non-zero chip selects. Set
MSPI_CDRAM_PCS (peripheral chip select) with spi master for MSPI
controller and not for MSPI/BSPI spi-nor master controller. Ensure
setting of cs bit in chip select register on chip select change.

Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>
---
 drivers/spi/spi-bcm-qspi.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-bcm-qspi.c b/drivers/spi/spi-bcm-qspi.c
index 1596d35..2946989 100644
--- a/drivers/spi/spi-bcm-qspi.c
+++ b/drivers/spi/spi-bcm-qspi.c
@@ -519,16 +519,19 @@ static void bcm_qspi_disable_bspi(struct bcm_qspi *qspi)
 
 static void bcm_qspi_chip_select(struct bcm_qspi *qspi, int cs)
 {
-	u32 data = 0;
+	u32 rd = 0;
+	u32 wr = 0;
 
-	if (qspi->curr_cs == cs)
-		return;
 	if (qspi->base[CHIP_SELECT]) {
-		data = bcm_qspi_read(qspi, CHIP_SELECT, 0);
-		data = (data & ~0xff) | (1 << cs);
-		bcm_qspi_write(qspi, CHIP_SELECT, 0, data);
+		rd = bcm_qspi_read(qspi, CHIP_SELECT, 0);
+		wr = (rd & ~0xff) | (1 << cs);
+		if (rd == wr)
+			return;
+		bcm_qspi_write(qspi, CHIP_SELECT, 0, wr);
 		usleep_range(10, 20);
 	}
+
+	dev_dbg(&qspi->pdev->dev, "using cs:%d\n", cs);
 	qspi->curr_cs = cs;
 }
 
@@ -755,8 +758,13 @@ static int write_to_hw(struct bcm_qspi *qspi, struct spi_device *spi)
 			dev_dbg(&qspi->pdev->dev, "WR %04x\n", val);
 		}
 		mspi_cdram = MSPI_CDRAM_CONT_BIT;
-		mspi_cdram |= (~(1 << spi->chip_select) &
-			       MSPI_CDRAM_PCS);
+
+		if (has_bspi(qspi))
+			mspi_cdram &= ~1;
+		else
+			mspi_cdram |= (~(1 << spi->chip_select) &
+				       MSPI_CDRAM_PCS);
+
 		mspi_cdram |= ((tp.trans->bits_per_word <= 8) ? 0 :
 				MSPI_CDRAM_BITSE_BIT);
 
-- 
2.7.4
