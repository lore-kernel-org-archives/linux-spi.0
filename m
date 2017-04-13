From: <jiada_wang@mentor.com>
Subject: [PATCH RFC 2/5] spi: spidev: use different name for SPI controller
 slave mode device
Date: Thu, 13 Apr 2017 05:14:01 -0700
Message-ID: <1492085644-4195-3-git-send-email-jiada_wang@mentor.com>
References: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jiada Wang <jiada_wang@mentor.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
 <shawnguo@kernel.org>, <kernel@pengutronix.de>, <fabio.estevam@nxp.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1492085644-4195-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

SPI bus controller has started to support to work in slave mode,
for device SPI controller itself works in slave mode, use name
'spidev[bus]-slv' as its name to differentiate from other
SPI devices

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 drivers/spi/spidev.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spidev.c b/drivers/spi/spidev.c
index 9e2e099..e2996fb 100644
--- a/drivers/spi/spidev.c
+++ b/drivers/spi/spidev.c
@@ -781,9 +781,18 @@ static int spidev_probe(struct spi_device *spi)
 		struct device *dev;
 
 		spidev->devt = MKDEV(SPIDEV_MAJOR, minor);
-		dev = device_create(spidev_class, &spi->dev, spidev->devt,
-				    spidev, "spidev%d.%d",
-				    spi->master->bus_num, spi->chip_select);
+		if (spi->slave_mode)
+			dev = device_create(spidev_class, &spi->dev,
+					    spidev->devt, spidev,
+					    "spidev%d-slv",
+					    spi->master->bus_num);
+		else
+			dev = device_create(spidev_class, &spi->dev,
+					    spidev->devt, spidev,
+					    "spidev%d.%d",
+					    spi->master->bus_num,
+					    spi->chip_select);
+
 		status = PTR_ERR_OR_ZERO(dev);
 	} else {
 		dev_dbg(&spi->dev, "no minor number available!\n");
-- 
2.7.4
