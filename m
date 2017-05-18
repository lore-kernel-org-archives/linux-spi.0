From: <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/1] spi: imx: fix issue when tx_buf or rx_buf is NULL
Date: Thu, 18 May 2017 03:01:12 -0700
Message-ID: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <leonard.crestez-3arQi8VN3Tc@public.gmane.org>, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>

In case either transfer->tx_buf or transfer->rx_buf is NULL,
manipulation of buffer in spi_imx_u32_swap_u[8|16]() will cause
NULL pointer dereference crash.

Add buffer check at very beginning of spi_imx_u32_swap_u[8|16](),
to avoid such crash.

Signed-off-by: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Reported-by: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
---
 drivers/spi/spi-imx.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
index 782045f..19b30cf 100644
--- a/drivers/spi/spi-imx.c
+++ b/drivers/spi/spi-imx.c
@@ -288,6 +288,9 @@ static void spi_imx_u32_swap_u8(struct spi_transfer *transfer, u32 *buf)
 {
 	int i;
 
+	if (!buf)
+		return;
+
 	for (i = 0; i < transfer->len / 4; i++)
 		*(buf + i) = cpu_to_be32(*(buf + i));
 }
@@ -296,6 +299,9 @@ static void spi_imx_u32_swap_u16(struct spi_transfer *transfer, u32 *buf)
 {
 	int i;
 
+	if (!buf)
+		return;
+
 	for (i = 0; i < transfer->len / 4; i++) {
 		u16 *temp = (u16 *)buf;
 
-- 
2.7.4


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
