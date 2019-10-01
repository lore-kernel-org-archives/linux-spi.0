From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Date: Tue, 1 Oct 2019 16:51:02 +0200
Message-ID: <CAMuHMdXBfgC=x7H_mnLb_s0gMOBS7r9h8vqbiSU+168VKs9q1w@mail.gmail.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
 <20191001120203.GA28106@bogus> <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Gareth Williams <gareth.williams.jx@renesas.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Gareth,

On Tue, Oct 1, 2019 at 3:50 PM Gareth Williams
<gareth.williams.jx@renesas.com> wrote:
> On Tue, Oct 01, 2019 at 13:02:34AM +0100, Rob Herring wrote:
> > On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> > > Note in the bindings documentation that pclk should be renamed if a
> > > clock domain is used to enable the optional bus clock.
> > >
> > > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > > ---
> > > v2: Introduced this patch.
> > > ---
> > >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > index f54c8c3..3ed08ee 100644
> > > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > > @@ -16,7 +16,8 @@ Required properties:
> > >  Optional properties:
> > >  - clock-names : Contains the names of the clocks:
> > >      "ssi_clk", for the core clock used to generate the external SPI clock.
> > > -    "pclk", the interface clock, required for register access.
> > > +    "pclk", the interface clock, required for register access. If a clock domain
> > > +     used to enable this clock then it should be named "pclk_clkdomain".
> >
> > What's a clock domain?
> >
> > Unless this is a h/w difference in the IP block, then this change doesn't make
> > sense.
> This is a reference to the use of clock domains that are implemented through
> generic power domains. The domain is implemented in
> drivers/clk/renesas/r9a06g032-clocks.c and general details of clock domains
> can be found at
> https://elinux.org/images/1/14/Last_One_Out%2C_Turn_Off_The_Lights.pdf

Rob is right: the clock domain is an SoC integration detail, not specific to
the snps,dw-apb-ssi block.
Remember, DT describes hardware, not implementation details.

So the Linux snps,dw-apb-ssi driver should take care of it.

Which brings us back to an old discussion topic: power-domains properties
describe integration, and thus should be documented at a higher level than
in individual binding documents, just like e.g. interrupt-parent.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
