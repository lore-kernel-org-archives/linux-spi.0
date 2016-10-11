From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: dw: Set GPIO_SS flag to toggle Slave Select on GPIO CS" to the spi tree
Date: Tue, 11 Oct 2016 12:30:41 +0200
Message-ID: <E1btuKX-0008Qw-2W@finisterre>
References: <1476109525-21213-2-git-send-email-tthayer@opensource.altera.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
        jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, michael-XrNoQAPr3WXM9gW82pYGhQ@public.gmane.org, kernel-NoMTM8u0nx3R7s880joybQ@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1476109525-21213-2-git-send-email-tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: dw: Set GPIO_SS flag to toggle Slave Select on GPIO CS

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

>From 80b444e57948ea4bd5a89fb1f8c404ddab6c1973 Mon Sep 17 00:00:00 2001
From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Date: Mon, 10 Oct 2016 09:25:25 -0500
Subject: [PATCH] spi: dw: Set GPIO_SS flag to toggle Slave Select on GPIO CS

The Designware SPI master requires slave selection before the transfer
can begin [1].

This patch uses the new master flag to indicate both the GPIO CS and
the internal chip select should be used.

Tested On:
    Altera CycloneV development kit
    Compile tested for build errors on x86_64 (allyesconfigs)

[1] DesignWare dw_apb_ssi Databook, Version 3.20a (page 39)

Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-dw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 27960e46135d..b715a26a9148 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -502,6 +502,7 @@ int dw_spi_add_host(struct device *dev, struct dw_spi *dws)
 	master->handle_err = dw_spi_handle_err;
 	master->max_speed_hz = dws->max_freq;
 	master->dev.of_node = dev->of_node;
+	master->flags = SPI_MASTER_GPIO_SS;
 
 	/* Basic HW init */
 	spi_hw_init(dev, dws);
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
