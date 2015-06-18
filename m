From: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: img-spfi: fix support for speeds up to 1/4th input clock
Date: Thu, 18 Jun 2015 13:50:54 +0100
Message-ID: <1434631854-11258-1-git-send-email-sifan.naeem@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
To: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Setting the Same Edge bit indicates to the spfi block to receive and
transmit data on the same edge of the spfi clock, which in turn
doubles the operating frequency of spfi.

The maximum supported frequency is limited to 1/4th of the spfi input
clock, but without this bit set the maximum would be 1/8th of the
input clock.

The current driver calculates the divisor with maximum speed at 1/4th
of the input clock, this would fail if the requested frequency is
higher than 1/8 of the input clock. Any requests for 1/8th of the
input clock would still pass.

Signed-off-by: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Fixes: 8543d0e72d43 ("spi: img-spfi: Limit bit clock to 1/4th of input clock")
Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> # 3.19+
---
 drivers/spi/spi-img-spfi.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-img-spfi.c b/drivers/spi/spi-img-spfi.c
index 1eb107f..a277faf 100644
--- a/drivers/spi/spi-img-spfi.c
+++ b/drivers/spi/spi-img-spfi.c
@@ -40,6 +40,7 @@
 #define SPFI_CONTROL_SOFT_RESET			BIT(11)
 #define SPFI_CONTROL_SEND_DMA			BIT(10)
 #define SPFI_CONTROL_GET_DMA			BIT(9)
+#define SPFI_CONTROL_SE			BIT(8)
 #define SPFI_CONTROL_TMODE_SHIFT		5
 #define SPFI_CONTROL_TMODE_MASK			0x7
 #define SPFI_CONTROL_TMODE_SINGLE		0
@@ -491,6 +492,7 @@ static void img_spfi_config(struct spi_master *master, struct spi_device *spi,
 	else if (xfer->tx_nbits == SPI_NBITS_QUAD &&
 		 xfer->rx_nbits == SPI_NBITS_QUAD)
 		val |= SPFI_CONTROL_TMODE_QUAD << SPFI_CONTROL_TMODE_SHIFT;
+	val |= SPFI_CONTROL_SE;
 	spfi_writel(spfi, val, SPFI_CONTROL);
 }
 
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
