From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: [PATCH/RFC 2/2] sh: use DMA with MSIOF SPI on the sh7724 ecovec
 board
Date: Mon, 24 Jan 2011 11:24:40 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1101241123340.12760@axis700.grange>
References: <Pine.LNX.4.64.1101241110400.12760@axis700.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org
To: spi-devel-general@lists.sourceforge.net
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1101241110400.12760@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On ecovec MSIOF0 is connected to an SD/MMC slot, this patch adds DMA
support on it.

not-Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

FYI only

 arch/sh/boards/mach-ecovec24/setup.c   |   11 ++++++++++-
 arch/sh/include/cpu-sh4/cpu/sh7724.h   |    4 ++++
 arch/sh/kernel/cpu/sh4a/setup-sh7724.c |   20 ++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletions(-)

diff --git a/arch/sh/boards/mach-ecovec24/setup.c b/arch/sh/boards/mach-ecovec24/setup.c
index 701667a..aa620fd 100644
--- a/arch/sh/boards/mach-ecovec24/setup.c
+++ b/arch/sh/boards/mach-ecovec24/setup.c
@@ -580,8 +580,14 @@ static struct spi_board_info spi_bus[] = {
 };
 
 /* MSIOF0 */
+struct sh_msiof_spi_dma msiof0_dma = {
+	.chan_priv_tx = {.slave_id = SHDMA_SLAVE_MSIOF0_TX},
+	.chan_priv_rx = {.slave_id = SHDMA_SLAVE_MSIOF0_RX},
+};
+
 static struct sh_msiof_spi_info msiof0_data = {
 	.num_chipselect = 1,
+	.dma = &msiof0_dma,
 };
 
 static struct resource msiof0_resources[] = {
@@ -597,11 +603,14 @@ static struct resource msiof0_resources[] = {
 	},
 };
 
+u64 msiof0_dmamask = (1ULL << 32) - 1;
+
 static struct platform_device msiof0_device = {
 	.name		= "spi_sh_msiof",
 	.id		= 0, /* MSIOF0 */
 	.dev = {
-		.platform_data = &msiof0_data,
+		.platform_data	= &msiof0_data,
+		.dma_mask	= &msiof0_dmamask,
 	},
 	.num_resources	= ARRAY_SIZE(msiof0_resources),
 	.resource	= msiof0_resources,
diff --git a/arch/sh/include/cpu-sh4/cpu/sh7724.h b/arch/sh/include/cpu-sh4/cpu/sh7724.h
index 7eb4359..774297f 100644
--- a/arch/sh/include/cpu-sh4/cpu/sh7724.h
+++ b/arch/sh/include/cpu-sh4/cpu/sh7724.h
@@ -301,6 +301,10 @@ enum {
 	SHDMA_SLAVE_SDHI0_RX,
 	SHDMA_SLAVE_SDHI1_TX,
 	SHDMA_SLAVE_SDHI1_RX,
+	SHDMA_SLAVE_MSIOF0_TX,
+	SHDMA_SLAVE_MSIOF0_RX,
+	SHDMA_SLAVE_MSIOF1_TX,
+	SHDMA_SLAVE_MSIOF1_RX,
 };
 
 extern struct clk sh7724_fsimcka_clk;
diff --git a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
index 0333fe9..f04fbb1 100644
--- a/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
+++ b/arch/sh/kernel/cpu/sh4a/setup-sh7724.c
@@ -112,6 +112,26 @@ static const struct sh_dmae_slave_config sh7724_dmae_slaves[] = {
 		.addr		= 0x04cf0030,
 		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_16BIT),
 		.mid_rid	= 0xca,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MSIOF0_TX,
+		.addr		= 0xa4c40050,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x51,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MSIOF0_RX,
+		.addr		= 0xa4c40060,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x52,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MSIOF1_TX,
+		.addr		= 0xa4c50050,
+		.chcr		= DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x55,
+	}, {
+		.slave_id	= SHDMA_SLAVE_MSIOF1_RX,
+		.addr		= 0xa4c50060,
+		.chcr		= DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL(XMIT_SZ_8BIT),
+		.mid_rid	= 0x56,
 	},
 };
 
-- 
1.7.2.3

