From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v3 2/3] spi: of: allow instantiating slaves without a driver
Date: Tue, 19 Jul 2016 00:35:41 +0200
Message-ID: <42e65e5c714f079cb4b85761e59fb700d4550a26.1468880530.git.hramrach@gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com>
Cc: Michal Suchanek <hramrach@gmail.com>
To: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1468880530.git.hramrach@gmail.com>
In-Reply-To: <cover.1468880530.git.hramrach@gmail.com>
References: <cover.1468880530.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

SPI slave devices are not created when looking up driver for the slave
fails. Create a device anyway so it can be used with spidev.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f3ea768..f0de2ec 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1489,9 +1489,8 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	rc = of_modalias_node(nc, spi->modalias,
 				sizeof(spi->modalias));
 	if (rc < 0) {
-		dev_err(&master->dev, "cannot find modalias for %s\n",
+		dev_warn(&master->dev, "cannot find modalias for %s\n",
 			nc->full_name);
-		goto err_out;
 	}
 
 	/* Device address */
-- 
2.8.1
