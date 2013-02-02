From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.8-rc6
Date: Sat, 2 Feb 2013 21:08:07 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1302022105410.9650@ayla.of.borg>
References: <alpine.DEB.2.00.1302022103360.9586@ayla.of.borg>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-sh@vger.kernel.org, spi-devel-general@lists.sourceforge.net
To: Linux Kernel Development <linux-kernel@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.00.1302022103360.9586@ayla.of.borg>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Sat, 2 Feb 2013, Geert Uytterhoeven wrote:
> JFYI, when comparing v3.8-rc6 to v3.8-rc5[3], the summaries are:
>   - build errors: +6/-6

Ignoring the ppc truncated relocations, there's only one regression:

  + error: spi-rspi.c: undefined reference to `shdma_chan_filter':  => .text+0xf1074)

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/5846/ (all 117 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/5828/ (all 117 configs)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
