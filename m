From: Andreas Werner <andreas.werner@men.de>
Subject: [PATCH] spi/spi-fsl-espi.c: Add spi cs polarity support
Date: Mon, 7 Dec 2015 08:07:16 +0100
Message-ID: <20151207070657.GA25586@awelinux>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <linux-spi@vger.kernel.org>, <broonie@kernel.org>
To: <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Add CS polarity flag to be able to set the CS polarity
via the DT property spi-cs-high.

Signed-off-by: Andreas Werner <andreas.werner@men.de>
---
 drivers/spi/spi-fsl-espi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c
index c27124a..2dc70953 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -495,7 +495,7 @@ static int fsl_espi_setup(struct spi_device *spi)
 			&reg_base->csmode[spi->chip_select]);
 	/* mask out bits we are going to set */
 	cs->hw_mode &= ~(CSMODE_CP_BEGIN_EDGECLK | CSMODE_CI_INACTIVEHIGH
-			 | CSMODE_REV);
+			 | CSMODE_REV | CSMODE_POL_1);
 
 	if (spi->mode & SPI_CPHA)
 		cs->hw_mode |= CSMODE_CP_BEGIN_EDGECLK;
@@ -503,6 +503,8 @@ static int fsl_espi_setup(struct spi_device *spi)
 		cs->hw_mode |= CSMODE_CI_INACTIVEHIGH;
 	if (!(spi->mode & SPI_LSB_FIRST))
 		cs->hw_mode |= CSMODE_REV;
+	if (!(spi->mode & SPI_CS_HIGH))
+		cs->hw_mode |= CSMODE_POL_1;
 
 	/* Handle the loop mode */
 	loop_mode = mpc8xxx_spi_read_reg(&reg_base->mode);
-- 
2.6.2
