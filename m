From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 13/15] ARM: shmobile: lager legacy: Switch QSPI to named IRQs
Date: Fri, 24 Jan 2014 13:49:49 +0100
Message-ID: <1390567791-8988-14-git-send-email-geert@linux-m68k.org>
References: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Cc: linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@linux-m68k.org>
To: Simon Horman <horms@verge.net.au>,
	Magnus Damm <magnus.damm@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1390567791-8988-1-git-send-email-geert@linux-m68k.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
---
 arch/arm/mach-shmobile/board-lager.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-lager.c b/arch/arm/mach-shmobile/board-lager.c
index 8dde4462f600..4977a4b9fa2c 100644
--- a/arch/arm/mach-shmobile/board-lager.c
+++ b/arch/arm/mach-shmobile/board-lager.c
@@ -290,7 +290,7 @@ static const struct spi_board_info spi_info[] __initconst = {
 /* QSPI resource */
 static const struct resource qspi_resources[] __initconst = {
 	DEFINE_RES_MEM(0xe6b10000, 0x1000),
-	DEFINE_RES_IRQ(gic_spi(184)),
+	DEFINE_RES_IRQ(gic_spi(184), "mux"),
 };
 
 /* VIN */
-- 
1.7.9.5
