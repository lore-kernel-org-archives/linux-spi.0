From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: GPIO chip select support in McSPI
Date: Mon, 14 Mar 2011 21:29:51 -0600
Message-ID: <20110315032951.GA5600__20225.9064688862$1300163427$gmane$org@angua.secretlab.ca>
References: <c0ffcf4415b8edbf55d653a620b92fbbbcd8fed7>
	<1297635034-24504-1-git-send-email-bgamari.foss@gmail.com>
	<20110302215026.GA22854@angua.secretlab.ca>
	<87sjv517yd.fsf@gmail.com>
	<f7a269db-3bcf-4bac-8c38-b363e5c7bd0b@email.android.com>
	<87ipvmx2ok.fsf@gmail.com>
	<20110314192536.GF16096@angua.secretlab.ca>
	<877hc1t95k.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-TtF/mJH4Jtrk1uMJSBkQmQ@public.gmane.org, linux-omap <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <877hc1t95k.fsf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 14, 2011 at 10:22:31PM -0400, Ben Gamari wrote:
> On Mon, 14 Mar 2011 13:25:36 -0600, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> > I see two solutions:
> > 1) platform code registers a bus notifier so that it gets called back
> > before the device gets bound to a driver.  Then it can augment the
> > platform data.
> > 
> This sounds like it might be a bit involved and I'm not terribly
> familiar with these facets of the driver model. This would probably be
> the more flexible approach but I think I'll stick with the simpler
> option.
> 
> > 2) add an api to arch/arm/mach-omap2/devices.c for providing a cs
> > table before the device gets registered (must be called before
> > arch_initcall() time).
> > 
> This is along the lines of what I was thinking. Any thoughts on how to
> get function called before arch_initcall()?

You can call it from .init_machine()

g.

> 
> - Ben

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
