From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/7] spi: core: Validate Tx/Rx buffers for non-zero length
 transfer
Date: Wed, 19 Mar 2014 11:53:47 +0800
Message-ID: <1395201227.16346.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Wenyou Yang <wenyou.yang-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	Fabrice Crohas <fcrohas-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>,
	Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Reject transfer if both tx_buf and rx_buf are NULL for non-zero length transfer.
Add the checking in spi core so we can remove the same checking in various
drivers.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 26b331d..0a29d2a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1876,6 +1876,10 @@ static int __spi_validate(struct spi_device *spi, struct spi_message *message)
 		if (xfer->len % w_size)
 			return -EINVAL;
 
+		/* non-zero length transfer must has tx_buf or rx_buf */
+		if (xfer->len && !xfer->tx_buf && !xfer->rx_buf)
+			return -EINVAL;
+
 		if (xfer->speed_hz && master->min_speed_hz &&
 		    xfer->speed_hz < master->min_speed_hz)
 			return -EINVAL;
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
