From: <patrice.chotard@st.com>
Subject: [PATCH 1/1] spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage
Date: Thu, 20 Jun 2019 15:13:23 +0200
Message-ID: <20190620131323.5955-1-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: <patrice.chotard@st.com>, <christophe.kerello@st.com>
To: Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-spi@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

On STM32 F4/F7/H7 SoCs, FTHRES is a 5 bits field in QSPI_CR register,
but for STM32MP1 SoCs, FTHRES is a 4 bits field long. CR_FTHRES_MASK
definition is not correct.

As for all these SoCs, FTHRES field is set to 3, FIELD_PREP() macro
is used with a constant as second parameter which make its usage useless.

CR_FTHRES_MASK and FIELD_PREP() can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 42f8e3c6aa1f..5dbb6a8e893c 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -29,7 +29,7 @@
 #define CR_SSHIFT		BIT(4)
 #define CR_DFM			BIT(6)
 #define CR_FSEL			BIT(7)
-#define CR_FTHRES_MASK		GENMASK(12, 8)
+#define CR_FTHRES_SHIFT		8
 #define CR_TEIE			BIT(16)
 #define CR_TCIE			BIT(17)
 #define CR_FTIE			BIT(18)
@@ -463,7 +463,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	qspi->cr_reg = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
+	qspi->cr_reg = 3 << CR_FTHRES_SHIFT | CR_SSHIFT | CR_EN;
 	writel_relaxed(qspi->cr_reg, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
-- 
2.17.1
