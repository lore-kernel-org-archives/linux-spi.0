From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage" to the spi tree
Date: Mon, 24 Jun 2019 17:32:28 +0100 (BST)
Message-ID: <20190624163228.DD2B044006F@finisterre.sirena.org.uk>
References: <20190620131323.5955-1-patrice.chotard@st.com>
Cc: Alexandre Torgue <alexandre.torgue@st.com>,
        christophe.kerello@st.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        patrice.chotard@st.com
To: Patrice Chotard <patrice.chotard@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190620131323.5955-1-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-5.2

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 94613d5ae1091a28b33f38e18d96e8d953ac18df Mon Sep 17 00:00:00 2001
From: Patrice Chotard <patrice.chotard@st.com>
Date: Thu, 20 Jun 2019 15:13:23 +0200
Subject: [PATCH] spi: spi-stm32-qspi: Remove CR_FTHRES_MASK usage

On STM32 F4/F7/H7 SoCs, FTHRES is a 5 bits field in QSPI_CR register,
but for STM32MP1 SoCs, FTHRES is a 4 bits field long. CR_FTHRES_MASK
definition is not correct.

As for all these SoCs, FTHRES field is set to 3, FIELD_PREP() macro
is used with a constant as second parameter which make its usage useless.

CR_FTHRES_MASK and FIELD_PREP() can be removed.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.20.1
