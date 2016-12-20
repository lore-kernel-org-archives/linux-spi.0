From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Do not use C++ style comment" to the spi tree
Date: Tue, 20 Dec 2016 11:41:21 +0000
Message-ID: <E1cJInJ-0000Ml-Uh@debutante>
References: <1482229276-21655-1-git-send-email-horms+renesas@verge.net.au>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>, linux-spi@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1482229276-21655-1-git-send-email-horms+renesas@verge.net.au>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Do not use C++ style comment

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

>From 264c3e8de4fbda1d1342213c78fb3788a43cfd41 Mon Sep 17 00:00:00 2001
From: Simon Horman <horms+renesas@verge.net.au>
Date: Tue, 20 Dec 2016 11:21:16 +0100
Subject: [PATCH] spi: sh-msiof: Do not use C++ style comment

4286db8456f4 ("spi: sh-msiof: Add R-Car Gen 2 and 3 fallback bindings")
added a C++ style comment. This is not in keeping with the style used
for comments elsewhere in this fine. Update it accordingly.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.11.0
