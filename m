From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH v3 3/3] spi: core: allow creating devices without spi-max-frequency
Date: Tue, 19 Jul 2016 00:35:42 +0200
Message-ID: <8955fbeac9d1ec999555b3a5e58041509bf4a74c.1468880530.git.hramrach@gmail.com>
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

Since the previous patch allows creating SPI slaves without specifying
what device the CS connects to make spi-max-frequency also optional.

The spi-max-frequency is device-specific and the driver can set it
anyway.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index f0de2ec..08e65e4 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1554,11 +1554,11 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	/* Device speed */
 	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
+		dev_warn(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
 			nc->full_name, rc);
-		goto err_out;
+	} else {
+		spi->max_speed_hz = value;
 	}
-	spi->max_speed_hz = value;
 
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
-- 
2.8.1
