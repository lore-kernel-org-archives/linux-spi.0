From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 1/3] spi: sh-hspi: Add missing call to pm_runtime_disable() in failure path
Date: Tue, 11 Mar 2014 10:59:10 +0100
Message-ID: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
Cc: linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/spi/spi-sh-hspi.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-hspi.c b/drivers/spi/spi-sh-hspi.c
index 3b170b9f3471..9009456bdf4d 100644
--- a/drivers/spi/spi-sh-hspi.c
+++ b/drivers/spi/spi-sh-hspi.c
@@ -278,11 +278,13 @@ static int hspi_probe(struct platform_device *pdev)
 	ret = devm_spi_register_master(&pdev->dev, master);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "spi_register_master error.\n");
-		goto error1;
+		goto error2;
 	}
 
 	return 0;
 
+ error2:
+	pm_runtime_disable(&pdev->dev);
  error1:
 	clk_put(clk);
  error0:
-- 
1.7.9.5

