From: Michal Suchanek <hramrach@gmail.com>
Subject: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Fri, 24 Jun 2016 16:20:33 +0200
Message-ID: <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
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

SPI slave devices are not created when looking up driver for the slave
fails. Create a device anyway so it can be manually bound to a driver.

Signed-off-by: Michal Suchanek <hramrach@gmail.com>
---
 drivers/spi/spi.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 0239b45..73b1125 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1477,9 +1477,8 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	rc = of_modalias_node(nc, spi->modalias,
 				sizeof(spi->modalias));
 	if (rc < 0) {
-		dev_err(&master->dev, "cannot find modalias for %s\n",
+		dev_warn(&master->dev, "cannot find modalias for %s\n",
 			nc->full_name);
-		goto err_out;
 	}
 
 	/* Device address */
@@ -1543,11 +1542,10 @@ of_register_spi_device(struct spi_master *master, struct device_node *nc)
 	/* Device speed */
 	rc = of_property_read_u32(nc, "spi-max-frequency", &value);
 	if (rc) {
-		dev_err(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
+		dev_warn(&master->dev, "%s has no valid 'spi-max-frequency' property (%d)\n",
 			nc->full_name, rc);
-		goto err_out;
-	}
-	spi->max_speed_hz = value;
+	} else
+		spi->max_speed_hz = value;
 
 	/* Store a pointer to the node in the device structure */
 	of_node_get(nc);
-- 
2.8.1
