From: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Subject: [PATCH 08/11] ARM: shmobile: r8a7791: Add MSIOF clocks
Date: Mon,  2 Dec 2013 03:19:19 +0900
Message-ID: <1385921962-19843-8-git-send-email-takasi-y@ops.dti.ne.jp>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
Cc: Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1385921962-19843-1-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

From: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>

Add clocks for MSIOF0,1,2,
and DEV_ID spi_sh_msiof.1,2,3 for platform devices.
(numberd 1-based for the compatibility with BSP)

Signed-off-by: Takashi Yoshii <takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
---
 arch/arm/mach-shmobile/clock-r8a7791.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index ff2d60d..0530f3a 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -125,9 +125,10 @@ enum {
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
 	MSTP522,
-	MSTP216, MSTP207, MSTP206,
+	MSTP216, MSTP208, MSTP207, MSTP206, MSTP205,
 	MSTP204, MSTP203, MSTP202, MSTP1105, MSTP1106, MSTP1107,
 	MSTP124,
+	MSTP000,
 	MSTP_NR
 };
 
@@ -143,8 +144,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP714] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 14, 0), /* SCIF5 */
 	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
 	[MSTP216] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 16, 0), /* SCIFB2 */
+	[MSTP208] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 8, 0), /* MSIOF1 */
 	[MSTP207] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 7, 0), /* SCIFB1 */
 	[MSTP206] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 6, 0), /* SCIFB0 */
+	[MSTP205] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 5, 0), /* MSIOF2 */
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
@@ -152,6 +155,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP1106] = SH_CLK_MSTP32(&mp_clk, SMSTPCR11, 6, 0), /* SCIFA4 */
 	[MSTP1107] = SH_CLK_MSTP32(&mp_clk, SMSTPCR11, 7, 0), /* SCIFA5 */
 	[MSTP124] = SH_CLK_MSTP32(&rclk_clk, SMSTPCR1, 24, 0), /* CMT0 */
+	[MSTP000] = SH_CLK_MSTP32(&mp_clk, SMSTPCR0, 0, 0), /* MSIOF0 */
 };
 
 static struct clk_lookup lookups[] = {
@@ -192,6 +196,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("spi_sh_msiof.1", &mstp_clks[MSTP000]),
+	CLKDEV_DEV_ID("spi_sh_msiof.2", &mstp_clks[MSTP208]),
+	CLKDEV_DEV_ID("spi_sh_msiof.3", &mstp_clks[MSTP205]),
 };
 
 #define R8A7791_CLOCK_ROOT(e, m, p0, p1, p30, p31)		\
-- 
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
