From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 4/4] spi: spi-coldfire-qspi: enable RuntimePM before registering to the core
Date: Fri,  9 Oct 2015 07:54:53 +0100
Message-ID: <1444373693-2372-4-git-send-email-wsa@the-dreams.de>
References: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: linux-sh@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444373693-2372-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---

Not tested on HW. Found by code review.

 drivers/spi/spi-coldfire-qspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 688956ff5095c2..2c5fe795bb5e59 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -420,13 +420,13 @@ static int mcfqspi_probe(struct platform_device *pdev)
 	master->auto_runtime_pm = true;
 
 	platform_set_drvdata(pdev, master);
+	pm_runtime_enable(&pdev->dev);
 
 	status = devm_spi_register_master(&pdev->dev, master);
 	if (status) {
 		dev_dbg(&pdev->dev, "spi_register_master failed\n");
 		goto fail2;
 	}
-	pm_runtime_enable(&pdev->dev);
 
 	dev_info(&pdev->dev, "Coldfire QSPI bus driver\n");
 
-- 
2.1.4
