From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Subject: [PATCH 1/2] spi: sh-msiof: Add compatible strings for r8a774[35]
Date: Mon, 25 Sep 2017 09:54:19 +0100
Message-ID: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
References: <1506329660-4064-1-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>,
        Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506329660-4064-1-git-send-email-fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0eb1e95..0080844 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -1021,6 +1021,8 @@ static const struct sh_msiof_chipdata rcar_gen3_data = {
 
 static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,sh-mobile-msiof", .data = &sh_data },
+	{ .compatible = "renesas,msiof-r8a7743",   .data = &rcar_gen2_data },
+	{ .compatible = "renesas,msiof-r8a7745",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7790",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7791",   .data = &rcar_gen2_data },
 	{ .compatible = "renesas,msiof-r8a7792",   .data = &rcar_gen2_data },
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
