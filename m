From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH 5/7] spi: sh-msiof: remove unnecessary OOM messages
Date: Tue, 29 Apr 2014 17:21:25 +0900
Message-ID: <002901cf6384$02d9ba10$088d2e30$%han@samsung.com>
References: <002401cf6383$7e9ce1f0$7bd6a5d0$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, 'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Geert Uytterhoeven' <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	'Magnus Damm' <damm-yzvPICuk2ACczHhG9Qg4qA@public.gmane.org>
To: 'Mark Brown' <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <002401cf6383$7e9ce1f0$7bd6a5d0$%han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The site-specific OOM messages are unnecessary, because they
duplicate the MM subsystem generic OOM message.

Signed-off-by: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index e850d03..45b0914 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -642,10 +642,8 @@ static struct sh_msiof_spi_info *sh_msiof_spi_parse_dt(struct device *dev)
 	u32 num_cs = 1;
 
 	info = devm_kzalloc(dev, sizeof(struct sh_msiof_spi_info), GFP_KERNEL);
-	if (!info) {
-		dev_err(dev, "failed to allocate setup data\n");
+	if (!info)
 		return NULL;
-	}
 
 	/* Parse the MSIOF properties */
 	of_property_read_u32(np, "num-cs", &num_cs);
-- 
1.7.10.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
