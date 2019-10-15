From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: introduce `delay` field for `spi_transfer` + spi_transfer_delay_exec()" to the spi tree
Date: Tue, 15 Oct 2019 12:12:24 +0100 (BST)
Message-ID: <20191015111224.F1B142741DCA@ypsilon.sirena.org.uk>
References: <20190926105147.7839-9-alexandru.ardelean@analog.com>
Cc: baolin.wang@linaro.org, bcm-kernel-feedback-list@broadcom.com,
        broonie@kernel.org, f.fainelli@gmail.com, jic23@kernel.org,
        linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        Mark Brown <broonie@kernel.org>, orsonzhai@gmail.com,
        zhang.lyra@gmail.com
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926105147.7839-9-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: introduce `delay` field for `spi_transfer` + spi_transfer_delay_exec()

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.5

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

>From bebcfd272df648542c458d28fbd6a8f9428b5310 Mon Sep 17 00:00:00 2001
From: Alexandru Ardelean <alexandru.ardelean@analog.com>
Date: Thu, 26 Sep 2019 13:51:36 +0300
Subject: [PATCH] spi: introduce `delay` field for `spi_transfer` +
 spi_transfer_delay_exec()

The change introduces the `delay` field to the `spi_transfer` struct as an
`struct spi_delay` type.
This intends to eventually replace `delay_usecs`.

But, since there are many users of `delay_usecs`, this needs some
intermediate work.
A helper called `spi_transfer_delay_exec()` is also added, which maintains
backwards compatibility with `delay_usecs`, by assigning the value to
`delay` if non-zero.
This should maintain backwards compatibility with current users of
`udelay_usecs`.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Link: https://lore.kernel.org/r/20190926105147.7839-9-alexandru.ardelean@analog.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c       |  6 +++---
 include/linux/spi/spi.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 307e440dd92d..2e448078a117 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1248,8 +1248,7 @@ static int spi_transfer_one_message(struct spi_controller *ctlr,
 		if (msg->status != -EINPROGRESS)
 			goto out;
 
-		if (xfer->delay_usecs)
-			_spi_transfer_delay_ns(xfer->delay_usecs * 1000);
+		spi_transfer_delay_exec(xfer);
 
 		if (xfer->cs_change) {
 			if (list_is_last(&xfer->transfer_list,
@@ -3026,10 +3025,11 @@ struct spi_replaced_transfers *spi_replace_transfers(
 		/* add to list */
 		list_add(&xfer->transfer_list, rxfer->replaced_after);
 
-		/* clear cs_change and delay_usecs for all but the last */
+		/* clear cs_change and delay for all but the last */
 		if (i) {
 			xfer->cs_change = false;
 			xfer->delay_usecs = 0;
+			xfer->delay.value = 0;
 		}
 	}
 
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index ebeb272aeb0f..fe5b85df2c79 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -778,6 +778,9 @@ extern void spi_res_release(struct spi_controller *ctlr,
  * @cs_change: affects chipselect after this transfer completes
  * @cs_change_delay: delay between cs deassert and assert when
  *      @cs_change is set and @spi_transfer is not the last in @spi_message
+ * @delay: delay to be introduced after this transfer before
+ *	(optionally) changing the chipselect status, then starting
+ *	the next transfer or completing this @spi_message.
  * @delay_usecs: microseconds to delay after this transfer before
  *	(optionally) changing the chipselect status, then starting
  *	the next transfer or completing this @spi_message.
@@ -896,6 +899,7 @@ struct spi_transfer {
 #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
 	u8		bits_per_word;
 	u16		delay_usecs;
+	struct spi_delay	delay;
 	struct spi_delay	cs_change_delay;
 	struct spi_delay	word_delay;
 	u32		speed_hz;
@@ -1003,6 +1007,20 @@ spi_transfer_del(struct spi_transfer *t)
 	list_del(&t->transfer_list);
 }
 
+static inline int
+spi_transfer_delay_exec(struct spi_transfer *t)
+{
+	struct spi_delay d;
+
+	if (t->delay_usecs) {
+		d.value = t->delay_usecs;
+		d.unit = SPI_DELAY_UNIT_USECS;
+		return spi_delay_exec(&d, NULL);
+	}
+
+	return spi_delay_exec(&t->delay, t);
+}
+
 /**
  * spi_message_init_with_transfers - Initialize spi_message and append transfers
  * @m: spi_message to be initialized
-- 
2.20.1
