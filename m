From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Avoid writing to registers from spi_master.setup()" to the spi tree
Date: Thu, 14 Dec 2017 11:50:19 +0000
Message-ID: <E1ePS1r-0005XK-Bd@debutante>
References: <1513191913-10612-2-git-send-email-geert+renesas@glider.be>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1513191913-10612-2-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Avoid writing to registers from spi_master.setup()

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

>From 7ff0b53c4051145d1cf992d2f60987e6447eed4f Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Wed, 13 Dec 2017 20:05:10 +0100
Subject: [PATCH] spi: sh-msiof: Avoid writing to registers from
 spi_master.setup()

The spi_master.setup() callback must not change configuration registers,
as that could corrupt I/O that is in progress for other SPI slaves.

The only exception is the configuration of the native chip select
polarity in SPI master mode, as a wrong chip select polarity will cause
havoc during all future transfers to any other SPI slave.

Hence stop writing to registers in sh_msiof_spi_setup(), unless it is
the first call for a controller using a native chip select, or unless
native chip select polarity has changed (note that you'll loose anyway
if I/O is in progress).  Even then, only do what is strictly necessary,
instead of calling sh_msiof_spi_set_pin_regs().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-sh-msiof.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 81a9144f5442..2704abb11ea4 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -55,6 +55,8 @@ struct sh_msiof_spi_priv {
 	void *rx_dma_page;
 	dma_addr_t tx_dma_addr;
 	dma_addr_t rx_dma_addr;
+	bool native_cs_inited;
+	bool native_cs_high;
 	bool slave_aborted;
 };
 
@@ -528,8 +530,7 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 {
 	struct device_node	*np = spi->master->dev.of_node;
 	struct sh_msiof_spi_priv *p = spi_master_get_devdata(spi->master);
-
-	pm_runtime_get_sync(&p->pdev->dev);
+	u32 clr, set, tmp;
 
 	if (!np) {
 		/*
@@ -539,19 +540,31 @@ static int sh_msiof_spi_setup(struct spi_device *spi)
 		spi->cs_gpio = (uintptr_t)spi->controller_data;
 	}
 
-	/* Configure pins before deasserting CS */
-	sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
-				  !!(spi->mode & SPI_CPHA),
-				  !!(spi->mode & SPI_3WIRE),
-				  !!(spi->mode & SPI_LSB_FIRST),
-				  !!(spi->mode & SPI_CS_HIGH));
-
-	if (spi->cs_gpio >= 0)
+	if (spi->cs_gpio >= 0) {
 		gpio_set_value(spi->cs_gpio, !(spi->mode & SPI_CS_HIGH));
+		return 0;
+	}
 
+	if (spi_controller_is_slave(p->master))
+		return 0;
 
-	pm_runtime_put(&p->pdev->dev);
+	if (p->native_cs_inited &&
+	    (p->native_cs_high == !!(spi->mode & SPI_CS_HIGH)))
+		return 0;
 
+	/* Configure native chip select mode/polarity early */
+	clr = MDR1_SYNCMD_MASK;
+	set = MDR1_TRMD | TMDR1_PCON | MDR1_SYNCMD_SPI;
+	if (spi->mode & SPI_CS_HIGH)
+		clr |= BIT(MDR1_SYNCAC_SHIFT);
+	else
+		set |= BIT(MDR1_SYNCAC_SHIFT);
+	pm_runtime_get_sync(&p->pdev->dev);
+	tmp = sh_msiof_read(p, TMDR1) & ~clr;
+	sh_msiof_write(p, TMDR1, tmp | set);
+	pm_runtime_put(&p->pdev->dev);
+	p->native_cs_high = spi->mode & SPI_CS_HIGH;
+	p->native_cs_inited = true;
 	return 0;
 }
 
-- 
2.15.1
