From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2 3/4] spi/dw_spi: change poll mode transfer from byte
	ops to batch ops
Date: Mon, 25 Apr 2011 15:46:07 +0800
Message-ID: <20110425154607.7e0d6b68@feng-i7>
References: <1301497795-6924-1-git-send-email-feng.tang@intel.com>
	<1301497795-6924-4-git-send-email-feng.tang@intel.com>
	<20110331105448.0f6d0bd4@bob.linux.org.uk>
	<AANLkTi=-VFJdmD_3duov=qGUecPBzmr8HhaatDGUY1=S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	kristen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, "Du, Alek" <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTi=-VFJdmD_3duov=qGUecPBzmr8HhaatDGUY1=S@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

On Thu, 31 Mar 2011 21:13:05 +0800
Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:

> On Thu, Mar 31, 2011 at 3:54 AM, Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> wrote:
> > On Wed, 30 Mar 2011 23:09:54 +0800
> > Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> >
> >> From: Alek Du <alek.du-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> >>
> >> Current poll transfer will read/write one word, then wait till the
> >> hw is non-busy, it's not efficient. This patch will try to
> >> read/write as many words as permitted by hardware FIFO depth.
> >
> > This is reported to cause a regression on internal testing. It's
> > one of that set of changes which seems to be breaking the
> > touchscreen.
> >
> > Should we get that resolved before these go upstream ?
> 
> If this has a known/suspected regression, then I would say yes.  I've
> got it queued for 2.6.40, but I can easily drop it.

I did some investigation about the regression, it's about a spi touch
screen, which needs some delay between every word of read/write, it works
with old dw_spi driver, whose basic PIO working model is waiting till hw
is not busy for every word operation.

With this optimization, the dw spi driver will try to feed the FIFO as
much as possible. If we enforce the delay in that touch screen driver,
it works again.

So I would say, this patch should be ok to get merged.

Thanks,
Feng

> 
> g.

------------------------------------------------------------------------------
Fulfilling the Lean Software Promise
Lean software platforms are now widely adopted and the benefits have been 
demonstrated beyond question. Learn why your peers are replacing JEE 
containers with lightweight application servers - and what you can gain 
from the move. http://p.sf.net/sfu/vmware-sfemails
