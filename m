From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v7 2/2] dt-bindings: spi: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Thu, 24 Jan 2019 10:06:56 +0100
Message-ID: <CAMuHMdUqprbwvO=VaoyY__nOoNhowEZ8A-i+Tb+2iBe8-p=_Hg@mail.gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-3-git-send-email-masonccyang@mxic.com.tw>
 <ba02ea43-83ce-7e3c-6910-73f2e78f51cf@gmail.com> <OFB904EE00.27B08F2C-ON4825838C.000D6846-4825838C.000E90F7@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Cc: Marek Vasut <marek.vasut@gmail.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
To: Mason Yang <masonccyang@mxic.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFB904EE00.27B08F2C-ON4825838C.000D6846-4825838C.000E90F7@mxic.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mason,

On Thu, Jan 24, 2019 at 3:39 AM <masonccyang@mxic.com.tw> wrote:
> > "Marek Vasut" <marek.vasut@gmail.com>
> > 2019/01/24 上午 09:54
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-renesas-
> > rpc.txt b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > new file mode 100644
> > > index 0000000..305bd10
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > > @@ -0,0 +1,46 @@
> > > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> > > +--------------------------------------------------------------------
> > > +
> > > +Required properties:
> > > +- compatible: should be an SoC-specific compatible value, followed by
> > > +      "renesas,rcar-gen3-rpc" as a fallback, i.e.,
> > > +      "renesas,r8a77995-rpc", "renesas,rcar-gen3-rpc".
> > > +      "renesas,r8a7795-rpc"   (R-Car H3)
> > > +      "renesas,r8a7796-rpc"   (R-Car M3-W)
> > > +      "renesas,r8a77965-rpc"   (R-Car M3-N)
> > > +      "renesas,r8a77970-rpc"   (R-Car V3M)
> > > +      "renesas,r8a77980-rpc"   (R-Car V3H)
> > > +      "renesas,r8a77990-rpc"   (R-Car E3)
> > > +      "renesas,r8a77995-rpc"   (R-Car D3)
> >
> > Was it tested on all of those SoCs and do we already handle all the
> > quirks of those ?
>
> These are R-Car Gen3 series and I list these by Geert's comments,
> or I misunderstand Geert's comments ?

I think you misunderstood. Typically we only list the SoC-specific
compatible values for SoCs that have been tested with the driver.
So for now I'd go with:

    - compatible: should be an SoC-specific compatible value, followed by
                  "renesas,rcar-gen3-rpc" as a fallback.
                  Supported SoC-specific values are:
                    - "renesas,r8a77995-rpc"   (R-Car D3)

The list can be extended when the driver has been tested/enhanced to
support more SoC types.

Does that sound OK?
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
