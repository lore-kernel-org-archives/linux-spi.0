From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: gpio: Look for a device node instead of match" to the spi tree
Date: Mon,  7 Oct 2019 14:03:29 +0100 (BST)
Message-ID: <20191007130329.47D48274162F@ypsilon.sirena.org.uk>
References: <20191004214334.149976-9-swboyd@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, <linux-spi@vger.kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
To: Stephen Boyd <swboyd@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191004214334.149976-9-swboyd@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: gpio: Look for a device node instead of match

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

>From 62217f8b084a05dd2d84781a8ca065098df21ec7 Mon Sep 17 00:00:00 2001
From: Stephen Boyd <swboyd@chromium.org>
Date: Fri, 4 Oct 2019 14:43:32 -0700
Subject: [PATCH] spi: gpio: Look for a device node instead of match

This driver doesn't do anything with the match for the device node. The
logic is the same as looking to see if a device node exists or not
because this driver wouldn't probe unless there is a device node match
when the device is created from DT. Just test for the presence of the
device node to simplify and avoid referencing a potentially undefined
match table when CONFIG_OF=n.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: <linux-spi@vger.kernel.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/20191004214334.149976-9-swboyd@chromium.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-gpio.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index 1d3e23ec20a6..42f4d82e9c5a 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -362,9 +362,6 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	struct spi_gpio			*spi_gpio;
 	struct device			*dev = &pdev->dev;
 	struct spi_bitbang		*bb;
-	const struct of_device_id	*of_id;
-
-	of_id = of_match_device(spi_gpio_dt_ids, &pdev->dev);
 
 	master = spi_alloc_master(dev, sizeof(*spi_gpio));
 	if (!master)
@@ -374,7 +371,7 @@ static int spi_gpio_probe(struct platform_device *pdev)
 	if (status)
 		return status;
 
-	if (of_id)
+	if (pdev->dev.of_node)
 		status = spi_gpio_probe_dt(pdev, master);
 	else
 		status = spi_gpio_probe_pdata(pdev, master);
-- 
2.20.1
