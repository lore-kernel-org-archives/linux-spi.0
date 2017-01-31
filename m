From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: fix device-node leaks" to the spi tree
Date: Tue, 31 Jan 2017 21:20:27 +0000
Message-ID: <E1cYfql-00024F-Aj@debutante>
References: <20170130164705.21727-1-johan@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org
To: Johan Hovold <johan@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170130164705.21727-1-johan@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: fix device-node leaks

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

>From 8324147f38019865b29d03baf28412d2ec0bd828 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 30 Jan 2017 17:47:05 +0100
Subject: [PATCH] spi: fix device-node leaks

Make sure to release the device-node reference taken in
of_register_spi_device() on errors and when deregistering the device.

Fixes: 284b01897340 ("spi: Add OF binding support for SPI busses")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8c05f27bf642..59cb26470d70 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -621,8 +621,10 @@ void spi_unregister_device(struct spi_device *spi)
 	if (!spi)
 		return;
 
-	if (spi->dev.of_node)
+	if (spi->dev.of_node) {
 		of_node_clear_flag(spi->dev.of_node, OF_POPULATED);
+		of_node_put(spi->dev.of_node);
+	}
 	if (ACPI_COMPANION(&spi->dev))
 		acpi_device_clear_enumerated(ACPI_COMPANION(&spi->dev));
 	device_unregister(&spi->dev);
@@ -1603,11 +1605,13 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	if (rc) {
 		dev_err(&master->dev, "spi_device register error %s\n",
 			nc->full_name);
-		goto err_out;
+		goto err_of_node_put;
 	}
 
 	return spi;
 
+err_of_node_put:
+	of_node_put(nc);
 err_out:
 	spi_dev_put(spi);
 	return ERR_PTR(rc);
-- 
2.11.0
