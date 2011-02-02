From: Russ Gorby <russ.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011
Date: Wed,  2 Feb 2011 13:01:51 -0800
Message-ID: <1296680512-2758-1-git-send-email-russ.gorby__27997.7968348705$1296680353$gmane$org@intel.com>
References: <[PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> (maintainer:SPI
	SUBSYSTEM),
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> (maintainer:SPI SUBSYSTEM),
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uuRhgaa4a2kL@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <[PATCH 0/1] Adding intel_mid_ssp_spi driver : 01/27/2011>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello SPI maintainers,
I am sending a patch for the (new) intel_mid_ssp_spi driver for
consideration for inclusion in the Linux Kernel. This is a SPI master
controller driver that is being used for the intel MID platform (Medfield).
It uses the on-board Bulverde SSP controller configured for SPI (spibus #3)
running at 25Mhz.

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
