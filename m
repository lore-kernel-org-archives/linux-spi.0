From: Russ Gorby <russ.gorby-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 0/1] ifx6x60 expanded platform data patch: 01/26/2011
Date: Wed,  2 Feb 2011 12:56:57 -0800
Message-ID: <1296680218-2693-1-git-send-email-russ.gorby__28908.6043173031$1296680054$gmane$org@intel.com>
References: <[PATCH 0/1] ifx6x60 expanded platform data patch: 01/26/2011>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org> (maintainer:SPI
	SUBSYSTEM),
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> (maintainer:SPI SUBSYSTEM),
	Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <[PATCH 0/1] ifx6x60 expanded platform data patch: 01/26/2011>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hello all,
I am sending a patch for the ifx6x60 driver to expand the
information available via the platform data structure.
I'd like these to be considred for inclusion into the Linux Kernel.

Additional patches will follow that will depend on these changes
so I'd like to iron these  out first.

Patches were made against the repo:
http://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
as of 01/26/2011

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
