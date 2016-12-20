From: Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH spi/for-next] sip: sh-msiof: Do not use C++ style comment
Date: Tue, 20 Dec 2016 11:21:16 +0100
Message-ID: <1482229276-21655-1-git-send-email-horms+renesas@verge.net.au>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms+renesas@verge.net.au>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

4286db8456f4 ("spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings")
added a C++ style comment. This is not in keeping with the style used
for comments elsewhere in this fine. Update it accordingly.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 drivers/spi/spi-sh-msiof.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 471ca211b76c..1f00eeb0b5a3 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -982,7 +982,7 @@ static const struct of_device_id sh_msiof_match[] = {
 	{ .compatible = "renesas,rcar-gen2-msiof", .data = &r8a779x_data },
 	{ .compatible = "renesas,msiof-r8a7796",   .data = &r8a779x_data },
 	{ .compatible = "renesas,rcar-gen3-msiof", .data = &r8a779x_data },
-	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, // Deprecated
+	{ .compatible = "renesas,sh-msiof",        .data = &sh_data }, /* Deprecated */
 	{},
 };
 MODULE_DEVICE_TABLE(of, sh_msiof_match);
-- 
2.7.0.rc3.207.g0ac5344
