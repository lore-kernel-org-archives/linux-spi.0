From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1 1/1] spi: npcm: fix uninitialized 'val' warning in receive function
Date: Sun, 18 Nov 2018 14:35:04 +0200
Message-ID: <20181118123504.83082-2-tmaimon77@gmail.com>
References: <20181118123504.83082-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181118123504.83082-1-tmaimon77@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Fix uninitialized 'val' warning receive function, send function
has been modify to be aligned with the receive function.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-pspi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index 6dae91091143..f75df49ab84e 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -199,11 +199,11 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
 
-	if (priv->tx_buf) {
-		if (wsize == 1)
-			iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+	if (priv->tx_buf && wsize) {
 		if (wsize == 2)
 			iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		else
+			iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
 
 		priv->tx_buf += wsize;
 	}
@@ -217,11 +217,11 @@ static void npcm_pspi_recv(struct npcm_pspi *priv)
 	rsize = min(bytes_per_word(priv->bits_per_word), priv->rx_bytes);
 	priv->rx_bytes -= rsize;
 
-	if (priv->rx_buf) {
-		if (rsize == 1)
-			val = ioread8(priv->base + NPCM_PSPI_DATA);
+	if (priv->rx_buf && rsize) {
 		if (rsize == 2)
 			val = ioread16(priv->base + NPCM_PSPI_DATA);
+		else
+			val = ioread8(priv->base + NPCM_PSPI_DATA);
 
 		*priv->rx_buf = val;
 		priv->rx_buf += rsize;
-- 
2.14.1
