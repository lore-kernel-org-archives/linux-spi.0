From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH 03/12] spi: rspi: Use devm_kasprintf()
Date: Wed,  6 Aug 2014 14:59:00 +0200
Message-ID: <1407329949-5695-4-git-send-email-geert+renesas@glider.be>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
Cc: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1407329949-5695-1-git-send-email-geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Use the devm_kasprintf() helper function instead of open coding
error-prone buffer handling and string formatting.

Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
devm_kasprintf() was included in upstream, and will be available as of
release v3.17-rc1.
---
 drivers/spi/spi-rspi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
index a4d8d3cf2912..aa1c6a893570 100644
--- a/drivers/spi/spi-rspi.c
+++ b/drivers/spi/spi-rspi.c
@@ -1046,12 +1046,11 @@ static int rspi_request_irq(struct device *dev, unsigned int irq,
 			    irq_handler_t handler, const char *suffix,
 			    void *dev_id)
 {
-	const char *base = dev_name(dev);
-	size_t len = strlen(base) + strlen(suffix) + 2;
-	char *name = devm_kzalloc(dev, len, GFP_KERNEL);
+	const char *name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s",
+					  dev_name(dev), suffix);
 	if (!name)
 		return -ENOMEM;
-	snprintf(name, len, "%s:%s", base, suffix);
+
 	return devm_request_irq(dev, irq, handler, 0, name, dev_id);
 }
 
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
