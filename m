From: Maris <maris.rob-rHNaxI9ti4Y@public.gmane.org>
Subject: Proposal spi.h
Date: Wed, 10 Feb 2010 08:36:27 +0100
Message-ID: <op.u7wh21l67fwl0e@rob-desktop.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
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

* extend spi_device struct element 'mode' to u16 (currently u8, fully  
utilized as of 2.6.3x)
* chip_select to s16 (until now also u8)

Background:
Chip select size change: allow specification of SPI-device  
hardware-related spi control per device-specific (native) or gpio-based  
control.
mode size change: obligatory... A mode bit could also be assigned a  
selection bit: chip_select interpreted as native SSEL-index or as  
gpio-index (instead of negative value for chip_select).

Chip select differentiation bottom line: Naming of the device. I'm not  
sure how to establish this. spidev0.x are normally assigned for chip  
selects driven by the SPI peripheral hardware. GPIO-based: spidev0.gpioxx?

-Rob

------------------------------------------------------------------------------
SOLARIS 10 is the OS for Data Centers - provides features such as DTrace,
Predictive Self Healing and Award Winning ZFS. Get Solaris 10 NOW
http://p.sf.net/sfu/solaris-dev2dev
