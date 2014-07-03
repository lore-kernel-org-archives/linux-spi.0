From: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] spi/spi-sh: Use devm_ioremap
Date: Fri, 4 Jul 2014 01:12:25 +0530
Message-ID: <20140703194225.GA4388@himangi-Dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: julia.lawall-L2FTfq7BK8M@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This patch introduces the use of devm_ioremap and removes the iounmaps
in the probe and remove functions. Also, the labels are renamed to
preserve ordering.

Signed-off-by: Himangi Saraogi <himangi774-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
I would like to know if it will be a good idea to devmify the
request_irq as well. There is ampiguity as the calls to
spi_unregister_master and destroy_workqueue are before free_irq in
remove function while after free_irq in the probe function.
 drivers/spi/spi-sh.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/spi/spi-sh.c b/drivers/spi/spi-sh.c
index 03edf5e..2c30da0 100644
--- a/drivers/spi/spi-sh.c
+++ b/drivers/spi/spi-sh.c
@@ -432,7 +432,6 @@ static int spi_sh_remove(struct platform_device *pdev)
 	spi_unregister_master(ss->master);
 	destroy_workqueue(ss->workqueue);
 	free_irq(ss->irq, ss);
-	iounmap(ss->addr);
 
 	return 0;
 }
@@ -480,7 +479,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	}
 	ss->irq = irq;
 	ss->master = master;
-	ss->addr = ioremap(res->start, resource_size(res));
+	ss->addr = devm_ioremap(&pdev->dev, res->start, resource_size(res));
 	if (ss->addr == NULL) {
 		dev_err(&pdev->dev, "ioremap error.\n");
 		ret = -ENOMEM;
@@ -501,7 +500,7 @@ static int spi_sh_probe(struct platform_device *pdev)
 	ret = request_irq(irq, spi_sh_irq, 0, "spi_sh", ss);
 	if (ret < 0) {
 		dev_err(&pdev->dev, "request_irq error\n");
-		goto error3;
+		goto error2;
 	}
 
 	master->num_chipselect = 2;
@@ -513,17 +512,15 @@ static int spi_sh_probe(struct platform_device *pdev)
 	ret = spi_register_master(master);
 	if (ret < 0) {
 		printk(KERN_ERR "spi_register_master error.\n");
-		goto error4;
+		goto error3;
 	}
 
 	return 0;
 
- error4:
-	free_irq(irq, ss);
  error3:
-	destroy_workqueue(ss->workqueue);
+	free_irq(irq, ss);
  error2:
-	iounmap(ss->addr);
+	destroy_workqueue(ss->workqueue);
  error1:
 	spi_master_put(master);
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
