From: Stefan Popa <stefan.popa@analog.com>
Subject: [PATCH] drivers: spi: core: Add optional stall delay between cs_change transfers
Date: Tue, 19 Feb 2019 19:00:36 +0200
Message-ID: <1550595636-23598-1-git-send-email-stefan.popa@analog.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <Michael.Hennerich@analog.com>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>,
        Michael Hennerich <michael.hennerich@analog.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Michael Hennerich <michael.hennerich@analog.com>

Some devices like the ADIS16460 IMU require a stall period between
transfers. The default value of 10us are not enough. Introduce a per
transfer configurable delay.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 drivers/spi/spi.c       | 3 ++-
 include/linux/spi/spi.h | 3 +++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 9a7def7..717b92a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1144,7 +1144,8 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 				keep_cs = true;
 			} else {
 				spi_set_cs(msg->spi, false);
-				udelay(10);
+				udelay(xfer->cs_change_stall_delay_us ?
+				       xfer->cs_change_stall_delay_us : 10);
 				spi_set_cs(msg->spi, true);
 			}
 		}
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 314d922..273774c 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -702,6 +702,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  *      transfer. If 0 the default (from @spi_device) is used.
  * @bits_per_word: select a bits_per_word other than the device default
  *      for this transfer. If 0 the default (from @spi_device) is used.
+ * @cs_change_stall_delay_us: microseconds to delay between cs_change
+ *	transfers.
  * @cs_change: affects chipselect after this transfer completes
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
@@ -788,6 +790,7 @@ struct spi_transfer {
 #define	SPI_NBITS_DUAL		0x02 /* 2bits transfer */
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
+	u8		cs_change_stall_delay_us;
 	u16		delay_usecs;
 	u32		speed_hz;
 	u16		word_delay;
-- 
2.7.4
