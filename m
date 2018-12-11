From: Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] ARM: dts: at91: sama5d2 Xplained: add QSPI0 + SPI NOR
 memory nodes
Date: Tue, 11 Dec 2018 15:50:03 +0100
Message-ID: <20181211145003.7bwd5yknm5cegtdj@M43218.corp.atmel.com>
References: <20181210171511.21002-1-tudor.ambarus@microchip.com>
 <20181210213553.GK8952@piout.net>
 <22730de3-55f0-df21-312a-560a02f02dc7@microchip.com>
 <20181211143545.GR8952@piout.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <Tudor.Ambarus@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Cyrille.Pitchen@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <boris.brezillon@bootlin.com>, <linux-mtd@lists.infradead.org>,
        <broonie@kernel.org>, <linux-spi@vger.kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181211143545.GR8952@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Dec 11, 2018 at 03:35:45PM +0100, Alexandre Belloni wrote:
> On 11/12/2018 12:32:40+0000, Tudor.Ambarus@microchip.com wrote:
> > Hi, Alexandre,
> > 
> > On 12/10/2018 11:35 PM, Alexandre Belloni wrote:
> > > Hi,
> > > 
> > > On 10/12/2018 17:15:29+0000, Tudor.Ambarus@microchip.com wrote:
> > >> From: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > >>
> > >> This patch configures the QSPI0 controller pin muxing and declares
> > >> a jedec,spi-nor memory.
> > >>
> > >> sama5d2 Xplained RevB and RevC use the Macronix MX25L25673G flash
> > >> memory which advertises a maximum frequency of 80MHz for Quad IO
> > >> Fast Read. Set the spi-max-frequency to 80MHz knowing that actually
> > >> the QSPI drver will set the SPI bus clock to 166MHz / 3 = 55.3MHz.
> > >>
> > >> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@microchip.com>
> > >> [tudor.ambarus@microchip.com:
> > >> - drop partitions,
> > >> - add spi-rx/tx-bus-width
> > >> - change spi-max-frequency to match the 80MHz limit advertised by
> > >>   MX25L25673G for Quad IO Fast Read,
> > >> - reword commit message and subject.]
> > >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> > >> ---
> > >>  arch/arm/boot/dts/at91-sama5d2_xplained.dts | 31 +++++++++++++++++++++++++++++
> > >>  1 file changed, 31 insertions(+)
> > >>
> > >> diff --git a/arch/arm/boot/dts/at91-sama5d2_xplained.dts b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > >> index 518e2b095ccf..171bc82cfbbf 100644
> > >> --- a/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > >> +++ b/arch/arm/boot/dts/at91-sama5d2_xplained.dts
> > >> @@ -108,6 +108,21 @@
> > >>  		};
> > >>  
> > >>  		apb {
> > >> +			qspi0: spi@f0020000 {
> > >> +				pinctrl-names = "default";
> > >> +				pinctrl-0 = <&pinctrl_qspi0_default>;
> > >> +				/* status = "okay"; */ /* conflict with sdmmc1 */
> > > 
> > > Isn't that conflicting then because I think the default is okay.
> > qspi0 is disabled in sama5d2.dtsi.
> > 
> 
> Ok, then maybe that comment is not necessary at all.

Usually we do it the other way around:
status = "disabled"; /* conflict with ... */

Regards

Ludovic
