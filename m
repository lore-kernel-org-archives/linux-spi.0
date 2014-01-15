From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: octeon: Use list_is_last() instead of open-coded
Date: Wed, 15 Jan 2014 13:22:17 +0800
Message-ID: <1389763337.7410.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: David Daney <david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>,
	John Crispin <blogic-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-octeon.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-octeon.c b/drivers/spi/spi-octeon.c
index 67249a4..862ef30 100644
--- a/drivers/spi/spi-octeon.c
+++ b/drivers/spi/spi-octeon.c
@@ -179,7 +179,8 @@ static int octeon_spi_transfer_one_message(struct spi_master *master,
 	}
 
 	list_for_each_entry(xfer, &msg->transfers, transfer_list) {
-		bool last_xfer = &xfer->transfer_list == msg->transfers.prev;
+		bool last_xfer = list_is_last(&xfer->transfer_list,
+					      &msg->transfers);
 		int r = octeon_spi_do_transfer(p, msg, xfer, last_xfer);
 		if (r < 0) {
 			status = r;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
