From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] spi: dw-pci: Use dev_get_drvdata
Date: Wed, 24 Jul 2019 20:23:31 +0800
Message-ID: <20190724122331.21856-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
To: unlisted-recipients:; (no To-header on input)
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/spi/spi-dw-pci.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-dw-pci.c b/drivers/spi/spi-dw-pci.c
index 9651679ee7f7..c1e2401cace0 100644
--- a/drivers/spi/spi-dw-pci.c
+++ b/drivers/spi/spi-dw-pci.c
@@ -98,16 +98,14 @@ static void spi_pci_remove(struct pci_dev *pdev)
 #ifdef CONFIG_PM_SLEEP
 static int spi_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_suspend_host(dws);
 }
 
 static int spi_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct dw_spi *dws = pci_get_drvdata(pdev);
+	struct dw_spi *dws = dev_get_drvdata(dev);
 
 	return dw_spi_resume_host(dws);
 }
-- 
2.20.1
