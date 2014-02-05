From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] spi: mxs: Use list_for_each_entry to iterate over transfer
 list
Date: Wed, 05 Feb 2014 17:47:59 +0800
Message-ID: <1391593679.1420.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

We don't modify the list entry while iterating the transfer list.
So use list_for_each_entry instead of list_for_each_entry_safe.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
 drivers/spi/spi-mxs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mxs.c b/drivers/spi/spi-mxs.c
index 17bb9a9..4208f24 100644
--- a/drivers/spi/spi-mxs.c
+++ b/drivers/spi/spi-mxs.c
@@ -370,7 +370,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 {
 	struct mxs_spi *spi = spi_master_get_devdata(master);
 	struct mxs_ssp *ssp = &spi->ssp;
-	struct spi_transfer *t, *tmp_t;
+	struct spi_transfer *t;
 	unsigned int flag;
 	int status = 0;
 
@@ -380,7 +380,7 @@ static int mxs_spi_transfer_one(struct spi_master *master,
 	writel(mxs_spi_cs_to_reg(m->spi->chip_select),
 	       ssp->base + HW_SSP_CTRL0 + STMP_OFFSET_REG_SET);
 
-	list_for_each_entry_safe(t, tmp_t, &m->transfers, transfer_list) {
+	list_for_each_entry(t, &m->transfers, transfer_list) {
 
 		status = mxs_spi_setup_transfer(m->spi, t);
 		if (status)
-- 
1.8.1.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
