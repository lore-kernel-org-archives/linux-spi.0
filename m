From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: acpi: remove superfluous parameter check" to the spi tree
Date: Thu, 12 Mar 2020 17:38:51 +0000
Message-ID: <applied-20200312134507.10000-1-wsa@the-dreams.de>
References: <20200312134507.10000-1-wsa@the-dreams.de>
Cc: linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200312134507.10000-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: acpi: remove superfluous parameter check

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

>From 5b16668e638c61a9cd4dffaa41d8b3b6f53f6b3a Mon Sep 17 00:00:00 2001
From: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Date: Thu, 12 Mar 2020 14:45:07 +0100
Subject: [PATCH] spi: acpi: remove superfluous parameter check
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

to_spi_device() already checks 'dev'. No need to do it before calling
it.

Signed-off-by: Wolfram Sang <wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Link: https://lore.kernel.org/r/20200312134507.10000-1-wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f6f6b2a0c81c..0996d238f61e 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -4028,7 +4028,7 @@ static struct spi_device *acpi_spi_find_device_by_adev(struct acpi_device *adev)
 	struct device *dev;
 
 	dev = bus_find_device_by_acpi_dev(&spi_bus_type, adev);
-	return dev ? to_spi_device(dev) : NULL;
+	return to_spi_device(dev);
 }
 
 static int acpi_spi_notify(struct notifier_block *nb, unsigned long value,
-- 
2.20.1
