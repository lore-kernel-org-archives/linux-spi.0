From: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: GPIO chip select support in McSPI
Date: Sun, 13 Mar 2011 15:04:11 -0400
Message-ID: <87ipvmx2ok.fsf__17362.0535912507$1300043112$gmane$org@gmail.com>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
	<1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
	<20110302215026.GA22854@angua.secretlab.ca>
	<87sjv517yd.fsf@gmail.com>
	<f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <f7a269db-3bcf-4bac-8c38-b363e5c7bd0b-2ueSQiBKiTY7tOexoI0I+QC/G2K4zDHf@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

I've included the OMAP list so that I can hopefully get some feedback
from folks more familiar with this code.

Background:

I've been working on adding support for GPIO chip select lines to the
McSPI driver. Grant has been working with me to try getting the
in-kernel interface right and we have finally converged on a solution
whereby a table of GPIO lines will be passed to the McSPI driver through
platform_device.device.platform_data. Unfortunately, as explained below,
there is no clear path to support this in the current McSPI
initialization code.


On Thu, 03 Mar 2011 14:42:07 -0700, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> The spi_master platform device is registered somewhere in the
> inappropriate support code. You need to arrange to make sure the
> correct pdata is attached to it when it gets registered. There
> /should/ be a mechanism for doing so.
> 
> All spi devices already specify a cs number anyway. What you can do is
> use the cs number as the lookup index into the gpio table, and
> remember to reserve a cs# for the 'native' cs line.
> 
I've done as you suggested and added support to the McSPI driver by
passing a GPIO table through platform_data. A patch will be coming
shortly.

Unfortunately, I'm really not sure how to restructure the OMAP code to
pass this information along. Currently the McSPI devices are registered
in arch/arm/mach-omap2/devices.c (omap_init_mcspi). In order to make the
GPIO CS support configurable by board code, we need some way to change
the (currently static) platform_devices prior to registration. Does
anyone have any suggestions on how this code could be refactored to
allow for this with minimal code duplication? Obviously we could just
move the platform_devices into the board files but this seems like a lot
of code duplication to support functionality that few boards will use.

Thoughts?

- Ben

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
