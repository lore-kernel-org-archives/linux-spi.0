From: Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Subject: dw_spi CS control/transfer modes
Date: Fri, 18 Mar 2011 20:11:35 +0000
Message-ID: <20110318201135.GE3393@pulham.picochip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: george-ofzTHo7+kyPpQY4QmZNtDQ@public.gmane.org
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi,

I have a platform with a DesignWare SSI and I'm trying to use the dw_spi 
block using a GPIO for the chip select to workaround the problem of CS 
changing and the device losing state (we have a SPI flash attached), and 
I've found that using interrupt driven transfers, reading the SPI flash 
results in very few interrupts from the controller and a sluggish system 
(and no data from the flash).

However, I've found that removing the conditional transfer mode setting 
(effectively reverting commit 052dc7c45 [spi/dw_spi: conditional 
transfer mode changes]) allows everything to work fine by keeping the 
transfer mode to transmit+receive.

Does anyone have any ideas on the best way to fix this?  That code must 
have been added for a reason so perhaps it's just a quirk on our 
platform, but I'd be keen to know in what ways it's been tested before - 
afaict, no other in-tree platforms are using dw_spi with their own 
cs_control so it's difficult to know if perhaps these are all doing 
polled mode transfers.

Thanks,

Jamie

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
