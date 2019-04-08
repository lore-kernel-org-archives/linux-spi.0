From: Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Mon, 8 Apr 2019 17:22:44 +0200
Message-ID: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Flavio Suligoi <f.suligoi@asem.it>
To: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add an info message for the PXA2xx device driver start-up,
with the indication of the transfer mode used (DMA or GPIO).

This info is useful to individuate the timing when
the module starts.

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/spi/spi-pxa2xx.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index f7068cc..d449501 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1826,6 +1826,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
 		goto out_error_clock_enabled;
 	}
 
+	dev_info(dev, "PXA2xx SPI master controller (%s mode)\n",
+		 platform_info->enable_dma ? "DMA" : "PIO");
+
 	return status;
 
 out_error_clock_enabled:
-- 
2.7.4
