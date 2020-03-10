From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: update the structure documentation" to the spi tree
Date: Tue, 10 Mar 2020 14:31:07 +0000
Message-ID: <applied-1583774179-30736-1-git-send-email-hqjagain@gmail.com>
References: <1583774179-30736-1-git-send-email-hqjagain@gmail.com>
Cc: broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Qiujun Huang <hqjagain@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1583774179-30736-1-git-send-email-hqjagain@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: update the structure documentation

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

>From 7a86a419ff62c69f91544ea95f4ae6ef83880dcc Mon Sep 17 00:00:00 2001
From: Qiujun Huang <hqjagain@gmail.com>
Date: Tue, 10 Mar 2020 01:16:19 +0800
Subject: [PATCH] spi: update the structure documentation

some members were not described in documentation.

Signed-off-by: Qiujun Huang <hqjagain@gmail.com>
Link: https://lore.kernel.org/r/1583774179-30736-1-git-send-email-hqjagain@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/linux/spi/spi.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 87105272879b..38286de779e3 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -135,6 +135,8 @@ extern int spi_delay_exec(struct spi_delay *_delay, struct spi_transfer *xfer);
  * @modalias: Name of the driver to use with this device, or an alias
  *	for that name.  This appears in the sysfs "modalias" attribute
  *	for driver coldplugging, and in uevents used for hotplugging
+ * @driver_override: If the name of a driver is written to this attribute, then
+ *	the device will bind to the named driver and only the named driver.
  * @cs_gpio: LEGACY: gpio number of the chipselect line (optional, -ENOENT when
  *	not using a GPIO line) use cs_gpiod in new drivers by opting in on
  *	the spi_master.
@@ -443,6 +445,7 @@ static inline void spi_unregister_driver(struct spi_driver *sdrv)
  *	@spi_transfer->ptp_sts_word_post were transmitted.
  *	If the driver does not set this, the SPI core takes the snapshot as
  *	close to the driver hand-over as possible.
+ * @irq_flags: Interrupt enable state during PTP system timestamping
  *
  * Each SPI controller can communicate with one or more @spi_device
  * children.  These make a small bus, sharing MOSI, MISO and SCK signals
-- 
2.20.1
