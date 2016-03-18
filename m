From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
Subject: [PATCH 3/3] spi/fsl-espi: Don't wait transaction completion forever
Date: Fri, 18 Mar 2016 11:35:21 +0000
Message-ID: <59EFBE2126ED0E4AA25DF57320AFF129051FE3BB@BPXM14GP.gisp.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: ja-JP
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>

Because the eSPI driver uses wait_for_completion(), any stuck-able
phenomenon at half-way transaction progress made worker task hang up.
This phenomenon is perhaps caused by eSPI device errata which seems not
to be published from vendor site yet.

Anyway, we fix hang task by using fixed 2 seconds timeout
that is our preferred value for eSPI maximum transaction size.

It seems to be better that eSPI driver can detect this stuck and
report error (EMSGSIZE) to the upper device driver because
the upper device driver can decide to retry or recover.

Signed-off-by: Nobuteru Hayashi <hayashi.nbb-MBed0sS7vigTBYAz+LHnZg@public.gmane.org>
---
 drivers/spi/spi-fsl-espi.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index d7406f0..91b8e61 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -245,7 +245,12 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	if (ret)
 		return ret;
 
-	wait_for_completion(&mpc8xxx_spi->done);
+	/* Won't hang up forever, SPI bus sometimes got lost interrupts... */
+	ret = wait_for_completion_timeout(&mpc8xxx_spi->done, 2 * HZ);
+	if (ret == 0)
+		dev_err(mpc8xxx_spi->dev,
+			"Transaction hanging up (left %d bytes)\n",
+			mpc8xxx_spi->count);
 
 	/* disable rx ints */
 	mpc8xxx_spi_write_reg(&reg_base->mask, 0);
-- 
1.9.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
