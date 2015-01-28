From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Subject: [PATCH] spi/xilinx: Check number of slaves range
Date: Wed, 28 Jan 2015 20:53:39 +0100
Message-ID: <1422474819-22689-1-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ricardo Ribalda <ricardo.ribalda@gmail.com>
To: Mark Brown <broonie@kernel.org>, Michal Simek <michal.simek@xilinx.com>,
 =?UTF-8?q?S=C3=B6ren=20Brinkmann?= <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

From: Ricardo Ribalda <ricardo.ribalda@gmail.com>

The core only supports up to 32 slaves, and the chipselect function
expects the same.

Signed-off-by: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
---

v2: Change suggested by Mark Brown
-Namespace the constant

 drivers/spi/spi-xilinx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index 416b227..354dbb4 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -22,6 +22,8 @@
 #include <linux/spi/xilinx_spi.h>
 #include <linux/io.h>
 
+#define XILINX_SPI_MAX_CS	32
+
 #define XILINX_SPI_NAME "xilinx_spi"
 
 /* Register definitions as per "OPB Serial Peripheral Interface (SPI) (v1.00e)
@@ -354,6 +356,11 @@ static int xilinx_spi_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
+	if (num_cs > XILINX_SPI_MAX_CS) {
+		dev_err(&pdev->dev, "Invalid number of spi slaves\n");
+		return -EINVAL;
+	}
+
 	master = spi_alloc_master(&pdev->dev, sizeof(struct xilinx_spi));
 	if (!master)
 		return -ENODEV;
-- 
2.1.4
