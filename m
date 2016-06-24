From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH 1/3] spi: spidev: fix the check for spidev in dt
Date: Fri, 24 Jun 2016 16:20:32 +0200
Message-ID: <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mark Brown <broonie@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1466696079.git.hramrach@gmail.com>
In-Reply-To: <cover.1466696079.git.hramrach@gmail.com>
References: <cover.1466696079.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The check is supposed to warn about spidev specified directly in
devicetree as compatible. This just does not work. I have a devicetree
with no compatible whatsoever and hacked my kernel so I can manually
bind spidev. This still triggers.

Also I have no idea how this could have build with ! CONFIG_OF since the
id table which the code checks is not compiled then.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spidev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index e3c19f3..8045baf 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -700,6 +700,11 @@ static const struct of_device_id spidev_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, spidev_dt_ids);
 #endif
 
+static const struct of_device_id spidev_check[] = {
+			{ .compatible = "spidev" },
+			{}
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
