From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH 3/4] spi: dw: fix memory leak on error path
Date: Thu, 26 Dec 2013 09:00:14 +0200
Message-ID: <4ed40da8c93766ac05ee8d3507ae1d9fdc0a68a7.1388040447.git.baruch@tkos.co.il>
References: <cover.1388040447.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388040447.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
 drivers/spi/spi-dw.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index e37dfc1..c3354e8 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -616,6 +616,7 @@ static int dw_spi_setup(struct spi_device *spi)
 {
 	struct dw_spi_chip *chip_info = NULL;
 	struct chip_data *chip;
+	int ret;
 
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
@@ -656,7 +657,8 @@ static int dw_spi_setup(struct spi_device *spi)
 
 	if (!spi->max_speed_hz) {
 		dev_err(&spi->dev, "No max speed HZ parameter\n");
-		return -EINVAL;
+		ret = -EINVAL;
+		goto err_kfree;
 	}
 	chip->speed_hz = spi->max_speed_hz;
 
@@ -669,6 +671,11 @@ static int dw_spi_setup(struct spi_device *spi)
 
 	spi_set_ctldata(spi, chip);
 	return 0;
+
+err_kfree:
+	kfree(chip);
+
+	return ret;
 }
 
 static void dw_spi_cleanup(struct spi_device *spi)
-- 
1.8.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
