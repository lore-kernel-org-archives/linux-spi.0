From: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
Subject: [PATCH 12/12] spi/bcm63xx: use devm_ioremap_resource()
Date: Tue, 12 Mar 2013 00:13:47 +0100
Message-ID: <1363043627-23524-13-git-send-email-jogo@openwrt.org>
References: <1363043627-23524-1-git-send-email-jogo@openwrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1363043627-23524-1-git-send-email-jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Use devm_ioremap_resource() which provides its own error messages.

Signed-off-by: Jonas Gorski <jogo-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-bcm63xx.c |   15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx.c b/drivers/spi/spi-bcm63xx.c
index 2d64db4..973099b 100644
--- a/drivers/spi/spi-bcm63xx.c
+++ b/drivers/spi/spi-bcm63xx.c
@@ -412,18 +412,9 @@ static int bcm63xx_spi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, master);
 	bs->pdev = pdev;
 
-	if (!devm_request_mem_region(&pdev->dev, r->start,
-					resource_size(r), PFX)) {
-		dev_err(dev, "iomem request failed\n");
-		ret = -ENXIO;
-		goto out_err;
-	}
-
-	bs->regs = devm_ioremap_nocache(&pdev->dev, r->start,
-							resource_size(r));
-	if (!bs->regs) {
-		dev_err(dev, "unable to ioremap regs\n");
-		ret = -ENOMEM;
+	bs->regs = devm_ioremap_resource(&pdev->dev, r);
+	if (IS_ERR(bs->regs)) {
+		ret = PTR_ERR(bs->regs);
 		goto out_err;
 	}
 
-- 
1.7.10.4


------------------------------------------------------------------------------
Symantec Endpoint Protection 12 positioned as A LEADER in The Forrester  
Wave(TM): Endpoint Security, Q1 2013 and "remains a good choice" in the  
endpoint security space. For insight on selecting the right partner to 
tackle endpoint security challenges, access the full report. 
http://p.sf.net/sfu/symantec-dev2dev
