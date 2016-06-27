From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v2 1/3] spi: spidev: fix the check for spidev in dt
Date: Mon, 27 Jun 2016 21:02:30 +0200
Message-ID: <0123f28025f0a29a0771a43397ad14259a2094b7.1467053363.git.hramrach@gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1467053363.git.hramrach@gmail.com>
In-Reply-To: <cover.1467053363.git.hramrach@gmail.com>
References: <cover.1467053363.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The error message is "buggy DT: spidev listed directly in DT\n"

That's not what the check does. It checks that one if the IDs listed in
the driver match table matches what is set on the DT node.

This does not work if you manage to convince the kernel to bind spidev
on a node that has some other random compatible which is not "spidev".

Also the spidev id match table is not compiled when !CONFIG_OF

So add a match table that has just "spidev" entry in it so it can
reliably detect what this message is supposed to warn about.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 - fix indent
 - update commit mesage
---
 drivers/spi/spidev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f3..3c6ebe7 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -700,6 +700,11 @@ static const struct of_device_id spidev_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
 #endif
 
+static const struct of_device_id spidev_check[] = {
+	{ .compatible = "spidev" },
+	{}
+};
+
 /*-------------------------------------------------------------------------*/
 
 static int spidev_probe(struct spi_device *spi)
@@ -713,10 +718,10 @@ static int spidev_probe(struct spi_device *spi)
 	 * compatible string, it is a Linux implementation thing
 	 * rather than a description of the hardware.
 	 */
-	if (spi->dev.of_node && !of_match_device(spidev_dt_ids, &spi->dev)) {
+	if (spi->dev.of_node && of_match_device(spidev_check, &spi->dev)) {
 		dev_err(&spi->dev, "buggy DT: spidev listed directly in DT\n");
 		WARN_ON(spi->dev.of_node &&
-			!of_match_device(spidev_dt_ids, &spi->dev));
+			of_match_device(spidev_check, &spi->dev));
 	}
 
 	/* Allocate driver data */
-- 
2.8.1
