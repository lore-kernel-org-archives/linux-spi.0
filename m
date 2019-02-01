From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Date: Fri, 1 Feb 2019 08:57:39 +0100
Message-ID: <20190201085739.775add3f@bbrezillon>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-11-tudor.ambarus@microchip.com>
        <20190131173207.56481a42@bbrezillon>
        <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <947f148d-3fd8-4e7d-4301-9d67715fbf7d@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, 1 Feb 2019 07:07:40 +0000
<Tudor.Ambarus@microchip.com> wrote:

> >   
> >>  #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >>  #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >>  #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)  
> > 
> > Looks like the read/write flag is on bit 13. Can we just add  
> 
> for sama5d2 only

Feel free to prefix macros with the SoC name to make it clear:

#define QSPI_IFR_SAMA5D2_WRITE_TRSFR		BIT(13)

> 
> > 
> > #define QSPI_IFR_TFRTYP_TRSFR_WRITE	BIT(13)
> > 
> > and drop all others def? This way the implementation is consistent
> > between sam9x60 and sama5d2.  
> 
> BIT(13) has no meaning for sam9x60. I can drop the macros with zero value for
> sama5d2 in a separate patch.
> >   
> >> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)

And this one would be

define QSPI_IFR_SAM9X60_READ_TRSFR		BIT(24)

> >>  
> >>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
> >>  #define QSPI_SMR_SCREN                  BIT(0)
> >> @@ -137,16 +144,37 @@
> >>  #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
> >>  
> >>  
> >> +/* Describes register values. */
> >> +struct atmel_qspi_cfg {
> >> +	u32 icr;
> >> +	u32 iar;
> >> +	u32 ifr;
> >> +};
> >> +
> >> +struct atmel_qspi_caps;
> >> +
> >>  struct atmel_qspi {
> >>  	void __iomem		*regs;
> >>  	void __iomem		*mem;
> >>  	struct clk		*clk;  
> > 
> > Can we rename that on pclk?  
> 
> will rename it, together with the support for unnamed clock of sama5d2 in a separate
> patch. The dt-bindings patch that imposes "pclk" for sama5d2 should be separated too.

Sounds good.
