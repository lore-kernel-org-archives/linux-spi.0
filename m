From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 06/18] spi: rspi: Don't consider DMA configuration failures fatal
Date: Mon,  2 Jun 2014 15:38:08 +0200
Message-ID: <1401716301-29612-7-git-send-email-geert+renesas@glider.be>
References: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1401716301-29612-1-git-send-email-geert+renesas@glider.be>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fall back to PIO if DMA configuration failed.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-rspi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index fdbd46d0c570..94a99ec7d989 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1190,10 +1190,8 @@ static int rspi_probe(struct platform_device *pdev)
 	}
 
 	ret = rspi_request_dma(rspi, pdev);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "rspi_request_dma failed.\n");
-		goto error3;
-	}
+	if (ret < 0)
+		dev_warn(&pdev->dev, "DMA not available, using PIO\n");
 
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
-- 
1.9.1

