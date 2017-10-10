From: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
Subject: [PATCH 1/2] spi: a3700: Return correct value on timeout detection
Date: Tue, 10 Oct 2017 10:43:17 +0200
Message-ID: <1507624998-31425-1-git-send-email-maxime.chevallier@smile.fr>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        miquel.raynal-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org,
        Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When waiting for transfer completion, a3700_spi_wait_completion
returns a boolean indicating if a timeout occurred.

The function was returning 'true' everytime, failing to detect any
timeout.

This patch makes it return 'false' when a timeout is reached.

Signed-off-by: Maxime Chevallier <maxime.chevallier-fqqU8Ppg2Jk@public.gmane.org>
---
 drivers/spi/spi-armada-3700.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-armada-3700.c b/drivers/spi/spi-armada-3700.c
index 9172cb2..568e1c6 100644
--- a/drivers/spi/spi-armada-3700.c
+++ b/drivers/spi/spi-armada-3700.c
@@ -387,7 +387,8 @@ static bool a3700_spi_wait_completion(struct spi_device *spi)
 
 	spireg_write(a3700_spi, A3700_SPI_INT_MASK_REG, 0);
 
-	return true;
+	/* Timeout was reached */
+	return false;
 }
 
 static bool a3700_spi_transfer_wait(struct spi_device *spi,
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
