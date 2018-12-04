From: Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v1] spi: npcm: Modify pspi send function
Date: Tue,  4 Dec 2018 15:40:35 +0200
Message-ID: <20181204134035.124079-1-tmaimon77@gmail.com>
Cc: linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tomer Maimon <tmaimon77@gmail.com>
To: broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        yuenn@google.com, venture@google.com, brendanhiggins@google.com,
        avifishman70@gmail.com, joel@jms.id.au
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Align pspi send function code with the recieve function
code, Also simplify the code a bit with early return.

Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
---
 drivers/spi/spi-npcm-pspi.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-npcm-pspi.c b/drivers/spi/spi-npcm-pspi.c
index dda91c19af93..e1dca79b9090 100644
--- a/drivers/spi/spi-npcm-pspi.c
+++ b/drivers/spi/spi-npcm-pspi.c
@@ -199,14 +199,22 @@ static void npcm_pspi_send(struct npcm_pspi *priv)
 	wsize = min(bytes_per_word(priv->bits_per_word), priv->tx_bytes);
 	priv->tx_bytes -= wsize;
 
-	if (priv->tx_buf) {
-		if (wsize == 1)
-			iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
-		if (wsize == 2)
-			iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+	if (!priv->tx_buf)
+		return;
 
-		priv->tx_buf += wsize;
+	switch (wsize) {
+	case 1:
+		iowrite8(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		break;
+	case 2:
+		iowrite16(*priv->tx_buf, NPCM_PSPI_DATA + priv->base);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
 	}
+
+	priv->tx_buf += wsize;
 }
 
 static void npcm_pspi_recv(struct npcm_pspi *priv)
-- 
2.14.1
