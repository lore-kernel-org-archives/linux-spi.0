From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: sh-msiof: per-transaction runtime PM
Date: Thu, 15 Mar 2012 17:45:30 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1203151740430.2988@axis700.grange>
References: <Pine.LNX.4.64.1203141828230.30291@axis700.grange>
	<CANqRtoQUm5PyVwe-PtQPP1DX+_tAh9ptbj9mSkx48+W4Yh9DiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CANqRtoQUm5PyVwe-PtQPP1DX+_tAh9ptbj9mSkx48+W4Yh9DiA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Magnus

On Thu, 15 Mar 2012, Magnus Damm wrote:

> On Thu, Mar 15, 2012 at 2:35 AM, Guennadi Liakhovetski
> <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > Currently the spi-sh-msiof driver implements a runtime PM scheme, based on
> > chipselect toggling. However, this is largely inefficient, since SPI
> > client drivers are allowed to keep the chipselect active for long periods
> > of time. This patch allows the driver to runtime-suspend the controller
> > between SPI transfers. While moving runtime-PM hooks this patch also
> > removes manual PM clock manipulation.
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > ---
> >
> > Marked as RFC, because I'm actually not sure, whether suspending after
> > each transfer is actually allowed. This seems to bring problems with
> > mmc-spi at least. Some commands return errors, but a retry recovers. More
> > investigation is required. Any hints concerning why this is not perfectly
> > functioning would be appreciated!
> 
> Hi Guennadi,
> 
> Thanks for your efforts. I believe that the error you are seeing with
> this patch applied is because the code has been updated to change the
> polarity of some shared SPI bus pins while CS is being asserted. This
> will result in potential spikes on the shared SPI bus pins which is
> far from perfect. =)

You're probably right:-) I forgot to mention, that the problem goes away 
if PM QoS is used, but we certainly cannot rely on it. As we further 
discussed in a chat, the problem can be relatively easily solved by 
postponing the CS activation until in the first transfer, but this only 
helps as long as the runtime PM doesn't power the domain down. Whereas, as 
discussed in my reply to Grant in this thread, if this happens, a 
different problem occurs, which anyway makes this approach much more 
problematic, that originally thought.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
