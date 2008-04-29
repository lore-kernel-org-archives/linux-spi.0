From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: Question on AT91 SPI controller driver
	atmel_spi.c
Date: Tue, 29 Apr 2008 10:40:23 +0200
Message-ID: <20080429104023.2dfa3130@hskinnemo-gx620.norway.atmel.com>
References: <20080428124418.3068b73f@hskinnemo-gx620.norway.atmel.com>
	<895730900BBE6943B639D089EC50B11453F0DE@bodega.neuropace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
To: "Janesh Ramakrishnan" <jramakrishnan-WFYV2PrdoUdl57MIdRCFDg@public.gmane.org>,
	David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <895730900BBE6943B639D089EC50B11453F0DE-ebt3Q5VmG/1zvADeOLLI2laTQe2KTcn/@public.gmane.org>
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

"Janesh Ramakrishnan" <jramakrishnan-WFYV2PrdoUdl57MIdRCFDg@public.gmane.org> wrote:
> Thanks for your insightful clarifications. They really helped. A bit of commenting in this part of the code might save others from bugging you like I did :) Just a suggestion. 

Yes, should probably do that...at least use the DIV_ROUND_UP() macro
since open-coding it makes the code look more cryptic than it really is.

The patch below should improve things, and fix a minor bug.

Haavard

=================[cut here]====================

>From 0c6a4d5c12f302b4a3a88c0a38fb34ad77309dc0 Mon Sep 17 00:00:00 2001
From: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Date: Tue, 29 Apr 2008 10:20:10 +0200
Subject: [PATCH] atmel_spi: Clean up baud rate divisor calculation

Make the baud rate divisor calculation code a bit more readable and
add a few comments.

Also fix wrong debug information being displayed when !new_1 and
max_speed_hz == 0.

Signed-off-by: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
---
 drivers/spi/atmel_spi.c |   26 +++++++++++++++++++-------
 1 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/atmel_spi.c b/drivers/spi/atmel_spi.c
index 02c8e30..91bfd5c 100644
--- a/drivers/spi/atmel_spi.c
+++ b/drivers/spi/atmel_spi.c
@@ -536,14 +536,25 @@ static int atmel_spi_setup(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	/* speed zero convention is used by some upper layers */
+	/*
+	 * Pre-new_1 chips start out at half the peripheral
+	 * bus speed.
+	 */
 	bus_hz = clk_get_rate(as->clk);
+	if (!as->new_1)
+		bus_hz /= 2;
+
 	if (spi->max_speed_hz) {
-		/* assume div32/fdiv/mbz == 0 */
-		if (!as->new_1)
-			bus_hz /= 2;
-		scbr = ((bus_hz + spi->max_speed_hz - 1)
-			/ spi->max_speed_hz);
+		/*
+		 * Calculate the lowest divider that satisfies the
+		 * constraint, assuming div32/fdiv/mbz == 0.
+		 */
+		scbr = DIV_ROUND_UP(bus_hz, spi->max_speed_hz);
+
+		/*
+		 * If the resulting divider doesn't fit into the
+		 * register bitfield, we can't satisfy the constraint.
+		 */
 		if (scbr >= (1 << SPI_SCBR_SIZE)) {
 			dev_dbg(&spi->dev,
 				"setup: %d Hz too slow, scbr %u; min %ld Hz\n",
@@ -551,8 +562,8 @@ static int atmel_spi_setup(struct spi_device *spi)
 			return -EINVAL;
 		}
 	} else
+		/* speed zero means "as slow as possible" */
 		scbr = 0xff;
-	sck_hz = bus_hz / scbr;
 
 	csr = SPI_BF(SCBR, scbr) | SPI_BF(BITS, bits - 8);
 	if (spi->mode & SPI_CPOL)
@@ -587,6 +598,7 @@ static int atmel_spi_setup(struct spi_device *spi)
 		spin_unlock_irqrestore(&as->lock, flags);
 	}
 
+	sck_hz = bus_hz / scbr;
 	dev_dbg(&spi->dev,
 		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
 		sck_hz, bits, spi->mode, spi->chip_select, csr);
-- 
1.5.4.3


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
