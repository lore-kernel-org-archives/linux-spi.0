From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH 1/2] spi: omap2-mcspi: Remove list_empty checking in
 omap2_mcspi_transfer_one_message
Date: Tue, 18 Feb 2014 22:01:36 +0800
Message-ID: <1392732096.22192.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Stefan =?ISO-8859-1?Q?S=F8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>,
	Victor Kamensky <victor.kamensky-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Illia Smyrnov <illia.smyrnov-hExfYMNmJl/Cnp4W7fqMDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This checking is done in __spi_validate().

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-omap2-mcspi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
index 0493905..82cbe73 100644
--- a/drivers/spi/spi-omap2-mcspi.c
+++ b/drivers/spi/spi-omap2-mcspi.c
@@ -1207,9 +1207,6 @@ static int omap2_mcspi_transfer_one_message(struct spi_master *master,
 	m->actual_length = 0;
 	m->status = 0;
 
-	/* reject invalid messages and transfers */
-	if (list_empty(&m->transfers))
-		return -EINVAL;
 	list_for_each_entry(t, &m->transfers, transfer_list) {
 		const void	*tx_buf = t->tx_buf;
 		void		*rx_buf = t->rx_buf;
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
