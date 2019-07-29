From: masonccyang@mxic.com.tw
Subject: Re: [PATCH v15 2/2] dt-bindings: spi: Document Renesas R-Car Gen3 RPC-IF
 controller bindings
Date: Mon, 29 Jul 2019 17:34:22 +0800
Message-ID: <OFFF9D8385.D8395BBD-ON48258446.0033FD62-48258446.00349608@mxic.com.tw>
References: <1564108975-27423-1-git-send-email-masonccyang@mxic.com.tw> <1564108975-27423-3-git-send-email-masonccyang@mxic.com.tw> <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: "Mark Brown" <broonie@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        "Simon Horman" <horms@verge.net.au>, juliensu@mxic.com.tw,
        "Lee Jones" <lee.jones@linaro.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "Linux-Renesas" <linux-renesas-soc@vger.kernel.org>,
        "linux-spi" <linux-spi@vger.kernel.org>,
        "Marek Vasut" <marek.vasut@gmail.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Miquel Raynal" <miquel.raynal@bootlin.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Sergei Shtylyov" <sergei.shtylyov@cogentembedded.com>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWVuQa1LLXPqrdSw6wdRzwQapAkk6Est=XrjESPF9zQwg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


Hi Geert,

 
> On Fri, Jul 26, 2019 at 4:19 AM Mason Yang <masonccyang@mxic.com.tw> 
wrote:
> > Dcument the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> 
> Document

Oops, sorry !

> 
> >
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/spi/spi-renesas-rpc.txt
> > @@ -0,0 +1,46 @@
> 
> [...]
> 
> > +- flash: should be represented by a subnode of the RPC-IF node,
> > +        which "compatible" property contains "jedec,spi-nor", it 
presents
> > +        SPI is used.
> 
> Sorry, I failed to parse the last subsentence.


Fix it to:
- flash: should be represented by a subnode of the RPC-IF node,
         its "compatible" property contains "jedec,spi-nor" presents
         SPI is used.

OK?

> 
> > +
> > +Example:
> > +
> > +       rpc: spi@ee200000 {
> > +               compatible = "renesas,r8a77995-rpc", 
"renesas,rcar-gen3-rpc";
> > +               reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 
0x4000000>,
> > +                     <0 0xee208000 0 0x100>;
> > +               reg-names = "regs", "dirmap", "wbuf";
> > +               clocks = <&cpg CPG_MOD 917>;
> > +               clock-names = "rpc";
> > +               power-domains = <&sysc R8A77995_PD_ALWAYS_ON>;
> > +               resets = <&cpg 917>;
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               flash@0 {
> > +                       compatible = "jedec,spi-nor";
> > +                       reg = <0>;
> > +                       spi-max-frequency = <40000000>;
> > +                       spi-tx-bus-width = <1>;
> > +                       spi-rx-bus-width = <1>;
> 
> Shouldn't those <1> be <4>, as this is QSPI?

okay, fix them to <4>


thanks for your time & review.

best regards,
Mason


CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information 
and/or personal data, which is protected by applicable laws. Please be 
reminded that duplication, disclosure, distribution, or use of this e-mail 
(and/or its attachments) or any part thereof is prohibited. If you receive 
this e-mail in error, please notify us immediately and delete this mail as 
well as its attachment(s) from your system. In addition, please be 
informed that collection, processing, and/or use of personal data is 
prohibited unless expressly permitted by personal data protection laws. 
Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================



============================================================================

CONFIDENTIALITY NOTE:

This e-mail and any attachments may contain confidential information and/or personal data, which is protected by applicable laws. Please be reminded that duplication, disclosure, distribution, or use of this e-mail (and/or its attachments) or any part thereof is prohibited. If you receive this e-mail in error, please notify us immediately and delete this mail as well as its attachment(s) from your system. In addition, please be informed that collection, processing, and/or use of personal data is prohibited unless expressly permitted by personal data protection laws. Thank you for your attention and cooperation.

Macronix International Co., Ltd.

=====================================================================
