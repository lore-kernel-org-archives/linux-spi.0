From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi/rockchip: Make sure spi clk is on in rockchip_spi_set_cs" to the spi tree
Date: Sat, 05 Mar 2016 21:26:05 +0900
Message-ID: <E1acBHZ-0003XE-1H@finisterre>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: 
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi/rockchip: Make sure spi clk is on in rockchip_spi_set_cs

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

>From b920cc3191d7612f26f36ee494e05b5ffd9044c0 Mon Sep 17 00:00:00 2001
From: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Date: Wed, 24 Feb 2016 18:00:04 +0800
Subject: [PATCH] spi/rockchip: Make sure spi clk is on in rockchip_spi_set_cs

Rockchip_spi_set_cs could be called by spi_setup, but
spi_setup may be called by device driver after runtime suspend.
Then the spi clock is closed, rockchip_spi_set_cs may access the
spi registers, which causes cpu block in some socs.

Fixes: 64e36824b32 ("spi/rockchip: add driver for Rockchip RK3xxx")
Signed-off-by: Huibin Hong <huibin.hong-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-rockchip.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
index 07c082aa5cff..6cdb4d81d66c 100644
--- a/drivers/spi/spi-rockchip.c
+++ b/drivers/spi/spi-rockchip.c
@@ -263,7 +263,10 @@ static inline u32 rx_max(struct rockchip_spi *rs)
 static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 {
 	u32 ser;
-	struct rockchip_spi *rs = spi_master_get_devdata(spi->master);
+	struct spi_master *master = spi->master;
+	struct rockchip_spi *rs = spi_master_get_devdata(master);
+
+	pm_runtime_get_sync(rs->dev);
 
 	ser = readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) & SER_MASK;
 
@@ -288,6 +291,8 @@ static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
 		ser &= ~(1 << spi->chip_select);
 
 	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
+
+	pm_runtime_put_sync(rs->dev);
 }
 
 static int rockchip_spi_prepare_message(struct spi_master *master,
-- 
2.7.0

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
