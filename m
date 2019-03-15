From: Mark Brown <broonie@kernel.org>
Subject: Applied "spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency" to the spi tree
Date: Fri, 15 Mar 2019 17:19:36 +0000 (GMT)
Message-ID: <20190315171936.AFE6C1126E81@debutante.sirena.org.uk>
References: <1552050741-27739-2-git-send-email-ludovic.Barre@st.com>
Cc: Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org, linux-spi@vger.kernel.org
To: Ludovic Barre <ludovic.barre@st.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1552050741-27739-2-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

The patch

   spi: spi-mem: stm32-qspi: avoid memory corruption at low frequency

has been applied to the spi tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git 

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

>From 5356c2c70e385198e1a753ee364323f2fc01f759 Mon Sep 17 00:00:00 2001
From: Ludovic Barre <ludovic.barre@st.com>
Date: Fri, 8 Mar 2019 14:12:20 +0100
Subject: [PATCH] spi: spi-mem: stm32-qspi: avoid memory corruption at low
 frequency

This patch solves a memory corruption seen at 8 MHz.
To avoid such issue, timeout counter is disabled.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/spi/spi-stm32-qspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3b2a9a6b990d..7354f9d68dba 100644
--- a/drivers/spi/spi-stm32-qspi.c
+++ b/drivers/spi/spi-stm32-qspi.c
@@ -76,7 +76,6 @@
 #define QSPI_PSMAR		0x28
 #define QSPI_PIR		0x2c
 #define QSPI_LPTR		0x30
-#define LPTR_DFT_TIMEOUT	0x10
 
 #define STM32_QSPI_MAX_MMAP_SZ	SZ_256M
 #define STM32_QSPI_MAX_NORCHIP	2
@@ -372,8 +371,7 @@ static int stm32_qspi_setup(struct spi_device *spi)
 	flash->presc = presc;
 
 	mutex_lock(&qspi->lock);
-	writel_relaxed(LPTR_DFT_TIMEOUT, qspi->io_base + QSPI_LPTR);
-	cr = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_TCEN | CR_SSHIFT | CR_EN;
+	cr = FIELD_PREP(CR_FTHRES_MASK, 3) | CR_SSHIFT | CR_EN;
 	writel_relaxed(cr, qspi->io_base + QSPI_CR);
 
 	/* set dcr fsize to max address */
-- 
2.20.1
