From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH v2 4/4] spi: spi-coldfire-qspi: enable RuntimePM before registering to the core
Date: Fri,  9 Oct 2015 10:39:27 +0100
Message-ID: <1444383567-18113-4-git-send-email-wsa@the-dreams.de>
References: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
Cc: Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
To: linux-sh@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444383567-18113-1-git-send-email-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>

The core may register clients attached to this master which may use
funtionality from the master. So, RuntimePM must be enabled before, otherwise
this will fail.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/spi/spi-coldfire-qspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-coldfire-qspi.c b/drivers/spi/spi-coldfire-qspi.c
index 688956ff5095c2..23f6fffd75e111 100644
--- a/drivers/spi/spi-coldfire-qspi.c
+++ b/drivers/spi/spi-coldfire-qspi.c
@@ -420,19 +420,20 @@ static int mcfqspi_probe(struct platform_device *pdev)
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
 
 	return 0;
 
 fail2:
+	pm_runtime_disable(&pdev->dev);
 	mcfqspi_cs_teardown(mcfqspi);
 fail1:
 	clk_disable(mcfqspi->clk);
-- 
2.1.4
