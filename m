From: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 18/18] spi: fsl-espi: merge fsl_espi_trans and
 fsl_espi_do_trans
Date: Sun, 4 Sep 2016 10:02:47 +0200
Message-ID: <7fdc7bc0-873a-b750-edcd-627a0b0012e6@gmail.com>
References: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <e5c7d6cd-0ba1-b1ec-60a8-72d6e2607217-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Merge both functions to reduce source code size and improve
readability.

Signed-off-by: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
v2:
- rebased
---
 drivers/spi/spi-fsl-espi.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index 84355bb..f7d682f 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -276,11 +276,13 @@ static int fsl_espi_bufs(struct spi_device *spi, struct spi_transfer *t)
 	return mpc8xxx_spi->count > 0 ? -EMSGSIZE : 0;
 }
 
-static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
+static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
 {
+	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
 	struct spi_device *spi = m->spi;
-	int ret = 0;
+	int ret;
 
+	fsl_espi_copy_to_buf(m, mspi);
 	fsl_espi_setup_transfer(spi, trans);
 
 	ret = fsl_espi_bufs(spi, trans);
@@ -290,18 +292,6 @@ static int fsl_espi_do_trans(struct spi_message *m, struct spi_transfer *trans)
 
 	fsl_espi_setup_transfer(spi, NULL);
 
-	return ret;
-}
-
-static int fsl_espi_trans(struct spi_message *m, struct spi_transfer *trans)
-{
-	struct mpc8xxx_spi *mspi = spi_master_get_devdata(m->spi->master);
-	int ret;
-
-	fsl_espi_copy_to_buf(m, mspi);
-
-	ret = fsl_espi_do_trans(m, trans);
-
 	if (!ret)
 		fsl_espi_copy_from_buf(m, mspi);
 
-- 
2.9.2


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
