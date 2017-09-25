From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Applied "spi: sh-msiof: Add compatible strings for r8a774[35]" to the spi tree
Date: Mon, 25 Sep 2017 17:16:37 +0100 (BST)
Message-ID: <20170925161637.D7471440058@finisterre.ee.mobilebroadband>
References: <1506329660-4064-2-git-send-email-fabrizio.castro@bp.renesas.com>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-renesas-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Chris Paterson <Chris.Paterson2-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
        Biju Das <biju.das-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1506329660-4064-2-git-send-email-fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

The patch

   spi: sh-msiof: Add compatible strings for r8a774[35]

has been applied to the spi tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From bdacfc7b6216dd30d07c10732fd4c0a660c62853 Mon Sep 17 00:00:00 2001
From: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Date: Mon, 25 Sep 2017 09:54:19 +0100
Subject: [PATCH] spi: sh-msiof: Add compatible strings for r8a774[35]

Signed-off-by: Fabrizio Castro <fabrizio.castro-kTT6dE0pTRh9uiUsa/gSgQ@public.gmane.org>
Signed-off-by: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/spi/spi-sh-msiof.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 0eb1e9583485..00808448cf35 100644
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
2.14.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
