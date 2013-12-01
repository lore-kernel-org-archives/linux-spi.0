From: takasi-y@ops.dti.ne.jp
Subject: [PATCH 11/11] ARM: shmobile: koelsch: spidev for r2a11302
Date: Mon,  2 Dec 2013 03:19:22 +0900
Message-ID: <1385921962-19843-11-git-send-email-takasi-y@ops.dti.ne.jp>
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

Add board info for r2a11302 on-board PMIC to access with spidev.

Signed-off-by: Takashi Yoshii <takasi-y@ops.dti.ne.jp>
---
 arch/arm/mach-shmobile/board-koelsch.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/mach-shmobile/board-koelsch.c b/arch/arm/mach-shmobile/board-koelsch.c
index b4add4c..5ff65ff 100644
--- a/arch/arm/mach-shmobile/board-koelsch.c
+++ b/arch/arm/mach-shmobile/board-koelsch.c
@@ -27,6 +27,7 @@
 #include <linux/pinctrl/machine.h>
 #include <linux/platform_data/gpio-rcar.h>
 #include <linux/platform_device.h>
+#include <linux/spi/spi.h>
 #include <mach/common.h>
 #include <mach/r8a7791.h>
 #include <mach/rcar-gen2.h>
@@ -79,6 +80,15 @@ static const struct gpio_keys_platform_data koelsch_keys_pdata __initconst = {
 	.nbuttons	= ARRAY_SIZE(gpio_buttons),
 };
 
+static const struct spi_board_info spi_bus[] __initconst = {
+	{
+		.modalias	= "spidev",
+		.max_speed_hz	= 6000000,
+		.mode		= SPI_MODE_3,
+		.bus_num	= 1,
+	},
+};
+
 static const struct pinctrl_map koelsch_pinctrl_map[] = {
 	/* SCIF0 (CN19: DEBUG SERIAL0) */
 	PIN_MAP_MUX_GROUP_DEFAULT("sh-sci.6", "pfc-r8a7791",
@@ -110,6 +120,7 @@ static void __init koelsch_add_standard_devices(void)
 	platform_device_register_data(&platform_bus, "gpio-keys", -1,
 				      &koelsch_keys_pdata,
 				      sizeof(koelsch_keys_pdata));
+	spi_register_board_info(spi_bus, ARRAY_SIZE(spi_bus));
 }
 
 static const char * const koelsch_boards_compat_dt[] __initconst = {
-- 
1.7.9.5

