From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: Fix unregistration of controller with fixed SPI bus number" to the spi tree
Date: Tue, 20 Mar 2018 09:02:26 +0000 (GMT)
Message-ID: <20180320090226.E553444007A@finisterre.ee.mobilebroadband>
References: <20180306154722.8813-1-jarkko.nikula@linux.intel.com>
Cc: stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Suniel Mahesh <sunil.m@techveda.org>, stable@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180306154722.8813-1-jarkko.nikula@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: Fix unregistration of controller with fixed SPI bus number

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

>From 613bd1ea387bb48b7c9a71a0bb451ac15cfbbc01 Mon Sep 17 00:00:00 2001
From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Date: Tue, 20 Mar 2018 10:27:50 +0200
Subject: [PATCH] spi: Fix unregistration of controller with fixed SPI bus
 number

Commit 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
ceased to unregister SPI buses with fixed bus numbers. Moreover this is
visible only if CONFIG_SPI_DEBUG=y is set or when trying to re-register
the same SPI controller.

rmmod spi_pxa2xx_platform (with CONFIG_SPI_DEBUG=y):
[   26.788362] spi_master spi1: attempting to delete unregistered controller [spi1]

modprobe spi_pxa2xx_platform:
[   37.883137] sysfs: cannot create duplicate filename '/devices/pci0000:00/0000:00:19.0/pxa2xx-spi.12/spi_master/spi1'
[   37.894984] CPU: 1 PID: 1467 Comm: modprobe Not tainted 4.16.0-rc4+ #21
[   37.902384] Call Trace:
...
[   38.122680] kobject_add_internal failed for spi1 with -EEXIST, don't try to register things with the same name in the same directory.
[   38.136154] WARNING: CPU: 1 PID: 1467 at lib/kobject.c:238 kobject_add_internal+0x2a5/0x2f0
...
[   38.513817] pxa2xx-spi pxa2xx-spi.12: problem registering spi master
[   38.521036] pxa2xx-spi: probe of pxa2xx-spi.12 failed with error -17

Fix this by not returning immediately from spi_unregister_controller() if
idr_find() doesn't find controller with given ID/bus number. It finds
only those controllers that were registered with dynamic SPI bus
numbers. Only conditional cleanup between dynamic and fixed bus numbers
is to remove allocated IDR.

Fixes: 9b61e302210e (spi: Pick spi bus number from Linux idr or spi alias)
Cc: stable@vger.kernel.org
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index b33a727a0158..e90fd442b3f0 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -2254,12 +2254,6 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	mutex_lock(&board_lock);
 	found = idr_find(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
-	if (found != ctlr) {
-		dev_dbg(&ctlr->dev,
-			"attempting to delete unregistered controller [%s]\n",
-			dev_name(&ctlr->dev));
-		return;
-	}
 	if (ctlr->queued) {
 		if (spi_destroy_queue(ctlr))
 			dev_err(&ctlr->dev, "queue remove failed\n");
@@ -2272,7 +2266,8 @@ void spi_unregister_controller(struct spi_controller *ctlr)
 	device_unregister(&ctlr->dev);
 	/* free bus id */
 	mutex_lock(&board_lock);
-	idr_remove(&spi_master_idr, id);
+	if (found == ctlr)
+		idr_remove(&spi_master_idr, id);
 	mutex_unlock(&board_lock);
 }
 EXPORT_SYMBOL_GPL(spi_unregister_controller);
-- 
2.16.2
