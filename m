From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Tue, 14 May 2019 12:07:54 +0200
Message-ID: <CAMuHMdVyfnO+wTHNrjjvJoqopC_xC0+sxSY+9a=pv-Wf=w6aCQ@mail.gmail.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
 <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
 <OFD932ABFC.E3FFCEB8-ON482583F9.003412B1-482583F9.0034D5CA@mxic.com.tw>
 <b51d1cb7-b3b5-208f-ab4c-145ecb57805d@cogentembedded.com> <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFAD9AA573.86373900-ON482583FA.0034781A-482583FA.0035B40C@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Tue, May 14, 2019 at 11:46 AM <masonccyang@mxic.com.tw> wrote:
> > >> There's precedence for such constructs being an MFD: please see
> > >> drivers/mfd/at91-usart.c, which registers a single MFD cell for
> > >           second for the direct mapping read mode and
> > >           third for the write buffer area.
> > >   - reg-names: should contain "regs", "dirmap" and "wbuf"
> > >   - clocks: should contain 1 entries for the module's clock
> > >   - clock-names: should contain "rpc"
> >
> >    I suspect we'd need the RPC/RPCD2 clocks mentioned as well (not sure
> yet)...
>
> Need it ?
> RPCD2 is derived from RPC and it's value is half of RPC,
> i.e., RPC = 160MHz, RPCD2 = 80 MHz

That hierarchy depends on the actual SoC, right?
AFAIU, both are derived from RPCSRC, and can be controlled individually
on some SoCs.

BTW, I still haven't seen a patch for drivers/clk/renesas/r8a77995-cpg-mssr.c
adding RPC-related clocks, so I have no idea what's the Linux view of the
hierarchy on your system.

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
