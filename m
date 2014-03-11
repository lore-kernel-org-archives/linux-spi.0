From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Date: Tue, 11 Mar 2014 18:57:41 +0100
Message-ID: <25839523.lJE8x4ql34@avalon>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org> <2274545.CyQ67zvVqo@avalon> <CAMuHMdXEOygh0--niiLcXFgnRNPi_b0EGPKVBg2Q6Ws01YmNjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXEOygh0--niiLcXFgnRNPi_b0EGPKVBg2Q6Ws01YmNjw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Geert,

On Tuesday 11 March 2014 18:44:21 Geert Uytterhoeven wrote:
> On Tue, Mar 11, 2014 at 5:32 PM, Laurent Pinchart wrote:
> > On Tuesday 11 March 2014 17:23:37 Geert Uytterhoeven wrote:
> >> On Tue, Mar 11, 2014 at 4:55 PM, Laurent Pinchart wrote:
> >> > Does this require drivers/sh/pm_runtime.c to be compiled in ?
> >> 
> >> Let's check...
> >> 
> >> My koelsch-legacy kernel has drivers/sh/pm_runtime.c compiled in.
> >> My koelsch-reference kernel hasn't.
> >> 
> >> However, under the -reference kernel many MSTP clocks (incl. MSIOF)
> >> seem to be enabled all the time, while under -legacy they are enabled and
> >> disabled on demand.
> > 
> > Is PM_RUNTIME enabled in both cases ?
> 
> Yes it is.
> 
> > There's something fishy in there that we should try to fix without too
> > further much delay. Ben Dooks has pointed out the problem a couple of
> > months ago, but the discussion on the mailing list just died.
> 
> Indeed. I'll look into it next week, unless someone beats me to it.
> 
> Note that I dropped Ben's patch to include drivers/sh, as I can't boot into
> userspace with it.

The patch also had the issue of not being compatible with multiplatform 
kernels, as it resulted in Renesas-specific code being executed for all 
platforms.

If you can find the old mail thread you can just reply to it (CC'ing me) and 
I'll make sure to refresh my memory and explain my concerns again.

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
