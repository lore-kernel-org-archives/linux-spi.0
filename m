From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 09/12] [v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for
 QSPI
Date: Thu, 7 Aug 2014 09:39:08 +0900
Message-ID: <20140807003908.GA30872@verge.net.au>
References: <1407329949-5695-1-git-send-email-geert+renesas@glider.be>
 <1407329949-5695-10-git-send-email-geert+renesas@glider.be>
 <20140807003755.GF32652@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-spi@vger.kernel.org, linux-sh@vger.kernel.org,
	dmaengine@vger.kernel.org, devicetree@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140807003755.GF32652@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 07, 2014 at 09:37:56AM +0900, Simon Horman wrote:
> On Wed, Aug 06, 2014 at 02:59:06PM +0200, Geert Uytterhoeven wrote:
> > Add a DMA property to the QSPI node
> > 
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > Cc: devicetree@vger.kernel.org
> > ---
> > This depends on "[PATCH v2 8/8] ARM: shmobile: r8a7791: Add DMAC devices
> > to DT" of series "[PATCH v2 0/8] R-Car Gen2 DMA Controller driver".
> 
> Hi Geert, Hi Laurent,
> 
> Am I correct in assuming that with this patch applied things
> will continue to work the old way until the patch above applied
> to the same tree and from there on the user will get the new behaviour?
> 
> If so I think that I can take this patch as although the driver hasn't been
> merged the relevant bindings were added to the subsystem maintainers tree
> by "dmaengine: rcar-dmac: Add device tree bindings documentation" and are
> available in linux-next.
> 
> Likewise for "[v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIO".

... and "ARM: shmobile: r8a7790 dtsi: Enable DMA for QSPI"

> > v2:
> >   - Update DMA specifiers to match the renesas,rcar-dmac bindings,
> > v2:
> >   - QSPI needs to use 8-bit accesses for DMA, not 32-bit,
> >   - Reorder: TX first, RX second.
> > ---
> >  arch/arm/boot/dts/r8a7791.dtsi | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/r8a7791.dtsi b/arch/arm/boot/dts/r8a7791.dtsi
> > index d59af615e365..8186c9f4a18a 100644
> > --- a/arch/arm/boot/dts/r8a7791.dtsi
> > +++ b/arch/arm/boot/dts/r8a7791.dtsi
> > @@ -1044,6 +1044,8 @@
> >  		reg = <0 0xe6b10000 0 0x2c>;
> >  		interrupts = <0 184 IRQ_TYPE_LEVEL_HIGH>;
> >  		clocks = <&mstp9_clks R8A7791_CLK_QSPI_MOD>;
> > +		dmas = <&dmac0 0x17>, <&dmac0 0x18>;
> > +		dma-names = "tx", "rx";
> >  		num-cs = <1>;
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > -- 
> > 1.9.1
> > 
