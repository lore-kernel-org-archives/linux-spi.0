From: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: add Intel Mid SSP driver
Date: Tue, 29 Oct 2013 12:38:10 -0700
Message-ID: <1383075490.12439.26.camel@joe-AO722>
References: <1383069950-27754-1-git-send-email-david.a.cohen@linux.intel.com>
	 <1383070766.12439.13.camel@joe-AO722> <526FFED4.4070902@linux.intel.com>
	 <1383071755.12439.17.camel@joe-AO722> <52700D4C.10008@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, ning.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Fei Yang <fei.yang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: David Cohen <david.a.cohen-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52700D4C.10008-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Tue, 2013-10-29 at 12:32 -0700, David Cohen wrote:
> On 10/29/2013 11:35 AM, Joe Perches wrote:
> > On Tue, 2013-10-29 at 11:30 -0700, David Cohen wrote:
> >> On 10/29/2013 11:19 AM, Joe Perches wrote:
> >>> On Tue, 2013-10-29 at 11:05 -0700, David Cohen wrote:
> >>>> This patch adds driver for ssp spi interface on Intel Mid platform.
> >>> A few simple notes:
> >>> Please consider using checkpatch.
> >> I did and got no warnings. But haven't used --strict option.
> > Interesting.  I thought there was a return (foo);
> > statement that should have been marked, but I didn't
> > actually run checkpatch.
> 
> It seems odd checkpatch didn't catch it. I'll investigate.

No need.  I believe I know why.
checkpatch doesn't use "$balanced_parens" checks for return
tests.  I'm not sure it's worth fixing right now, but it
could be tested as:

	if ($^V && $^V ge 5.10.0 &&
	    $stat =~ /^.\s*return\s*$balanced_parens\s*;\s*$/)

> > static inline u32 is_rx_fifo_empty(struct ssp_drv_context *sspc)
> > +{
> > +       return ((read_SSSR(sspc->ioaddr) & SSSR_RNE) == 0);
> > +}
> > This could be bool too
> u32 seems unusual, but I'd prefer 'int' if it's fine for you.

Anything is_<foo> that returns what seems to be true/false
I think could be bool.

But, no worries, it's your code.  Do what you think best.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
