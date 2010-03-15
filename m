From: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Purpose of the "msg->status"
Date: Mon, 15 Mar 2010 22:53:13 +0900
Message-ID: <1b68c6791003150653g6f58fbd7u4c0077f01605610d@mail.gmail.com>
References: <2A84145621092446B6659B8A0F28E26F4245B483E9@irsmsx501.ger.corp.intel.com>
	<20100315110553.GC11196@jasper.tkos.co.il>
	<2A84145621092446B6659B8A0F28E26F4245B4844E@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: "Centelles, Sylvain" <sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <2A84145621092446B6659B8A0F28E26F4245B4844E-IGOiFh9zz4x9qrmMLTLiibfspsVTdybXVpNB7YpNyf8@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Mar 15, 2010 at 10:06 PM, Centelles, Sylvain
<sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi Baruch,
> Thx for your fast answer.
> I had seen this piece of code. But if this is the only purpose of the msg->status, then it means it's only used to give return status of the transfer after the completion.
> That mean that the only possible value will be an error code or success. The EINPROGRESS (used in the pxa2xx_spi.c for example) will never have a chance to be returned at this place, as any completion will overwrite it. Right?
> That what was confusing me...
When a xfer is submitted, the status is set by default should the xfer
exit via some un-tested path.
If the driver state machine has only fixed and tested exit points, you
perhaps don't need to set
the default status.

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
