From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 4/5] ARM: Ux500: Change SPI mode and remove unused fields
Date: Fri, 10 Sep 2010 09:19:38 -0700
Message-ID: <1284135579-13578-5-git-send-email-wellsk40@gmail.com>
References: <1284135579-13578-1-git-send-email-wellsk40@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org,
	srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org,
	tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1284135579-13578-1-git-send-email-wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>

Some of the fields in the pl022_chip_info structure used with
the amba pl022 driver are no longer used. This patch removes
those unused fields and changes the .mode flags in the
spi_board_info structure to setup the correct SPI mode.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-ux500/board-mop500.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/board-mop500.c b/arch/arm/mach-ux500/board-mop500.c
index 0e8fd13..219ae0c 100644
--- a/arch/arm/mach-ux500/board-mop500.c
+++ b/arch/arm/mach-ux500/board-mop500.c
@@ -55,19 +55,13 @@ static void ab4500_spi_cs_control(u32 command)
 }
 
 struct pl022_config_chip ab4500_chip_info = {
-	.lbm = LOOPBACK_DISABLED,
 	.com_mode = INTERRUPT_TRANSFER,
 	.iface = SSP_INTERFACE_MOTOROLA_SPI,
 	/* we can act as master only */
 	.hierarchy = SSP_MASTER,
 	.slave_tx_disable = 0,
-	.endian_rx = SSP_RX_MSB,
-	.endian_tx = SSP_TX_MSB,
-	.data_size = SSP_DATA_BITS_24,
 	.rx_lev_trig = SSP_RX_1_OR_MORE_ELEM,
 	.tx_lev_trig = SSP_TX_1_OR_MORE_EMPTY_LOC,
-	.clk_phase = SSP_CLK_SECOND_EDGE,
-	.clk_pol = SSP_CLK_POL_IDLE_HIGH,
 	.cs_control = ab4500_spi_cs_control,
 };
 
@@ -83,7 +77,7 @@ static struct spi_board_info u8500_spi_devices[] = {
 		.max_speed_hz = 12000000,
 		.bus_num = 0,
 		.chip_select = 0,
-		.mode = SPI_MODE_0,
+		.mode = SPI_MODE_3,
 		.irq = IRQ_DB8500_AB8500,
 	},
 };
-- 
1.7.2.2


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
