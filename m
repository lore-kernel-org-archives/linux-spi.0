From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 1/3] spi: Introduce one new field to set word delay
Date: Thu, 16 Aug 2018 20:54:49 +0800
Message-ID: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Cc: orsonzhai@gmail.com, zhang.lyra@gmail.com,
        lanqing.liu@spreadtrum.com, baolin.wang@linaro.org,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

For some SPI controllers, after each word size (specified by bits_per_word)
transimission, the hardware need some delay to make sure the slave has enough
time to receive the whole data.

So introducing one new 'word_delay' field of struct spi_tansfer for slave
devices to set this inter word delay time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v1:
 - New patch in v2.
---
 include/linux/spi/spi.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e..d698f9d 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -711,6 +711,8 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
+ * @word_delay: clock cycles to inter word delay after each word size
+ *	(set by bits_per_word) transmission.
  * @transfer_list: transfers are sequenced through @spi_message.transfers
  * @tx_sg: Scatterlist for transmit, currently not for client use
  * @rx_sg: Scatterlist for receive, currently not for client use
@@ -793,6 +795,7 @@ struct spi_transfer {
 	u8		bits_per_word;
 	u16		delay_usecs;
 	u32		speed_hz;
+	u16		word_delay;
 
 	struct list_head transfer_list;
 };
-- 
1.7.9.5
