From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v12 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF MFD bindings
Date: Mon, 13 May 2019 09:11:19 +0200
Message-ID: <CAMuHMdUP8KU3Dbv6cwOvrY0hWOcm1xqVcsi20+GvazYMDLGGZg@mail.gmail.com>
References: <1556092536-17095-1-git-send-email-masonccyang@mxic.com.tw>
 <1556092536-17095-4-git-send-email-masonccyang@mxic.com.tw>
 <20190424212356.GA27103@bogus> <65853dc2-6f3c-1494-7e72-54877797cdd2@gmail.com>
 <20190507125730.GD29524@dell> <OF08A5650B.8AE8977C-ON482583F4.000E5B1E-482583F4.000F7215@mxic.com.tw>
 <d229b19e-351c-c576-b5c4-716d10dad1a0@gmail.com> <20190508061119.GB7627@dell>
 <OFE86674B9.06D723A0-ON482583F5.000AD50C-482583F5.000BA075@mxic.com.tw>
 <a05cff8f-7df2-1938-c0e7-f9366bece607@cogentembedded.com> <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Lee Jones <lee.jones@linaro.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>, zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFB19BCE91.6EBBAA77-ON482583F6.000234E2-482583F6.00061290@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Fri, May 10, 2019 at 3:09 AM <masonccyang@mxic.com.tw> wrote:
> > "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
> > 2019/05/10 上午 03:24
> > mark.rutland@arm.com, "Rob Herring" <robh@kernel.org>, zhengxunli@mxic.com.tw
> > On 05/09/2019 05:06 AM, masonccyang@mxic.com.tw wrote:
> >
> > [...]
> > >> > >> > On 4/24/19 11:23 PM, Rob Herring wrote:
> > >> > >> > > On Wed, Apr 24, 2019 at 03:55:36PM +0800, Mason Yang wrote:
> > >> > >> > >> Document the bindings used by the Renesas R-Car Gen3 RPC-IF MFD.
> > >> > >> > >>
> > >> > >> > >> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > >> > >> > >> ---
> > >> > >> > >>  .../devicetree/bindings/mfd/mfd-renesas-rpc.txt    | 40 ++++++
> > >> > >> ++++++++++++++++
> > >> > >> > >>  1 file changed, 40 insertions(+)
> > >> > >> > >>  create mode 100644 Documentation/devicetree/bindings/mfd/mfd-
> > >> > >> renesas-rpc.txt
> > >> > >> > >>
> > >> > >> > >> diff --git a/Documentation/devicetree/bindings/mfd/mfd-renesas-
> > >> > >> rpc.txt b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> > >> > >> > >> new file mode 100644
> > >> > >> > >> index 0000000..668b822
> > >> > >> > >> --- /dev/null
> > >> > >> > >> +++ b/Documentation/devicetree/bindings/mfd/mfd-renesas-rpc.txt
> > >> > >> > >> @@ -0,0 +1,40 @@
> > >> > >> > >> +Renesas R-Car Gen3 RPC-IF MFD Device Tree Bindings
> > >> > >> > >> +--------------------------------------------------
> > >> > >> > >
> > >> > >> > > Looks like a SPI flash controller from the example. What
> > makes it an
> > >> > >> > > MFD?
> > >> > >> >
> > >> > >> > It supports both SPI NOR and HyperFlash (CFI-compliant flash with
> > >> > >> > different bus interface).
> > >> > >>
> > >> > >> Looks like you're registering one OR the other.
> > >> > >>
> > >> > >> Why don't you just do this from DT?
> > >> > >>
> > >> > >> No reason for this to be an MFD IMHO.
> > >> > >
> > >> > >
> > >> > > okay, I will patch it back to SPI mode only.
> > >> >
> > >> > I don't think that's what Lee meant . The controller supports _both_
> > >> > modes , hence it would have the same compatible string. You just need to
> > >> > extract the mode of operation from the DT.
> > >>
> > >> HiSilicon attempted to upstream something similar, only their
> > >> controller provided NAND and NOR functionality.  They used different
> > >> compatible strings to differentiate between the varying
> > >> technologies.
> > >>
> > >> They too tried to use MFD as a means to select between them (which was
> > >> also NACKed).  Not sure what they ended up doing, but the original
> > >> submission and (half of) the conversation can be found at [0].  Some
> > >> more of the thread continues at [1].
> > >>
> > >> Hope that helps.
> > >>
> > >> [0] https://groups.google.com/forum/#!topic/fa.linux.kernel/F6i9o8sfOIw
> > >> [1] https://marc.info/?l=devicetree&m=147669165104431&w=2
> > >
> > >
> > > Hi Marek,
> > >
> > > By Jones's comments:
> > > --------------------------------------------------------------------------
> > >> From: Shunquan Lin <linshunquan1@hisilicon.com>
> > >>
> > >> This patch adds driver support for HiSilicon Flash Memory
> > >> Controller(FMC). HiSilicon FMC is a multi-functions device which
> > >> supports SPI Nor flash controller, SPI nand Flash controller and
> > >> parallel nand flash controller.
> > >
> > > MFDs are for devices which span multiple subsystems.
> >
> >    And we do! One of the subdrivers will live under drivers/spi/, the other
> > under drivers/mtd/...
> >
>
> From my point of view, I think Jones mean to MFD's subsystems are working simultaneously
> at the run-time, one period of time is working for sub-device-1 and later period of time
> is working for sub-device-2 and so on.
>
> But for RPC-IF, SPI or HF mode is decided at boot time by pins configure and later in kernel
> by dtb, RPC-IF can't switch SPI and HF mode at the run time.

> So far, Jones seems don't agree RPC-IF to MFD and then RPC MFD will not applied
> to mfd tree by him !

There's precedence for such constructs being an MFD: please see
drivers/mfd/at91-usart.c, which registers a single MFD cell for either
serial or SPI.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
