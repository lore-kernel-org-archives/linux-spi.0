From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Date: Tue, 11 Dec 2018 15:48:58 +0100
Message-ID: <20181211144858.dnbj5iozgk74wzdm@M43218.corp.atmel.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181211154033.076506aa@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <Tudor.Ambarus@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <broonie@kernel.org>,
        <linux-spi@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211154033.076506aa@bbrezillon>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 11, 2018 at 03:40:33PM +0100, Boris Brezillon wrote:
> On Mon, 10 Dec 2018 17:15:29 +0000
> <Tudor.Ambarus@microchip.com> wrote:
> 
> > From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > 
> > This patch configures the QSPI0 controller pin muxing and declares
> > a jedec,spi-nor memory.
> > 
> > sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> > memory which advertises a maximum frequency of 80MHz for Quad IO
> > Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> > the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> > 
> > Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > [tudor.ambarus@microchip.com:
> > - drop partitions,
> > - add spi-rx/tx-bus-width
> > - change spi-max-frequency to match the 80MHz limit advertised by
> >   MX25L25673G for Quad IO Fast Read,
> > - reword commit message and subject.]
> > Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > ---
> >  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
> >  1 file changed, 31 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > index 518e2b095ccf..171bc82cfbbf 100644
> > --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > @@ -108,6 +108,21 @@
> >  		};
> >  
> >  		apb {
> > +			qspi0: spi@f0020000 {
> > +				pinctrl-names = "default";
> > +				pinctrl-0 = <&pinctrl_qspi0_default>;
> > +				/* status = "okay"; */ /* conflict with sdmmc1 */
> > +
> > +				flash@0 {
> > +					compatible = "jedec,spi-nor";
> > +					reg = <0>;
> > +					spi-max-frequency = <80000000>;
> > +					spi-tx-bus-width = <4>;
> > +					spi-rx-bus-width = <4>;
> > +					m25p,fast-read;
> > +				};
> 
> I'm a bit lost. What's the point of defining this if the QSPI
> controller is not enabled?

It's a way to avoid customer struggling with the device tree. If he
doesn't care about sdmmc1, he can easily enable the qpsi controller and
get access to the memory.

Regards

Ludovic
