From: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
Subject: [PATCH] SSP/SPI PL022 polarity terminology fix
Date: Sat, 15 Aug 2009 16:11:12 +0200
Message-ID: <1250345472-30932-1-git-send-email-linus.walleij@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: linux-arm-kernel-xIg/pKzrS19vn6HldHNs0ANdhmdF6hFW@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

The definition of the SPI clock phase for the Motorola mode of
the PL022 driver was incorrect: the spec had been interpreted as
data being recieved on rising or falling edge of the clocks while
the correct interpretation is that data can be recieved on the
first or second edge transition, falling or rising depending on
the polarity setting.

Signed-off-by: Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
----
This depends on the recent board data configuration for U300 being
applied first and I submit it to Russells patch tracker so that
it comes in through the ARM tree if there are not objections.
---
 arch/arm/mach-u300/spi.c   |    2 +-
 drivers/spi/amba-pl022.c   |    8 ++++----
 include/linux/amba/pl022.h |    8 ++++----
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm/mach-u300/spi.c b/arch/arm/mach-u300/spi.c
index a58c9ea..51cb950 100644
--- a/arch/arm/mach-u300/spi.c
+++ b/arch/arm/mach-u300/spi.c
@@ -48,7 +48,7 @@ struct pl022_config_chip dummy_chip_info = {
 	.data_size = SSP_DATA_BITS_8, /* used to be 12 in some default */
 	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
 	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
-	.clk_phase = SSP_CLK_FALLING_EDGE,
+	.clk_phase = SSP_CLK_SECOND_EDGE,
 	.clk_pol = SSP_CLK_POL_IDLE_LOW,
 	.ctrl_len = SSP_BITS_12,
 	.wait_state = SSP_MWIRE_WAIT_ZERO,
diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index da76797..35521af 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -534,7 +534,7 @@ static void restore_state(struct pl022 *pl022)
 	GEN_MASK_BITS(SSP_DATA_BITS_12, SSP_CR0_MASK_DSS, 0)	| \
 	GEN_MASK_BITS(SSP_MICROWIRE_CHANNEL_FULL_DUPLEX, SSP_CR0_MASK_HALFDUP, 5) | \
 	GEN_MASK_BITS(SSP_CLK_POL_IDLE_LOW, SSP_CR0_MASK_SPO, 6) | \
-	GEN_MASK_BITS(SSP_CLK_FALLING_EDGE, SSP_CR0_MASK_SPH, 7) | \
+	GEN_MASK_BITS(SSP_CLK_SECOND_EDGE, SSP_CR0_MASK_SPH, 7) | \
 	GEN_MASK_BITS(NMDK_SSP_DEFAULT_CLKRATE, SSP_CR0_MASK_SCR, 8) | \
 	GEN_MASK_BITS(SSP_BITS_8, SSP_CR0_MASK_CSS, 16)	| \
 	GEN_MASK_BITS(SSP_INTERFACE_MOTOROLA_SPI, SSP_CR0_MASK_FRF, 21) \
@@ -1249,8 +1249,8 @@ static int verify_controller_parameters(struct pl022 *pl022,
 		return -EINVAL;
 	}
 	if (chip_info->iface == SSP_INTERFACE_MOTOROLA_SPI) {
-		if ((chip_info->clk_phase != SSP_CLK_RISING_EDGE)
-		    && (chip_info->clk_phase != SSP_CLK_FALLING_EDGE)) {
+		if ((chip_info->clk_phase != SSP_CLK_FIRST_EDGE)
+		    && (chip_info->clk_phase != SSP_CLK_SECOND_EDGE)) {
 			dev_err(chip_info->dev,
 				"Clock Phase is configured incorrectly\n");
 			return -EINVAL;
@@ -1487,7 +1487,7 @@ static int pl022_setup(struct spi_device *spi)
 		chip_info->data_size = SSP_DATA_BITS_12;
 		chip_info->rx_lev_trig = SSP_RX_1_OR_MORE_ELEM;
 		chip_info->tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC;
-		chip_info->clk_phase = SSP_CLK_FALLING_EDGE;
+		chip_info->clk_phase = SSP_CLK_SECOND_EDGE;
 		chip_info->clk_pol = SSP_CLK_POL_IDLE_LOW;
 		chip_info->ctrl_len = SSP_BITS_8;
 		chip_info->wait_state = SSP_MWIRE_WAIT_ZERO;
diff --git a/include/linux/amba/pl022.h b/include/linux/amba/pl022.h
index dcad0ff..e4836c6 100644
--- a/include/linux/amba/pl022.h
+++ b/include/linux/amba/pl022.h
@@ -136,12 +136,12 @@ enum ssp_tx_level_trig {
 
 /**
  * enum SPI Clock Phase - clock phase (Motorola SPI interface only)
- * @SSP_CLK_RISING_EDGE: Receive data on rising edge
- * @SSP_CLK_FALLING_EDGE: Receive data on falling edge
+ * @SSP_CLK_FIRST_EDGE: Receive data on first edge transition (actual direction depends on polarity)
+ * @SSP_CLK_SECOND_EDGE: Receive data on second edge transition (actual direction depends on polarity)
  */
 enum ssp_spi_clk_phase {
-	SSP_CLK_RISING_EDGE,
-	SSP_CLK_FALLING_EDGE
+	SSP_CLK_FIRST_EDGE,
+	SSP_CLK_SECOND_EDGE
 };
 
 /**
-- 
1.6.2.1


------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
