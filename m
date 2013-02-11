From: "Jens Renner (EFE)" <renner@efe-gmbh.de>
Subject: [PATCH] spi: spi-xilinx: Use DT information for bits_per_word value
Date: Mon, 11 Feb 2013 15:55:39 +0100
Message-ID: <5119066B.2050103@efe-gmbh.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jens Renner <renner@efe-gmbh.de>

This patch overrides the default value of bits_per_word with the actual value of "xlnx,num-transfer-bits" from the DTS file to allow for 16 and 32 bit word lengths.

Signed-off-by: Jens Renner <renner@efe-gmbh.de>
---
diff --git a/drivers/spi/spi-xilinx.c b/drivers/spi/spi-xilinx.c
index e1d7696..03abdfa 100644
--- a/drivers/spi/spi-xilinx.c
+++ b/drivers/spi/spi-xilinx.c
@@ -487,6 +487,12 @@ static int xilinx_spi_probe(struct platform_device *dev)
				       &len);
		if (prop && len >= sizeof(*prop))
			num_cs = __be32_to_cpup(prop);
+
+		/* override default number of bits per word */
+		prop = of_get_property(dev->dev.of_node,
+				       "xlnx,num-transfer-bits", &len);
+		if (prop && len >= sizeof(*prop))
+			bits_per_word = __be32_to_cpup(prop);
	}
 #endif
