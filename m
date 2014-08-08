From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 09/12] [v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for
 QSPI
Date: Fri, 8 Aug 2014 10:38:33 +0900
Message-ID: <20140808013833.GA17028@verge.net.au>
References: <2006783.fexCv50f5Y@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Mark Brown <broonie@kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	dmaengine@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2006783.fexCv50f5Y@avalon>
 <CAMuHMdU+o=CGFMyDVSxSKbpAx1oi1id7zABf-pm_pYzvuGOrWw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 07, 2014 at 10:27:21AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Aug 7, 2014 at 2:41 AM, Simon Horman <horms@verge.net.au> wrote:
> > On Thu, Aug 07, 2014 at 09:39:08AM +0900, Simon Horman wrote:
> >> On Thu, Aug 07, 2014 at 09:37:56AM +0900, Simon Horman wrote:
> >> > On Wed, Aug 06, 2014 at 02:59:06PM +0200, Geert Uytterhoeven wrote:
> >> > > Add a DMA property to the QSPI node
> >> > >
> >> > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >> > > Cc: devicetree@vger.kernel.org
> >> > > ---
> >> > > This depends on "[PATCH v2 8/8] ARM: shmobile: r8a7791: Add DMAC devices
> >> > > to DT" of series "[PATCH v2 0/8] R-Car Gen2 DMA Controller driver".
> >> >
> >> > Hi Geert, Hi Laurent,
> >> >
> >> > Am I correct in assuming that with this patch applied things
> >> > will continue to work the old way until the patch above applied
> >> > to the same tree and from there on the user will get the new behaviour?
> >> >
> >> > If so I think that I can take this patch as although the driver hasn't been
> >> > merged the relevant bindings were added to the subsystem maintainers tree
> >> > by "dmaengine: rcar-dmac: Add device tree bindings documentation" and are
> >> > available in linux-next.
> >> >
> >> > Likewise for "[v3] ARM: shmobile: r8a7791 dtsi: Enable DMA for MSIO".
> >>
> >> ... and "ARM: shmobile: r8a7790 dtsi: Enable DMA for QSPI"
> >
> > ... and "ARM: shmobile: r8a7790 dtsi: Enable DMA for MSIO"
> >
> > and any other similar patches I didn't list above :)
> 
> Yes[*].
> 
> If rcar-dma is not available, drivers fall back to PIO, cfr. for rspi:
> 
> -renesas_spi e6b10000.spi: DMA available
> +renesas_spi e6b10000.spi: dma_request_slave_channel_compat failed
> +renesas_spi e6b10000.spi: DMA not available, using PIO
>  renesas_spi e6b10000.spi: registered master spi0
>  spi spi0.0: setup mode 0, 8 bits/w, 30000000 Hz max --> 0
>  m25p80 spi0.0: s25fl512s (65536 Kbytes)
>  3 ofpart partitions found on MTD device spi0.0
>  Creating 3 MTD partitions on "spi0.0":
>  0x000000000000-0x000000080000 : "loader"
>  0x000000080000-0x000000100000 : "bootenv"
>  0x000000100000-0x000004000000 : "data"
>  renesas_spi e6b10000.spi: registered child spi0.0
> 
> and sh-msiof:
> 
> -spi_sh_msiof e6e20000.spi: DMA available
> +spi_sh_msiof e6e20000.spi: dma_request_slave_channel_compat failed
> +spi_sh_msiof e6e20000.spi: DMA not available, using PIO
>  spi_sh_msiof e6e20000.spi: registered master spi1
>  spi spi1.0: setup mode 3, 8 bits/w, 6000000 Hz max --> 0
>  spi_sh_msiof e6e20000.spi: registered child spi1.0
> 
> and everything still works, but slower.
> 
> [*] If the individual DMA slave drivers properly handle DMA request
>     failures. If they don't, they will already fail now, as there is no DMA
>     platform configuration without the dmas/dma-names properties
>     (ignoring Magnus' DMA prototypes using auxdata, as DT is the way
>      forward).

Thanks, I have queued up the 4 shmobile patches for v3.18 with
Laurent's Ack. They should appear in the devel branch of the renesas tree
some time today.

On Thu, Aug 07, 2014 at 02:16:47AM +0200, Laurent Pinchart wrote:
> Hi Geert,
> 
> Thank you for the patches.
> 
> On Wednesday 06 August 2014 14:58:57 Geert Uytterhoeven wrote:
> > 	Hi Mark, Simon,
> > 
> > Here's a series of Renesas RSPI/QSPI and SH-MSIOF SPI driver updates.
> > I grouped them in three parts:
> >   - [1-5] are for the rspi driver (Mark),
> >   - [6-8] are for the sh-msiof driver (Mark),
> >   - [9-12] are for the R-Car Gen2 DTSes (Simon).
> 
> For everything but 06/12,
> 
> Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

[snip]

