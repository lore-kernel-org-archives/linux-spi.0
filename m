From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: Question on AT91 SPI controller driver
	atmel_spi.c
Date: Tue, 29 Apr 2008 16:20:49 -0700
Message-ID: <200804291620.49767.david-b@pacbell.net>
References: <20080428124418.3068b73f@hskinnemo-gx620.norway.atmel.com>
	<895730900BBE6943B639D089EC50B11453F0DE@bodega.neuropace.com>
	<20080429104023.2dfa3130@hskinnemo-gx620.norway.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Janesh Ramakrishnan <jramakrishnan-WFYV2PrdoUdl57MIdRCFDg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Haavard Skinnemoen <haavard.skinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080429104023.2dfa3130-+1Ci8juu1zqWbxOaCEK3Pa14KzY7BuZjUIXZgC+OUhs@public.gmane.org>
Content-Disposition: inline
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

Patch should have the appended tweak.  Given that:

Acked-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


--- at91.orig/drivers/spi/atmel_spi.c	2008-04-29 16:19:44.000000000 -0700
+++ at91/drivers/spi/atmel_spi.c	2008-04-29 16:06:29.000000000 -0700
@@ -497,7 +497,7 @@ static int atmel_spi_setup(struct spi_de
 	struct atmel_spi	*as;
 	u32			scbr, csr;
 	unsigned int		bits = spi->bits_per_word;
-	unsigned long		bus_hz, sck_hz;
+	unsigned long		bus_hz;
 	unsigned int		npcs_pin;
 	int			ret;
 
@@ -598,10 +598,9 @@ static int atmel_spi_setup(struct spi_de
 		spin_unlock_irqrestore(&as->lock, flags);
 	}
 
-	sck_hz = bus_hz / scbr;
 	dev_dbg(&spi->dev,
 		"setup: %lu Hz bpw %u mode 0x%x -> csr%d %08x\n",
-		sck_hz, bits, spi->mode, spi->chip_select, csr);
+		bus_hz / scbr, bits, spi->mode, spi->chip_select, csr);
 
 	spi_writel(as, CSR0 + 4 * spi->chip_select, csr);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
