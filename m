From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
Date: Tue, 23 Apr 2019 09:29:02 +0200
Message-ID: <CAMuHMdX30QG6QzJt4c=Aq=4Jad4x7EZ1jwboXfBein20VBUpYg@mail.gmail.com>
References: <1553847606-18122-1-git-send-email-masonccyang@mxic.com.tw>
 <1553847606-18122-3-git-send-email-masonccyang@mxic.com.tw>
 <1e2bf23d-db39-0d1d-0bcc-6d9cd2935a82@cogentembedded.com> <cdee3d53-6ee3-4435-117e-8ba4a58ca72b@cogentembedded.com>
 <OF82CE76E9.E6395EF7-ON482583DD.000E37D7-482583DD.000E5077@mxic.com.tw>
 <3d334751-8fd4-7db1-9deb-e6c94936df13@cogentembedded.com> <OF4ABCC306.B053BA23-ON482583E0.000F480C-482583E0.000FAD4A@mxic.com.tw>
 <3971c669-9095-9d18-d029-37f9663a54b2@cogentembedded.com> <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF58AAFF49.C4593DEB-ON482583E1.001D551E-482583E1.001F089D@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, Apr 19, 2019 at 7:39 AM <masonccyang@mxic.com.tw> wrote:
> > Re: [PATCH v9 2/3] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller driver
> > On 04/18/2019 05:51 AM, masonccyang@mxic.com.tw wrote:
> > >>    Still hangs for me. After I patches spi-mem.c and the driver to
> > >> call RPM for the MFD, it started working again. Perhaps, that clock
> > >> is still enabled on your target. What does the following print (for
> > >> the RPC clocks)?
> > >>
> > >> $ mount none -t debugfs /sys/kernel/debug/
> > >> $ cat /sys/kernel/debug/clk/clk_summary
> > >>
> > >
> > > root@draak:/# cat /sys/kernel/debug/clk/clk_summary
> > >                                  enable  prepare  protect              duty
> > >    clock                          count    count    count
> > rate   accuracy phase  cycle
> > >
> > ---------------------------------------------------------------------------------------------
> > >  audio_clkout1                        0        0        0     11289600          0     0  50000
> > >  x19_clk                              0        0        0    24576000          0     0  50000
> > >  dclkin-0                             0        0        0        0          0     0  50000
> > >  scif                                 1        1        0        0          0     0  50000
> > >  audio_clkb                           0        0        0    22579200          0     0  50000
> > >  msiof-ref-clock                      0        0        0    66666666          0     0  50000
> > >  extal                                2        3        0    48000000          0     0  50000
> > >     r                                 0        2        0      31250          0     0  50000
> > >        rpc-if                         0        1        0      31250          0     0  50000
> >
> >    This looks wrong, the RPC-IF module clock should have RPC or
> > RPCD2 (where ae they?)
> > as a source, not RLCK...
>
> I check the Ch8 CPG of R-Car datasheet, figure 8.1f(R-Car D3),
> the RPC/RPCD2 is derived from PLL1 -> PLL1CK
>
> I didn't patch it and it should be exposed afrer the .sdsrc
>
>     .main                                 2            2    48000000          0 0
>        .pll3                              0            0   928000000          0 0
>        .pll1                              4            4  1600000000          0 0
>           lv1                             0            0  1600000000          0 0
>           lv0                             1            1  1600000000          0 0
>              lvds                         1            1  1600000000          0 0
>           cl                              0            0    33333333          0 0
>           zx                              0            0   533333333          0 0
>           zt                              0            0   400000000          0 0
>           ztr                             0            0   266666666          0 0
>           .sdsrc                          1            1   800000000          0 0
>              sd0                          1            1   200000000          0 0
>                 emmc0
> ---> here !

Upstream drivers/clk/renesas/r8a77995-cpg-mssr.c does not have the "rpc-if"
clock, and we have not yet seen the patch to add it that you must be using
to make your driver work.  If the clock is defined wrongly, that might
explain why your driver is working for you, but not for Sergei.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
