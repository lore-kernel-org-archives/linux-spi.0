From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi/ath79: Fix checkpatch warnings" to the spi tree
Date: Mon, 10 Jul 2017 19:42:36 +0100
Message-ID: <E1dUddk-0000Lt-Ih@debutante>
References: <1498579857-10236-1-git-send-email-aravind.thk@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Aravind Thokala <aravind.thk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1498579857-10236-1-git-send-email-aravind.thk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi/ath79: Fix checkpatch warnings

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

>From 5426ff7f89629f8c1368519d3a7835cc648e70fc Mon Sep 17 00:00:00 2001
From: Aravind Thokala <aravind.thk@gmail.com>
Date: Tue, 27 Jun 2017 22:01:11 +0530
Subject: [PATCH] spi/ath79: Fix checkpatch warnings

This patch fixes the checkpatch.pl warnings on the driver
file.

Signed-off-by: Aravind Thokala <aravind.thk@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-ath79.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-ath79.c b/drivers/spi/spi-ath79.c
index b89cee11f418..0719bd484891 100644
--- a/drivers/spi/spi-ath79.c
+++ b/drivers/spi/spi-ath79.c
@@ -39,15 +39,15 @@ struct ath79_spi {
 	u32			reg_ctrl;
 	void __iomem		*base;
 	struct clk		*clk;
-	unsigned		rrw_delay;
+	unsigned int		rrw_delay;
 };
 
-static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned reg)
+static inline u32 ath79_spi_rr(struct ath79_spi *sp, unsigned int reg)
 {
 	return ioread32(sp->base + reg);
 }
 
-static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned reg, u32 val)
+static inline void ath79_spi_wr(struct ath79_spi *sp, unsigned int reg, u32 val)
 {
 	iowrite32(val, sp->base + reg);
 }
@@ -57,7 +57,7 @@ static inline struct ath79_spi *ath79_spidev_to_sp(struct spi_device *spi)
 	return spi_master_get_devdata(spi->master);
 }
 
-static inline void ath79_spi_delay(struct ath79_spi *sp, unsigned nsecs)
+static inline void ath79_spi_delay(struct ath79_spi *sp, unsigned int nsecs)
 {
 	if (nsecs > sp->rrw_delay)
 		ndelay(nsecs - sp->rrw_delay);
@@ -148,9 +148,8 @@ static int ath79_spi_setup_cs(struct spi_device *spi)
 
 static void ath79_spi_cleanup_cs(struct spi_device *spi)
 {
-	if (gpio_is_valid(spi->cs_gpio)) {
+	if (gpio_is_valid(spi->cs_gpio))
 		gpio_free(spi->cs_gpio);
-	}
 }
 
 static int ath79_spi_setup(struct spi_device *spi)
@@ -176,7 +175,7 @@ static void ath79_spi_cleanup(struct spi_device *spi)
 	spi_bitbang_cleanup(spi);
 }
 
-static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned nsecs,
+static u32 ath79_spi_txrx_mode0(struct spi_device *spi, unsigned int nsecs,
 			       u32 word, u8 bits)
 {
 	struct ath79_spi *sp = ath79_spidev_to_sp(spi);
-- 
2.13.2
