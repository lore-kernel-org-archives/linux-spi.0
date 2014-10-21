From: gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org
Subject: [PATCH] spi: orion: fix potential NULL pointer de-reference
Date: Tue, 21 Oct 2014 15:57:48 +1000
Message-ID: <1413871068-32174-1-git-send-email-gerg@uclinux.org>
Cc: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>

It's possible that the call to of_match_device() (introduced in commit
df59fa7f ["spi: orion: support armada extended baud rates"]) may return
a NULL if there is no match in the device tree (or perhaps no device tree
at all). Check the return pointer and set the local device data to the
lowest common denominator orion device data if it is NULL.

Reported-by: Karl Beldan <karl.beldan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Greg Ungerer <gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org>
---
 drivers/spi/spi-orion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-orion.c b/drivers/spi/spi-orion.c
index 835cdda..c76b7d7 100644
--- a/drivers/spi/spi-orion.c
+++ b/drivers/spi/spi-orion.c
@@ -454,7 +454,7 @@ static int orion_spi_probe(struct platform_device *pdev)
 	spi->master = master;
 
 	of_id = of_match_device(orion_spi_of_match_table, &pdev->dev);
-	devdata = of_id->data;
+	devdata = (of_id) ? of_id->data : &orion_spi_dev_data;
 	spi->devdata = devdata;
 
 	spi->clk = devm_clk_get(&pdev->dev, NULL);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
