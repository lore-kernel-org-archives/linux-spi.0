From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v13 3/3] dt-bindings: mfd: Document Renesas R-Car Gen3
 RPC-IF controller bindings
Date: Mon, 3 Jun 2019 14:04:28 +0100
Message-ID: <20190603130428.GX4797@dell>
References: <1558423174-10748-1-git-send-email-masonccyang@mxic.com.tw>
 <1558423174-10748-4-git-send-email-masonccyang@mxic.com.tw>
 <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mason Yang <masonccyang@mxic.com.tw>, broonie@kernel.org,
        marek.vasut@gmail.com, linux-kernel@vger.kernel.org,
        linux-spi@vger.kernel.org, bbrezillon@kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, juliensu@mxic.com.tw,
        Simon Horman <horms@verge.net.au>, miquel.raynal@bootlin.com
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <0e2994d6-6efc-9f36-f681-609199f20b9f@cogentembedded.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 22 May 2019, Sergei Shtylyov wrote:

> On 05/21/2019 10:19 AM, Mason Yang wrote:
> 
> > Document the bindings used by the Renesas R-Car Gen3 RPC-IF controller.
> > 
> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
> > ---
> >  .../devicetree/bindings/mfd/renesas-rpc-if.txt     | 65 ++++++++++++++++++++++
> >  1 file changed, 65 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > new file mode 100644
> > index 0000000..20ec85b
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/mfd/renesas-rpc-if.txt
> > @@ -0,0 +1,65 @@
> > +Renesas R-Car Gen3 RPC-IF controller Device Tree Bindings
> > +---------------------------------------------------------
> > +
> > +RPC-IF supports both SPI NOR and HyperFlash (CFI-compliant flash)
> > +
> > +Required properties:
> > +- compatible: should be an SoC-specific compatible value, followed by
> > +		"renesas,rcar-gen3-rpc" as a fallback.
> > +		supported SoC-specific values are:
> > +		"renesas,r8a77995-rpc"	(R-Car D3)
> > +- reg: should contain three register areas:
> > +	first for RPC-IF registers,
> > +	second for the direct mapping read mode and
> > +	third for the write buffer area.
> > +- reg-names: should contain "regs", "dirmap" and "wbuf"
> > +- clocks: should contain 1 entries for the module's clock
> > +- clock-names: should contain "rpc"
> > +- power-domains: should contain system-controller(sysc) for power-domain-cell
> > +- resets: should contain clock pulse generator(cpg) for reset-cell,
> > +	  power-domain-cell and clock-cell
> 
>    That's just some nonsense, sorry...
>    I suggest that you stop reposting your patches as I'm going to post
> my version of this patchset RSN (based on your patches, of course) and I'm
> going to take care of fixing this file as well.

Why is this necessary?

Why not just provide some constructive feedback instead?

> > +- #address-cells: should be 1
> > +- #size-cells: should be 0
> [...]
> 
> MBR, Sergei

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
