From: Jan Andersson <jan-FkzTOoA/JUnLoDKTGw+V6w@public.gmane.org>
Subject: Re: [PATCH V3] spi: add support for aeroflex gaisler spimctrl
Date: Fri, 20 May 2011 09:26:19 +0200
Message-ID: <4DD6179B.60503@gaisler.se>
References: <1304169112-11224-1-git-send-email-jan@gaisler.com>
	<1304170705-11319-1-git-send-email-jan@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Daniel Hellstrom <daniel-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
To: grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1304170705-11319-1-git-send-email-jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 04/30/2011 03:38 PM, Jan Andersson wrote:
> This patch adds support for Aeroflex Gaisler SPI memory controller (SPIMCTRL).
> SPIMCTRL memory maps a SPI flash device into AMBA address space. The core
> also has a register interface where any command can be sent to the device.
> 
> The controller is typically found on LEON/GRLIB SoCs.
> 
> Tested on GR-LEON4-ITX development board.
> 
> Patch is against spi/next.
> 
> Signed-off-by: Jan Andersson <jan-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>

Hi Grant,

Any chance of you picking this one up?

Best regards,
  Jan

------------------------------------------------------------------------------
What Every C/C++ and Fortran developer Should Know!
Read this article and learn how Intel has extended the reach of its 
next-generation tools to help Windows* and Linux* C/C++ and Fortran 
developers boost performance applications - including clusters. 
http://p.sf.net/sfu/intel-dev2devmay
