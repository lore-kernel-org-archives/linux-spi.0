From: Axel Lin <axel.lin@ingics.com>
Subject: [PATCH RFT] spi: spi-xcomm: Fix wrong setting for
 SPI_XCOMM_SETTINGS_CPHA
Date: Tue, 04 Dec 2012 14:27:41 +0800
Message-ID: <1354602461.3286.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>,
	Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The logic of setting SPI_XCOMM_SETTINGS_CPHA bit is reversed.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
Hi Lars,
The logic of setting SPI_XCOMM_SETTINGS_CPHA bit looks wrong to me.
Can you check if this patch works?

Thanks,
Axel

 drivers/spi/spi-xcomm.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-xcomm.c b/drivers/spi/spi-xcomm.c
index 266a847..c2a3e8f 100644
--- a/drivers/spi/spi-xcomm.c
+++ b/drivers/spi/spi-xcomm.c
@@ -99,9 +99,9 @@ static int spi_xcomm_setup_transfer(struct spi_xcomm *spi_xcomm,
 		*settings &= ~SPI_XCOMM_SETTINGS_CPOL;
 
 	if (spi->mode & SPI_CPHA)
-		*settings &= ~SPI_XCOMM_SETTINGS_CPHA;
-	else
 		*settings |= SPI_XCOMM_SETTINGS_CPHA;
+	else
+		*settings &= ~SPI_XCOMM_SETTINGS_CPHA;
 
 	if (spi->mode & SPI_3WIRE)
 		*settings |= SPI_XCOMM_SETTINGS_3WIRE;
-- 
1.7.9.5
