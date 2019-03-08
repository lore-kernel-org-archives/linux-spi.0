From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 1/2] spi: spi-mem: stm32-qspi: avoid memory corruption at low
 frequency
Date: Fri, 8 Mar 2019 14:12:20 +0100
Message-ID: <1552050741-27739-2-git-send-email-ludovic.Barre@st.com>
References: <1552050741-27739-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, Ludovic Barre <ludovic.barre@st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
To: Mark Brown <broonie@kernel.org>, Marek Vasut <marek.vasut@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>, Rob Herring
 <robh+dt@kernel.org>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1552050741-27739-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch solves a memory corruption seen at 8 MHz.
To avoid such issue, timeout counter is disabled.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/spi/spi-stm32-qspi.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/spi/spi-stm32-qspi.c b/drivers/spi/spi-stm32-qspi.c
index 3b2a9a6..7354f9d 100644
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
2.7.4


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
