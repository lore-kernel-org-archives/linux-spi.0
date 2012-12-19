From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: tegra: sequence compatible strings as per preference
Date: Wed, 19 Dec 2012 17:00:09 +0000
Message-ID: <20121219170009.54EE83E0C34@localhost>
References: <1352452052-13823-1-git-send-email-ldewangan@nvidia.com>
	<509D37B8.8020606@wwwdotorg.org>
	<20121109171008.GX23807@opensource.wolfsonmicro.com>
	<509D3D46.7060102@wwwdotorg.org>
	<20121110170741.GA17689@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>,
	Laxman Dewangan <ldewangan-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>,
	Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121110170741.GA17689-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 10 Nov 2012 18:07:42 +0100, Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> On Fri, Nov 09, 2012 at 10:28:38AM -0700, Stephen Warren wrote:
> > On 11/09/2012 10:10 AM, Mark Brown wrote:
> > > On Fri, Nov 09, 2012 at 10:04:56AM -0700, Stephen Warren wrote:
> > > 
> > >> However just FYI, it should not be necessary for correctness; The
> > >> DT matching order is supposed to be driven purely by the order of
> > >> the compatible values in the DT now, and not affected by the
> > >> order of values in the table. (This wasn't always the case, but
> > >> was a bug that was fixed IIRC by Thierry Reding).
> > > 
> > > I guess the driver is being used backported in older kernels which
> > > don't have that fix?
> > 
> > That sounds likely. Laxman, it'd be a good idea to track down the fix
> > to the DT matching code and backport it, so that hard-to debug issues
> > aren't caused by the lack of that patch!
> 
> Unfortunately the patch that was supposed to fixed this caused a
> regression and was therefore reverted. Rob (Cc'ed) said there was a
> patch to fix it properly and was supposed to go into 3.6 but it seems
> that never happened. Rob, what's the status on this?
> 
> The revert is here: bc51b0c22cebf5c311a6f1895fcca9f78efd0478

Rob, ping on this. I think we talked about it on IRC, but I cannot
remember what was said.... I must be getting old.

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
