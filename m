From: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Date: Wed, 12 Mar 2014 12:26:24 +0100
Message-ID: <1972290.yxP8Fj4BuZ@avalon>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org> <2274545.CyQ67zvVqo@avalon> <CANqRtoRR9Q8Q=ACqhnLBpTavn0K5cD1=dBkjkfZ8kb+H68GuOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CANqRtoRR9Q8Q=ACqhnLBpTavn0K5cD1=dBkjkfZ8kb+H68GuOw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Magnus,

On Wednesday 12 March 2014 10:23:48 Magnus Damm wrote:
> On Wed, Mar 12, 2014 at 1:32 AM, Laurent Pinchart wrote:
> > On Tuesday 11 March 2014 17:23:37 Geert Uytterhoeven wrote:
> >> Hi Laurent,
> >> 
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
> > 
> > There's something fishy in there that we should try to fix without too
> > further much delay. Ben Dooks has pointed out the problem a couple of
> > months ago, but the discussion on the mailing list just died.
> 
> Yes, Runtime PM is not working as expected in the multiplatform case,
> that is true. I propose that we keep Runtime PM disabled in the
> Kconfig for R-Car Gen2 for now to keep things simple.

Isn't it ? I thought it was only broken with regard to clocks, but I might be 
missing something.

> From my side I see it as two separate solutions. The short term fix is
> to temporarily work around drivers that depend on Runtime PM for clock
> control, I propose enabling selected clocks statically using the
> function introduced by this series:
> 
> [PATCH 00/03] ARM: shmobile: Break out and extend clock workaround
> http://www.spinics.net/lists/arm-kernel/msg310278.html
> 
> The long term fix I'm not sure sure about, but I trust Geert to figure
> it out. =)
> 
> Regardless, rushing to fix this "correctly" seems as useful to me as
> dead line driven DT development....

-- 
Regards,

Laurent Pinchart

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
