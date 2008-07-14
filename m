From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: mmc over spi
Date: Mon, 14 Jul 2008 17:57:03 -0400
Message-ID: <487BCBAF.1050401@whoi.edu>
References: <E92FEE65D4904D408A9BBE380F7E5E01014FA801@kramer.tem.drs.master>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: "BRADWAY, Kevin" <kbradway-t/Sy+Gd0MBBBDgjK7y7TUQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <E92FEE65D4904D408A9BBE380F7E5E01014FA801-AIXvuindoPmK+Y0BBN2wtLxIJ9H7+gyA@public.gmane.org>
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

BRADWAY, Kevin wrote:
> I am trying to use the mmc over spi in the 2.6.24 distro on a pxa25XX.
> 
> I have read and read the blackfin and the git pages for the 2.6.24 add ins for this topic but I still can not seem to get it going.
> 
> I am using 
>        gpio6 for the clock
>        gpio12 for the CD
>        gpio8 for the CS

Those pins on a PXA2xx don't have anything to do with SPI.  I see that 6
and 8 have an MMC function, but I would guess that that is for some
native MMC capability, and not for MMC over SPI.

> questions:
>         Do I need the pxa2XX_spi driver to make this work?

The only pins that the pxa2xx_spi driver will operate with, are the SSP
ports.  These are GPIO 23-27 (SSP) and GPIO 81-84 (NSSP).

See Section 4.1.2 of the PXA255 developers manual for the various GPIO
pin functions.

-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08
