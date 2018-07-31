From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v4 0/3] Add support for MSCC Ocelot SPI
Date: Tue, 31 Jul 2018 20:16:28 +0200
Message-ID: <20180731181628.GX28585@piout.net>
References: <20180731143855.7131-1-alexandre.belloni@bootlin.com>
 <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie@kernel.org>, James Hogan <jhogan@kernel.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
To: Paul Burton <paul.burton@mips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180731173809.eovsuiezlqzud7zi@pburton-laptop>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 31/07/2018 10:38:09-0700, Paul Burton wrote:
> Hi Alexandre,
> 
> On Tue, Jul 31, 2018 at 04:38:52PM +0200, Alexandre Belloni wrote:
> > Hello,
> > 
> > This series only contains the DT documentation and the corresponding DT addition
> > since it has been rebased on spi-next.
> > 
> > Alexandre Belloni (3):
> >   spi: dw: document Microsemi integration
> >   mips: dts: mscc: Add spi on Ocelot
> >   mips: dts: mscc: enable spi and NOR flash support on ocelot PCB123
> > 
> >  .../devicetree/bindings/spi/snps,dw-apb-ssi.txt       |  6 ++++--
> >  arch/mips/boot/dts/mscc/ocelot.dtsi                   | 11 +++++++++++
> >  arch/mips/boot/dts/mscc/ocelot_pcb123.dts             | 10 ++++++++++
> >  3 files changed, 25 insertions(+), 2 deletions(-)
> 
> Thanks - looks like the DT binding has been accepted, so I've applied
> patches 2 & 3 to mips-next for 4.19.
> 

Thank you, it is great to see that going in as this makes the platform
much more useful !


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
