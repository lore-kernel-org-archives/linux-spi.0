From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/4] spi/dw_spi: improve the interrupt mode with the
	batch ops
Date: Fri, 18 Mar 2011 21:03:25 +0800
Message-ID: <20110318210325.02389634@feng-i7>
References: <1300434656-16870-1-git-send-email-feng.tang@intel.com>
	<1300434656-16870-5-git-send-email-feng.tang@intel.com>
	<20110318101310.57aa860f@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org" <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"Du, Alek" <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20110318101310.57aa860f-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Alan,

On Fri, 18 Mar 2011 18:13:10 +0800
Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:

> On Fri, 18 Mar 2011 15:50:56 +0800
> Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > spi/dw_spi: improve the interrupt mode with the batch ops
> 
> Look sane to me - only question I have is should the patches have a
> 
> From: Alek Du <...>
> 
> on them ?


I've strongly requested Alek to make the patches himself, but he is too busy
with his project and just give me a .35 version dw_spi.c. So to get it 
quickly upstream, I manually separate his change, modify a little, combined
with mine, test, add some comments and his Signed-off.

I really don't know the "From: " matters so much, and thought the signed-off
and the cover-letter already claim the right credit :). Is is possible
for Grant to change the "From: " to Alek when he would like to merge these
patches?

Thanks,
Feng


------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
