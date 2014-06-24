From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/2] documentation: add rockchip spi documentation
Date: Tue, 24 Jun 2014 11:47:14 +0100
Message-ID: <20140624104714.GF5856@leverpostej>
References: <1403582324-9485-1-git-send-email-addy.ke@rock-chips.com>
 <1403582324-9485-2-git-send-email-addy.ke@rock-chips.com>
 <20140624101802.GE5856@leverpostej>
 <2324491.URDIcWcjph@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: addy ke <addy.ke@rock-chips.com>,
	"broonie@kernel.org" <broonie@kernel.org>,
	"grant.likely@linaro.org" <grant.likely@linaro.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"huangtao@rock-chips.com" <huangtao@rock-chips.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"yzq@rock-chips.com" <yzq@rock-chips.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"kever.yang@rock-chips.com" <kever.yang@rock-chips.com>,
	"zyw@rock-chips.com" <zyw@rock-chips.com>,
	"xjq@rock-chips.com" <xjq@rock-chips.com>,
	"zhenfu.fang@rock-chips.com" <zhenfu.fang@rock-chips.com>,
	"olof@lixom.net" <olof@lixom.net>,
	"cf@rock-chips.com" <cf@rock-chips.com>,
	"hj@rock-chips.com" <hj@rock-chips.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
To: Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2324491.URDIcWcjph@diego>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jun 24, 2014 at 11:32:21AM +0100, Heiko St=C3=BCbner wrote:
> Am Dienstag, 24. Juni 2014, 11:18:02 schrieb Mark Rutland:
> > On Tue, Jun 24, 2014 at 04:58:43AM +0100, addy ke wrote:
> > > Signed-off-by: addy ke <addy.ke@rock-chips.com>
> > > ---
> > >=20
> > >  .../devicetree/bindings/spi/spi-rockchip.txt       | 51
> > >  ++++++++++++++++++++++ 1 file changed, 51 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/spi/spi-roc=
kchip.txt
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/spi/spi-rockchip.t=
xt
> > > b/Documentation/devicetree/bindings/spi/spi-rockchip.txt new file=
 mode
> > > 100644
> > > index 0000000..ce9c881
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/spi/spi-rockchip.txt
> > > @@ -0,0 +1,51 @@
> > > +* Rockchip SPI Controller
> > > +
> > > +The Rockchip SPI controller is used to interface with various de=
vices
> > > such as flash +and display controllers using the SPI communicatio=
n
> > > interface.
> > > +
> > > +Required SoC Specific Properties:
> > > +
> > > +- compatible: should be one of the following.
> > > +    - rockchip,rk3066-spi: for rk3066, rk3188 and rk3288 platfor=
ms.
> >=20
> > Are you sure you don't want specifc strings for rk3188 and rk3288 (=
in
> > addtion to the common "rockchip,rk3066-spi")?
>=20
> Wasn't the convention that "later" platforms that are compatible to a=
n earlier=20
> one, reuse this compatible string instead of introducing a new one?

That's why I said in addition to the common one. I'd only expect the
driver to look for "rockchip,rk3066-spi", but a DTB could have:

	compatible =3D "rockchip,rk3188-spi", "rockchip,rk3066-spi";

Seeding the DTBs with the extra strings early makes it more likely that
we can rely on them later. If we don't happen to need them they only
clutter some DTBs.

> From what I've heard so far, the specific spi controller got introduc=
ed with=20
> the rk3066 [earlier SoCs used a different implementation] and didn't =
change for=20
> rk3188 and rk3288. Addy may be able to verify this.
>=20
>=20
> > > +- reg: physical base address of the controller and length of mem=
ory
> > > mapped
> > > +       region.
> > > +- interrupts: The interrupt number to the cpu. The interrupt spe=
cifier
> > > format +              depends on the interrupt controller.
> > > +- clocks: Must contain an entry for each entry in clock-names.
> > > +- clock-names: Shall be "spiclk" for the transfer-clock, and "ap=
b_pclk"
> > > for +			   the peripheral clock.
> > > +
> > > +Optional properties:
> > > +- dmas: DMA specifiers for tx and rx dma. See the DMA client bin=
ding,
> > > +		Documentation/devicetree/bindings/dma/dma.txt
> > > +- dma-names: DMA request names should include "tx" and "rx" if p=
resent.
> > > +
> > > +Example:
> > > +
> > > +- SoC Specific Portion:
> > > +
> > > +	spi0: spi@ff110000 {
> > > +		compatible =3D "rockchip,rockchip-spi";
> >=20
> > This does not match the description of the compatible property.
> >=20
> > > +		reg =3D <0xff110000 0x1000>;
> > > +		dmas =3D <&pdma1 11>, <&pdma1 12>;
> > > +		dma-names =3D "tx", "rx";
> > > +		#address-cells =3D <1>;
> > > +		#size-cells =3D <0>;
> >=20
> > These weren't mentioned.
> >=20
> > > +		interrupts =3D <GIC_SPI 44 IRQ_TYPE_LEVEL_HIGH>;
> > > +		pinctrl-names =3D "default";
> > > +		pinctrl-0 =3D <&spi0_clk &spi0_tx &spi0_rx &spi0_cs0 &spi0_cs1=
>;
> >=20
> > pinctrl was not mentioned.
> >=20
> > > +		clocks =3D <&cru SCLK_SPI0>, <&cru PCLK_SPI0>;
> > > +		clock-names =3D "spiclk", "apb_pclk";
> > > +		status =3D "disabled";
> >=20
> > Any reason for the status?
>=20
> I guess to have the spi controller only be enabled when a board is us=
ing it as=20
> below. But it may be an implementation detail which could be omitted =
from the=20
> binding doc.

Yes please :)

>=20
> >=20
> > > +	};
> > > +
> > > +- Board Specific Portion:
> > > +
> > > +	&spi0 {
> > > +		status =3D "okay";
> > > +		spi_test@00 {
> > > +			compatible =3D "rockchip,spi_test";
> >=20
> > Huh?
>=20
> SPI declares it's devices similar to i2c, so while the example might =
profit=20
> from a more casual device, I'm not exactly sure what is the problem h=
ere.

Sure. Given that this is a known pattern for SPI controllers, do we nee=
d
this in each binding doc?

Mark.
