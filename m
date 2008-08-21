From: Hendrik Sattler <post-azCMwr5LJFZ+Wm55xJeGF4QuADTiUCJX@public.gmane.org>
Subject: SD-over-SPI with shared SPI bus
Date: Thu, 21 Aug 2008 10:46:15 +0200
Message-ID: <20080821104615.7zxonbllsgg0gw0o@v1539.ncsrv.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
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

Hi,

I contact you because you are mentioned in the MAINTAINERS file of  
linux-2.6.26 for the mmc_spi drive and SPI subsystem.

I want to share the bus with other SPI devices. The drivers mentions  
pending updates that would allow that.
Are those available somewhere?

If not, the changes seem to fairly trivial: change SPI controller  
drivers to allow adding a spi_transfer to an spi_message during the  
complete() callback or add another callback that can do this.

Additionally, the current definition of a chipselect number seems not  
optimal. The pxa2xx driver even has it's own way to overcome this. The  
problem is that the method about activating a device might not be that  
sequentially numbered,
e.g. I have devices here that have a group chipselect with a  
subchipselect beside it.
I suggest to actually tell the owner of the spi_transfer and  
spi_message when a specific transfer starts and ends. The chipselect  
could still be handled by the spi controller driver but e.g. the  
subchipselect could be handled by the spi group device driver. Another  
use case would be devices that needs e.g. to be powered-up/-down.

Finally: is there a working SPI controller driver for the IXP46x out  
there? The register layout is mostly like the PX2xx driver the IXP46x  
doesn't have the DMA engine of the PXA2xx.

Thanks for your help.

HS

PS: For the list, please CC me as I am not subscribed.



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
