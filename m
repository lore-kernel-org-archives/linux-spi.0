From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH RFT] spi: mpc512x-psc: Refactor to use core message parsing
Date: Thu, 27 Mar 2014 23:05:57 +0800
Message-ID: <1395932757.17331.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Refactor to use default implementation of transfer_one_message() which provides
standard handling of delays and chip select management.

Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
---
Hi Gerhard and Anatolij,
I don't have this h/w. I'd appreciate if you can test this patch.

Thanks,
Axel
 drivers/spi/spi-mpc512x-psc.c | 58 +++++++++++++------------------------------
 1 file changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/spi/spi-mpc512x-psc.c b/drivers/spi/spi-mpc512x-psc.c
index 3822eef..a944769 100644
--- a/drivers/spi/spi-mpc512x-psc.c
+++ b/drivers/spi/spi-mpc512x-psc.c
@@ -265,50 +265,25 @@ static int mpc512x_psc_spi_transfer_rxtx(struct spi_device *spi,
 	return 0;
 }
 
-static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
-				    struct spi_message *m)
+static void mpc512x_psc_spi_set_cs(struct spi_device *spi, bool enable)
 {
-	struct spi_device *spi;
-	unsigned cs_change;
-	int status;
-	struct spi_transfer *t;
-
-	spi = m->spi;
-	cs_change = 1;
-	status = 0;
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->bits_per_word || t->speed_hz) {
-			status = mpc512x_psc_spi_transfer_setup(spi, t);
-			if (status < 0)
-				break;
-		}
-
-		if (cs_change)
-			mpc512x_psc_spi_activate_cs(spi);
-		cs_change = t->cs_change;
-
-		status = mpc512x_psc_spi_transfer_rxtx(spi, t);
-		if (status)
-			break;
-		m->actual_length += t->len;
-
-		if (t->delay_usecs)
-			udelay(t->delay_usecs);
-
-		if (cs_change)
-			mpc512x_psc_spi_deactivate_cs(spi);
-	}
-
-	m->status = status;
-	m->complete(m->context);
-
-	if (status || !cs_change)
+	if (enable)
+		mpc512x_psc_spi_activate_cs(spi);
+	else
 		mpc512x_psc_spi_deactivate_cs(spi);
+}
+
+static int mpc51x_psc_spi_transfer_one(struct spi_master *master,
+				       struct spi_device *spi,
+				       struct spi_transfer *t)
+{
+	int status;
 
-	mpc512x_psc_spi_transfer_setup(spi, NULL);
+	status = mpc512x_psc_spi_transfer_setup(spi, t);
+	if (status < 0)
+		return status;
 
-	spi_finalize_current_message(master);
-	return status;
+	return mpc512x_psc_spi_transfer_rxtx(spi, t);
 }
 
 static int mpc512x_psc_spi_prep_xfer_hw(struct spi_master *master)
@@ -494,7 +469,8 @@ static int mpc512x_psc_spi_do_probe(struct device *dev, u32 regaddr,
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI_LSB_FIRST;
 	master->setup = mpc512x_psc_spi_setup;
 	master->prepare_transfer_hardware = mpc512x_psc_spi_prep_xfer_hw;
-	master->transfer_one_message = mpc512x_psc_spi_msg_xfer;
+	master->set_cs = mpc512x_psc_spi_set_cs;
+	master->transfer_one = mpc51x_psc_spi_transfer_one;
 	master->unprepare_transfer_hardware = mpc512x_psc_spi_unprep_xfer_hw;
 	master->cleanup = mpc512x_psc_spi_cleanup;
 	master->dev.of_node = dev->of_node;
-- 
1.8.3.2



--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
