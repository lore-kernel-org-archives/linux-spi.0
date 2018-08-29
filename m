From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Introduce one new field to set word delay" to the spi tree
Date: Wed, 29 Aug 2018 12:02:32 +0100 (BST)
Message-ID: <20180829110232.2D6081124859@debutante.sirena.org.uk>
References: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, orsonzhai@gmail.com,
        zhang.lyra@gmail.com, lanqing.liu@spreadtrum.com,
        baolin.wang@linaro.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Baolin Wang <baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a77a6bb8b3abf1c127014c78f71533c24afacd93.1534423916.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Introduce one new field to set word delay

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From eeaceb8b7d1fb64b6030249ca0dd1d902ef3069e Mon Sep 17 00:00:00 2001
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 16 Aug 2018 20:54:49 +0800
Subject: [PATCH] spi: Introduce one new field to set word delay

For some SPI controllers, after each word size (specified by bits_per_word)
transimission, the hardware need some delay to make sure the slave has enough
time to receive the whole data.

So introducing one new 'word_delay' field of struct spi_tansfer for slave
devices to set this inter word delay time.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index a64235e05321..d698f9db3484 100644
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
2.18.0
