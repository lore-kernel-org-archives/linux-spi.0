From: H Hartley Sweeten <hartleys@visionengravers.com>
Subject: [PATCH v2 06/11] spi: spi-ep93xx: remove dev_err() for kzalloc() failure
Date: Tue, 2 Jul 2013 10:08:59 -0700
Message-ID: <201307021009.00176.hartleys@visionengravers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <spi-devel-general@lists.sourceforge.net>,
	Ryan Mallon <rmallon@gmail.com>, <mika.westerberg@iki.fi>,
	<broonie@kernel.org>, <grant.likely@linaro.org>,
	<hsweeten@visionengravers.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The kzalloc() failure will have already output a message.

Signed-off-by: H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: Ryan Mallon <rmallon@gmail.com>
Cc: Mika Westerberg <mika.westerberg@iki.fi>
Cc: Mark Brown <broonie@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
---
 drivers/spi/spi-ep93xx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
index c1a610e..34aade1 100644
--- a/drivers/spi/spi-ep93xx.c
+++ b/drivers/spi/spi-ep93xx.c
@@ -1004,10 +1004,8 @@ static int ep93xx_spi_probe(struct platform_device *pdev)
 	}
 
 	master = spi_alloc_master(&pdev->dev, sizeof(*espi));
-	if (!master) {
-		dev_err(&pdev->dev, "failed to allocate spi master\n");
+	if (!master)
 		return -ENOMEM;
-	}
 
 	master->setup = ep93xx_spi_setup;
 	master->transfer = ep93xx_spi_transfer;
-- 
1.8.1.4
