From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: sh-msiof: Fix handling of write value for SISTR register" to the spi tree
Date: Wed,  5 Sep 2018 12:46:08 +0100 (BST)
Message-ID: <20180905114608.0D63011229D0@debutante.sirena.org.uk>
References: <20180905084939.7401-3-geert+renesas@glider.be>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Brown <broonie@kernel.org>, stable@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Gaku Inami <gaku.inami.xw@bp.renesas.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-spi@vger.kernel.org
To: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180905084939.7401-3-geert+renesas@glider.be>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: sh-msiof: Fix handling of write value for SISTR register

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 31a5fae4c5a009898da6d177901d5328051641ff Mon Sep 17 00:00:00 2001
From: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
Date: Wed, 5 Sep 2018 10:49:37 +0200
Subject: [PATCH] spi: sh-msiof: Fix handling of write value for SISTR register

This patch changes writing to the SISTR register according to the H/W
user's manual.

The TDREQ bit and RDREQ bits of SISTR are read-only, and must be written
their initial values of zero.

Signed-off-by: Hiromitsu Yamasaki <hiromitsu.yamasaki.ym@renesas.com>
[geert: reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
---
 drivers/spi/spi-sh-msiof.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index bfe4e6d4f7bf..101cd6aae2ea 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -397,7 +397,8 @@ static void sh_msiof_spi_set_mode_regs(struct sh_msiof_spi_priv *p,
 
 static void sh_msiof_reset_str(struct sh_msiof_spi_priv *p)
 {
-	sh_msiof_write(p, STR, sh_msiof_read(p, STR));
+	sh_msiof_write(p, STR,
+		       sh_msiof_read(p, STR) & ~(STR_TDREQ | STR_RDREQ));
 }
 
 static void sh_msiof_spi_write_fifo_8(struct sh_msiof_spi_priv *p,
-- 
2.19.0.rc1
