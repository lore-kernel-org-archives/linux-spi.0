From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: topcliff-pch: Properly unregister platform devices on
 probe() error paths
Date: Mon, 24 Mar 2014 15:46:55 +0800
Message-ID: <1395647215.4333.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>,
	Tomoya MORINAGA <tomoya.rohm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Ensure all registered platform devices are unregistered on probe() error paths.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-topcliff-pch.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-topcliff-pch.c b/drivers/spi/spi-topcliff-pch.c
index 3540d52..e935ca6 100644
--- a/drivers/spi/spi-topcliff-pch.c
+++ b/drivers/spi/spi-topcliff-pch.c
@@ -1569,8 +1569,7 @@ static struct platform_driver pch_spi_pd_driver = {
 	.resume = pch_spi_pd_resume
 };
 
-static int pch_spi_probe(struct pci_dev *pdev,
-				   const struct pci_device_id *id)
+static int pch_spi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pch_spi_board_data *board_dat;
 	struct platform_device *pd_dev = NULL;
@@ -1640,6 +1639,8 @@ static int pch_spi_probe(struct pci_dev *pdev,
 	return 0;
 
 err_platform_device:
+	while (--i >= 0)
+		platform_device_unregister(pd_dev_save->pd_save[i]);
 	pci_disable_device(pdev);
 pci_enable_device:
 	pci_release_regions(pdev);
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
