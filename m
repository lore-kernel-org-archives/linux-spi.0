From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] spi: rspi: Use platform_get_irq_byname_optional() for optional irqs
Date: Wed, 16 Oct 2019 16:31:01 +0200
Message-ID: <20191016143101.28738-1-geert+renesas@glider.be>
Cc: Stephen Boyd <swboyd@chromium.org>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

As platform_get_irq_byname() now prints an error when the interrupt
does not exist, scary warnings may be printed for optional interrupts:

    renesas_spi e6b10000.spi: IRQ rx not found
    renesas_spi e6b10000.spi: IRQ mux not found

Fix this by calling platform_get_irq_byname_optional() instead.
Remove the no longer needed printing of platform_get_irq errors, as the
remaining calls to platform_get_irq() and platform_get_irq_byname() take
care of that.

Fixes: 7723f4c5ecdb8d83 ("driver core: platform: Add an error message to platform_get_irq*()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This is a fix for v5.4.
---
 drivers/spi/spi-rspi.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index 15f5723d9f9524d9..7222c7689c3c4cea 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1257,9 +1257,9 @@ static int rspi_probe(struct platform_device *pdev)
 	ctlr->flags = ops->flags;
 	ctlr->dev.of_node = pdev->dev.of_node;
 
-	ret = platform_get_irq_byname(pdev, "rx");
+	ret = platform_get_irq_byname_optional(pdev, "rx");
 	if (ret < 0) {
-		ret = platform_get_irq_byname(pdev, "mux");
+		ret = platform_get_irq_byname_optional(pdev, "mux");
 		if (ret < 0)
 			ret = platform_get_irq(pdev, 0);
 		if (ret >= 0)
@@ -1270,10 +1270,6 @@ static int rspi_probe(struct platform_device *pdev)
 		if (ret >= 0)
 			rspi->tx_irq = ret;
 	}
-	if (ret < 0) {
-		dev_err(&pdev->dev, "platform_get_irq error\n");
-		goto error2;
-	}
 
 	if (rspi->rx_irq == rspi->tx_irq) {
 		/* Single multiplexed interrupt */
-- 
2.17.1
