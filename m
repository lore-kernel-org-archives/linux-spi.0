From: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Subject: [PATCH v2 3/3] spi: dw: fix memory leak on error path
Date: Mon, 30 Dec 2013 20:30:46 +0200
Message-ID: <595523d657a57cc4103553b062c505dc0cff4649.1388427564.git.baruch@tkos.co.il>
References: <cover.1388427564.git.baruch@tkos.co.il>
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Jean-Hugues Deschenes <jean-hugues.deschenes-YGVykHU+fedBDgjK7y7TUQ@public.gmane.org>,
	Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <cover.1388427564.git.baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Cc: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Baruch Siach <baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org>
---
v2:
    Use managed resources to fix the leak
---
 drivers/spi/spi-dw.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
index 48ec161..bf98d63 100644
--- a/drivers/spi/spi-dw.c
+++ b/drivers/spi/spi-dw.c
@@ -619,9 +619,11 @@ static int dw_spi_setup(struct spi_device *spi)
 	/* Only alloc on first setup */
 	chip = spi_get_ctldata(spi);
 	if (!chip) {
-		chip = kzalloc(sizeof(struct chip_data), GFP_KERNEL);
+		chip = devm_kzalloc(&spi->dev, sizeof(struct chip_data),
+				GFP_KERNEL);
 		if (!chip)
 			return -ENOMEM;
+		spi_set_ctldata(spi, chip);
 	}
 
 	/*
@@ -666,7 +668,6 @@ static int dw_spi_setup(struct spi_device *spi)
 			| (spi->mode  << SPI_MODE_OFFSET)
 			| (chip->tmode << SPI_TMOD_OFFSET);
 
-	spi_set_ctldata(spi, chip);
 	return 0;
 }
 
-- 
1.8.5.2

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
