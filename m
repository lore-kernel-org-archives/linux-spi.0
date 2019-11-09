From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: nxp-fspi: Use devm API to fix missed unregistration of controller
Date: Sat,  9 Nov 2019 15:55:17 +0800
Message-ID: <20191109075517.29988-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Yogesh Gaur <yogeshgaur.83@gmail.com>,
        Ashish Kumar <ashish.kumar@nxp.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

This driver forgets to unregister controller when remove.
Use devm API to unregister it automatically to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-nxp-fspi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-nxp-fspi.c b/drivers/spi/spi-nxp-fspi.c
index 501b923f2c27..c36bb1bb464e 100644
--- a/drivers/spi/spi-nxp-fspi.c
+++ b/drivers/spi/spi-nxp-fspi.c
@@ -1027,7 +1027,7 @@ static int nxp_fspi_probe(struct platform_device *pdev)
 
 	ctlr->dev.of_node = np;
 
-	ret = spi_register_controller(ctlr);
+	ret = devm_spi_register_controller(&pdev->dev, ctlr);
 	if (ret)
 		goto err_destroy_mutex;
 
-- 
2.23.0
