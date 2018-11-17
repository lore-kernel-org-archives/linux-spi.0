From: Olof Johansson <olof@lixom.net>
Subject: [PATCH] spi: npcm: Fix uninitialized variable warning
Date: Fri, 16 Nov 2018 19:55:04 -0800
Message-ID: <20181117035504.95804-1-olof@lixom.net>
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        opembmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Olof Johansson <olof@lixom.net>
To: broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The compiler has no way to know that rsize 1 or 2 are the only valid
values. Also simplify the code a bit with early return.

The warning was:

drivers/spi/spi-npcm-pspi.c:215:6: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]

Signed-off-by: Olof Johansson <olof@lixom.net>
---
 drivers/spi/spi-npcm-pspi.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 342178e282bcd..be0539cb19e49 100644
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
2.11.0
