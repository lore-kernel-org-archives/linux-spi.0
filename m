From: wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Subject: [PATCH 2/5] ARM: LPC32XX: Add missing SPI mode and remove unused
	fields
Date: Fri, 10 Sep 2010 09:19:36 -0700
Message-ID: <1284135579-13578-3-git-send-email-wellsk40@gmail.com>
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
those unused fields and adds the missing .mode flags to the
spi_board_info structure.

Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 arch/arm/mach-lpc32xx/phy3250.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-lpc32xx/phy3250.c b/arch/arm/mach-lpc32xx/phy3250.c
index bc9a42d..0c936cf 100644
--- a/arch/arm/mach-lpc32xx/phy3250.c
+++ b/arch/arm/mach-lpc32xx/phy3250.c
@@ -172,18 +172,12 @@ static void phy3250_spi_cs_set(u32 control)
 }
 
 static struct pl022_config_chip spi0_chip_info = {
-	.lbm			= LOOPBACK_DISABLED,
 	.com_mode		= INTERRUPT_TRANSFER,
 	.iface			= SSP_INTERFACE_MOTOROLA_SPI,
 	.hierarchy		= SSP_MASTER,
 	.slave_tx_disable	= 0,
-	.endian_tx		= SSP_TX_LSB,
-	.endian_rx		= SSP_RX_LSB,
-	.data_size		= SSP_DATA_BITS_8,
 	.rx_lev_trig		= SSP_RX_4_OR_MORE_ELEM,
 	.tx_lev_trig		= SSP_TX_4_OR_MORE_EMPTY_LOC,
-	.clk_phase		= SSP_CLK_FIRST_EDGE,
-	.clk_pol		= SSP_CLK_POL_IDLE_LOW,
 	.ctrl_len		= SSP_BITS_8,
 	.wait_state		= SSP_MWIRE_WAIT_ZERO,
 	.duplex			= SSP_MICROWIRE_CHANNEL_FULL_DUPLEX,
@@ -239,6 +233,7 @@ static int __init phy3250_spi_board_register(void)
 			.max_speed_hz = 5000000,
 			.bus_num = 0,
 			.chip_select = 0,
+			.mode = SPI_MODE_0,
 			.platform_data = &eeprom,
 			.controller_data = &spi0_chip_info,
 		},
-- 
1.7.2.2


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
