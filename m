From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 04/11] spi: spi-sh-msiof: set hi/low Active for HW CS
Date: Mon,  2 Dec 2013 03:19:15 +0900
Message-ID: <1385921962-19843-4-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Cc: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
To: linux-sh@vger.kernel.org
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Takashi Yoshii <takasi-y@ops.dti.ne.jp>

Set hardware CS(CS control function on MSIOF <-> GPIO CS) polarity
according to SPI_CS_HIGH flag on spi->mode.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 drivers/spi/spi-sh-msiof.c |   13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
index 2a2b0dd..8683732 100644
--- a/drivers/spi/spi-sh-msiof.c
+++ b/drivers/spi/spi-sh-msiof.c
@@ -169,7 +169,7 @@ static void sh_msiof_spi_set_clk_regs(struct sh_msiof_spi_priv *p,
 
 static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 				      u32 cpol, u32 cpha,
-				      u32 tx_hi_z, u32 lsb_first)
+				      u32 tx_hi_z, u32 lsb_first, u32 cs_high)
 {
 	u32 tmp;
 	int edge;
@@ -182,8 +182,12 @@ static void sh_msiof_spi_set_pin_regs(struct sh_msiof_spi_priv *p,
 	 *    1    1         11     11    1    1
 	 */
 	sh_msiof_write(p, FCTR, 0);
-	sh_msiof_write(p, TMDR1, 0xe2000005 | (lsb_first << 24));
-	sh_msiof_write(p, RMDR1, 0x22000005 | (lsb_first << 24));
+
+	tmp = 0;
+	tmp |= !cs_high << 25;
+	tmp |= lsb_first << 24;
+	sh_msiof_write(p, TMDR1, 0xe0000005 | tmp);
+	sh_msiof_write(p, RMDR1, 0x20000005 | tmp);
 
 	tmp = 0xa0000000;
 	tmp |= cpol << 30; /* TSCKIZ */
@@ -417,7 +421,8 @@ static void sh_msiof_spi_chipselect(struct spi_device *spi, int is_on)
 		sh_msiof_spi_set_pin_regs(p, !!(spi->mode & SPI_CPOL),
 					  !!(spi->mode & SPI_CPHA),
 					  !!(spi->mode & SPI_3WIRE),
-					  !!(spi->mode & SPI_LSB_FIRST));
+					  !!(spi->mode & SPI_LSB_FIRST),
+					  !!(spi->mode & SPI_CS_HIGH));
 	}
 
 	/* use spi->controller data for CS (same strategy as spi_gpio),
-- 
1.7.9.5

