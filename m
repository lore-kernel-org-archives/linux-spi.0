From: <jiada_wang@mentor.com>
Subject: [PATCH linux-next v2 2/2] spi: imx: don't manipulate trasnfer buffer directly
Date: Tue, 23 May 2017 07:35:29 -0700
Message-ID: <1495550129-3489-3-git-send-email-jiada_wang@mentor.com>
References: <1495550129-3489-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jiada Wang <jiada_wang@mentor.com>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1495550129-3489-1-git-send-email-jiada_wang@mentor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Jiada Wang <jiada_wang@mentor.com>

Previously spi_imx_u32_swap_u8() and spi_imx_u32_swap_u16() directly
manipulate const tx buffer by explicit cast from const void* to u32*,
this is not valid.

This patch by swap 32 bits data one by one before write to register,
and swap received 32 bits data one by one before save to receive
buffer to avoid direct manipulation of transfer buffer.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
Reported-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/spi/spi-imx.c | 83 +++++++++++++++++++++++----------------------------
 1 file changed, 38 insertions(+), 45 deletions(-)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 2768e64..4144228 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -285,38 +285,38 @@ static bool spi_imx_can_dma(struct spi_master *master, struct spi_device *spi,
 #define MX51_ECSPI_TESTREG	0x20
 #define MX51_ECSPI_TESTREG_LBC	BIT(31)
 
-static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u32 *buf)
+static u32 spi_imx_u32_swap_u16(u32 val)
 {
-	int i;
+	u32 data = val;
+	u16 *temp = (u16 *)&data;
 
-	if (!buf)
-		return;
+	*temp = cpu_to_be16(*temp);
+	*(temp + 1) = cpu_to_be16(*(temp + 1));
 
-	for (i = 0; i < transfer->len / 4; i++)
-		*(buf + i) = cpu_to_be32(*(buf + i));
+	data = cpu_to_be32(data);
+
+	return data;
 }
 
-static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u32 *buf)
+static void spi_imx_buf_rx_swap_u32(struct spi_imx_data *spi_imx)
 {
-	int i;
-
-	if (!buf)
-		return;
-
-	for (i = 0; i < transfer->len / 4; i++) {
-		u16 *temp = (u16 *)buf;
+	unsigned int val = readl(spi_imx->base + MXC_CSPIRXDATA);
 
-		*(temp + i * 2) = cpu_to_be16(*(temp + i * 2));
-		*(temp + i * 2 + 1) = cpu_to_be16(*(temp + i * 2 + 1));
+	if (spi_imx->rx_buf) {
+		if (spi_imx->bpw_w == 1)
+			val = cpu_to_be32(val);
+		else if (spi_imx->bpw_w == 2)
+			val = spi_imx_u32_swap_u16(val);
 
-		*(buf + i) = cpu_to_be32(*(buf + i));
+		*(u32 *)spi_imx->rx_buf = val;
+		spi_imx->rx_buf += sizeof(u32);
 	}
 }
 
 static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
 {
 	if (!spi_imx->bpw_rx) {
-		spi_imx_buf_rx_u32(spi_imx);
+		spi_imx_buf_rx_swap_u32(spi_imx);
 		return;
 	}
 
@@ -326,6 +326,24 @@ static void spi_imx_buf_rx_swap(struct spi_imx_data *spi_imx)
 		spi_imx_buf_rx_u16(spi_imx);
 }
 
+static void spi_imx_buf_tx_swap_u32(struct spi_imx_data *spi_imx)
+{
+	u32 val = 0;
+
+	if (spi_imx->tx_buf) {
+		val = *(u32 *)spi_imx->tx_buf;
+		spi_imx->tx_buf += sizeof(u32);
+	}
+
+	spi_imx->count -= sizeof(u32);
+	if (spi_imx->bpw_w == 1)
+		val = cpu_to_be32(val);
+	else if (spi_imx->bpw_w == 2)
+		val = spi_imx_u32_swap_u16(val);
+
+	writel(val, spi_imx->base + MXC_CSPITXDATA);
+}
+
 static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 {
 	u32 ctrl, val;
@@ -346,7 +364,7 @@ static void spi_imx_buf_tx_swap(struct spi_imx_data *spi_imx)
 	}
 
 	if (spi_imx->count >= sizeof(u32)) {
-		spi_imx_buf_tx_u32(spi_imx);
+		spi_imx_buf_tx_swap_u32(spi_imx);
 		return;
 	}
 
@@ -1212,18 +1230,6 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		else
 			spi_imx->count_index = spi_imx->count % sizeof(u32);
 
-		switch (spi_imx->bpw_w) {
-		case 1:
-			spi_imx_u32_swap_u8(transfer,
-					    (u32 *)transfer->tx_buf);
-			break;
-		case 2:
-			spi_imx_u32_swap_u16(transfer,
-					     (u32 *)transfer->tx_buf);
-			break;
-		default:
-			break;
-		}
 	}
 
 	reinit_completion(&spi_imx->xfer_done);
@@ -1242,21 +1248,8 @@ static int spi_imx_pio_transfer(struct spi_device *spi,
 		return -ETIMEDOUT;
 	}
 
-	if (spi_imx->dynamic_burst) {
-		switch (spi_imx->bpw_w) {
-		case 1:
-			spi_imx_u32_swap_u8(transfer,
-					    (u32 *)transfer->rx_buf);
-			break;
-		case 2:
-			spi_imx_u32_swap_u16(transfer,
-					     (u32 *)transfer->rx_buf);
-			break;
-		default:
-			break;
-		}
+	if (spi_imx->dynamic_burst)
 		spi_imx->dynamic_burst = 0;
-	}
 
 	return transfer->len;
 }
-- 
2.7.4
