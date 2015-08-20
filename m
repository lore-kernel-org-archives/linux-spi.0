From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sunxi: fix transfer timeout" to the spi tree
Date: Thu, 20 Aug 2015 14:06:51 -0700
Message-ID: <E1ZSX2x-0001y5-Q5@finisterre>
Cc: linux-spi@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>,
	Mark Brown <broonie@kernel.org>, stable@vger.kernel.org
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: 
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sunxi: fix transfer timeout

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 63d53d153b62a1d0fb6e95a8936e43ba09ff7beb Mon Sep 17 00:00:00 2001
From: Michal Suchanek <hramrach@gmail.com>
Date: Thu, 20 Aug 2015 14:19:45 +0000
Subject: [PATCH] spi: sunxi: fix transfer timeout

The trasfer timeout is fixed at 1000 ms. Reading a 4Mbyte flash over
1MHz SPI bus takes way longer than that. Calculate the timeout from the
actual time the transfer is supposed to take and multiply by 2 for good
measure.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-sun4i.c | 10 +++++++++-
 drivers/spi/spi-sun6i.c | 10 +++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-sun4i.c b/drivers/spi/spi-sun4i.c
index fbb0a4d..48532ec 100644
--- a/drivers/spi/spi-sun4i.c
+++ b/drivers/spi/spi-sun4i.c
@@ -170,6 +170,7 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 {
 	struct sun4i_spi *sspi = spi_master_get_devdata(master);
 	unsigned int mclk_rate, div, timeout;
+	unsigned int start, end, tx_time;
 	unsigned int tx_len = 0;
 	int ret = 0;
 	u32 reg;
@@ -279,9 +280,16 @@ static int sun4i_spi_transfer_one(struct spi_master *master,
 	reg = sun4i_spi_read(sspi, SUN4I_CTL_REG);
 	sun4i_spi_write(sspi, SUN4I_CTL_REG, reg | SUN4I_CTL_XCH);
 
+	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, speed,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
index ac48f59..3d0f66c 100644
--- a/drivers/spi/spi-sun6i.c
+++ b/drivers/spi/spi-sun6i.c
@@ -162,6 +162,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	unsigned int mclk_rate, div, timeout;
 	unsigned int tx_len = 0;
 	int ret = 0;
+	unsigned int start, end, tx_time;
 	u32 reg;
 
 	/* We don't support transfer larger than the FIFO */
@@ -269,9 +270,16 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
 	reg = sun6i_spi_read(sspi, SUN6I_TFR_CTL_REG);
 	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg | SUN6I_TFR_CTL_XCH);
 
+	tx_time = max_t(int, tfr->len * 8 * 2 / (speed / 1000), 100);
+	start = jiffies;
 	timeout = wait_for_completion_timeout(&sspi->done,
-					      msecs_to_jiffies(1000));
+					      msecs_to_jiffies(tx_time));
+	end = jiffies;
 	if (!timeout) {
+		dev_warn(&master->dev,
+			 "%s: timeout transferring %u bytes@%iHz for %i(%i)ms",
+			 dev_name(&spi->dev), tfr->len, speed,
+			 jiffies_to_msecs(end - start), tx_time);
 		ret = -ETIMEDOUT;
 		goto out;
 	}
-- 
2.5.0
