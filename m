From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: npcm: Fix uninitialized variable warning" to the spi tree
Date: Wed, 28 Nov 2018 16:05:56 +0000 (GMT)
Message-ID: <20181128160556.0D951112521B@debutante.sirena.org.uk>
References: <20181117035504.95804-1-olof@lixom.net>
Cc: Mark Brown <broonie@kernel.org>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        opembmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        linux-spi@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181117035504.95804-1-olof@lixom.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: npcm: Fix uninitialized variable warning

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

>From 1d2319efb6a970d5f5740a60828244e6c309df2b Mon Sep 17 00:00:00 2001
From: Olof Johansson <olof@lixom.net>
Date: Fri, 16 Nov 2018 19:55:04 -0800
Subject: [PATCH] spi: npcm: Fix uninitialized variable warning

The compiler has no way to know that rsize 1 or 2 are the only valid
values. Also simplify the code a bit with early return.

The warning was:

drivers/spi/spi-npcm-pspi.c:215:6: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Olof Johansson <olof@lixom.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-npcm-pspi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index fed05b02007c..dda91c19af93 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -217,15 +217,23 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
 	priv->rx_bytes -= rsize;
 
-	if (priv->rx_buf) {
-		if (rsize == 1)
-			val = ioread8(priv->base + NPCM_PSPI_DATA);
-		if (rsize == 2)
-			val = ioread16(priv->base + NPCM_PSPI_DATA);
+	if (!priv->rx_buf)
+		return;
 
-		*priv->rx_buf = val;
-		priv->rx_buf += rsize;
+	switch (rsize) {
+	case 1:
+		val = ioread8(priv->base + NPCM_PSPI_DATA);
+		break;
+	case 2:
+		val = ioread16(priv->base + NPCM_PSPI_DATA);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	*priv->rx_buf = val;
+	priv->rx_buf += rsize;
 }
 
 static int npcm_pspi_transfer_one(struct spi_master *master,
-- 
2.19.0.rc2
