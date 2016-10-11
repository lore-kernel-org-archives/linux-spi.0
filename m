From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: Add Flag to Enable Slave Select with GPIO Chip Select." to the spi tree
Date: Tue, 11 Oct 2016 12:30:37 +0200
Message-ID: <E1btuKT-0008Pr-IT@finisterre>
References: <1476109525-21213-1-git-send-email-tthayer@opensource.altera.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476109525-21213-1-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: Add Flag to Enable Slave Select with GPIO Chip Select.

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

>From 6b1576aa875347c6454d911a2e001138c2cec7d5 Mon Sep 17 00:00:00 2001
From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Date: Mon, 10 Oct 2016 09:25:24 -0500
Subject: [PATCH] spi: Add Flag to Enable Slave Select with GPIO Chip Select.

Some SPI masters require slave selection before the transfer
can begin [1]. The SPI framework currently selects the chip using
either 1) the internal CS mechanism or 2) the GPIO CS, but not both.

This patch adds a new master->flags define to indicate both the GPIO
CS and the internal chip select mechanism should be used.

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c       | 9 +++++++--
 include/linux/spi/spi.h | 1 +
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8146ccd35a1a..8708da7c8140 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -697,10 +697,15 @@ static void spi_set_cs(struct spi_device *spi, bool enable)
 	if (spi->mode & SPI_CS_HIGH)
 		enable = !enable;
 
-	if (gpio_is_valid(spi->cs_gpio))
+	if (gpio_is_valid(spi->cs_gpio)) {
 		gpio_set_value(spi->cs_gpio, !enable);
-	else if (spi->master->set_cs)
+		/* Some SPI masters need both GPIO CS & slave_select */
+		if ((spi->master->flags & SPI_MASTER_GPIO_SS) &&
+		    spi->master->set_cs)
+			spi->master->set_cs(spi, !enable);
+	} else if (spi->master->set_cs) {
 		spi->master->set_cs(spi, !enable);
+	}
 }
 
 #ifdef CONFIG_HAS_DMA
diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
index 4b743ac35396..75c6bd0ac605 100644
--- a/include/linux/spi/spi.h
+++ b/include/linux/spi/spi.h
@@ -442,6 +442,7 @@ struct spi_master {
 #define SPI_MASTER_NO_TX	BIT(2)		/* can't do buffer write */
 #define SPI_MASTER_MUST_RX      BIT(3)		/* requires rx */
 #define SPI_MASTER_MUST_TX      BIT(4)		/* requires tx */
+#define SPI_MASTER_GPIO_SS      BIT(5)		/* GPIO CS must select slave */
 
 	/*
 	 * on some hardware transfer / message size may be constrained
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
