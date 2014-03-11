From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: sh-msiof: Convert to spi core auto_runtime_pm framework
Date: Tue, 11 Mar 2014 17:23:37 +0100
Message-ID: <CAMuHMdVOUuFsObEag_MwUT_jaqfOHMEcUScrkbaTEitmyJr+NQ@mail.gmail.com>
References: <1394531952-3905-1-git-send-email-geert@linux-m68k.org>
	<1394531952-3905-2-git-send-email-geert@linux-m68k.org>
	<1802214.NxZUiJcWLG@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1802214.NxZUiJcWLG@avalon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Laurent,

On Tue, Mar 11, 2014 at 4:55 PM, Laurent Pinchart
<laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org> wrote:
> Does this require drivers/sh/pm_runtime.c to be compiled in ?

Let's check...

My koelsch-legacy kernel has drivers/sh/pm_runtime.c compiled in.
My koelsch-reference kernel hasn't.

However, under the -reference kernel many MSTP clocks (incl. MSIOF)
seem to be enabled all the time, while under -legacy they are enabled and
disabled on demand.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
