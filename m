From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/4] avr32: Reduce DataFlash bus speed
	to 8 MHz on ATNGW100
Date: Fri,  1 Aug 2008 17:17:13 +0200
Message-ID: <1217603836-21243-1-git-send-email-haavard.skinnemoen@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>,
	kernel-o2ulR9ObcgE/ohRxsw7f2g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Doing this in combination with "atmel_spi: fix hang due to missed
interrupt" appears to eliminate the overruns I'm seeing when using
JFFS2-on-DataFlash as /usr filesystem on the ATNGW100.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
The "atmel" releases have been running the DataFlash at 8 MHz for a
while, so this brings mainline in sync with them.

I think the only way to increase the bus speed beyond this is to use
faster RAM. I'll look into using SRAM bounce buffers next.

I'll apply this patch to my avr32 tree. David, I'll let you decide
whether the other three patches are important/safe enough for 2.6.27.
I've verified that they don't break DataFlash on ATNGW100, but they
could use some testing on other setups, in particular AT91RM9200 and
other AT91 chips.

 arch/avr32/boards/atngw100/setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/avr32/boards/atngw100/setup.c b/arch/avr32/boards/atngw100/setup.c
index c7fe94d..12b21ac 100644
--- a/arch/avr32/boards/atngw100/setup.c
+++ b/arch/avr32/boards/atngw100/setup.c
@@ -47,7 +47,7 @@ static struct eth_platform_data __initdata eth_data[2];
 static struct spi_board_info spi0_board_info[] __initdata = {
 	{
 		.modalias	= "mtd_dataflash",
-		.max_speed_hz	= 10000000,
+		.max_speed_hz	= 8000000,
 		.chip_select	= 0,
 	},
 };
-- 
1.5.6.3


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
