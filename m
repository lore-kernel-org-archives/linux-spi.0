From: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 2/2] spi: armada-3700: Replaced raw values for nbits by the SPI macros
Date: Wed, 21 Dec 2016 11:10:30 +0100
Message-ID: <20161221101030.10925-3-romain.perier@free-electrons.com>
References: <20161221101030.10925-1-romain.perier@free-electrons.com>
Cc: Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Gregory Clement <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org,
        Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20161221101030.10925-1-romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Currently, function a3700_spi_pin_mode_set() configures the SPI transfer
mode according to the value passed as second argument. This value is
detected using the raw values from a switch case.

This commit replaces these raw values by the corresponding macro
constants in linux/spi/spi.h

Signed-off-by: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
---
 drivers/spi/spi-armada-3700.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 0bfe5ff..e598421 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -170,12 +170,12 @@ static int a3700_spi_pin_mode_set(struct a3700_spi *a3700_spi,
 	val &= ~(A3700_SPI_DATA_PIN0 | A3700_SPI_DATA_PIN1);
 
 	switch (pin_mode) {
-	case 1:
+	case SPI_NBITS_SINGLE:
 		break;
-	case 2:
+	case SPI_NBITS_DUAL:
 		val |= A3700_SPI_DATA_PIN0;
 		break;
-	case 4:
+	case SPI_NBITS_QUAD:
 		val |= A3700_SPI_DATA_PIN1;
 		break;
 	default:
-- 
2.9.3

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
