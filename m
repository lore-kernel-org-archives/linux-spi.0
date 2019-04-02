From: Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: RE: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI
 client properties
Date: Tue, 2 Apr 2019 20:27:43 +0000
Message-ID: <BYAPR12MB33988CD5578E3421E5AB005FC2560@BYAPR12MB3398.namprd12.prod.outlook.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
 <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
 <5ca06155.1c69fb81.60281.9b59@mx.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Timo Alho <talho@nvidia.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Krishna Yarlagadda" <kyarlagadda@nvidia.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5ca06155.1c69fb81.60281.9b59@mx.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Tue, Mar 26, 2019 at 10:56:42PM -0700, Sowjanya Komatineni wrote:
> > This patch adds Tegra SPI master tx and rx clock delay properties.
> >=20
> > TX/RX clock delays may vary depending on the platform design trace=20
> > lengths for each client on the Tegra SPI bus. These properties helps=20
> > to tune the clock delays.
> >=20
> > Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> > ---
> >  .../devicetree/bindings/spi/nvidia,tegra114-spi.txt      | 16 ++++++++=
++++++++
> >  1 file changed, 16 insertions(+)
>
> Just combine this with patch 19.
>
> > diff --git=20
> > a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt=20
> > b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > index 6167c5234b64..2b84b7b726ce 100644
> > --- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > +++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
> > @@ -29,6 +29,12 @@ spi-client device controller properties:
> >  - nvidia,cs-hold-clk-count: CS hold timing parameter.
> >  - nvidia,cs-inactive-cycles: CS inactive delay in terms of clock betwe=
en
> >    transfers.
> > +- nvidia,tx-clk-tap-delay: Delays the clock going out to the external=
=20
> > +device
> > +  with this tap value. This property is used to tune the outgoing=20
> > +data from
> > +  Tegra SPI master with respect to outgoing Tegra SPI master clock.
> > +- nvidia,rx-clk-tap-delay: Delays the clock coming in from the=20
> > +external device
> > +  with this tap value. This property is used to adjust the Tegra SPI=20
> > +master
> > +  clock with respect to the data from the SPI slave device.
>
> Are there units? What's the range of values.

TX/RX Clock delays are tap counts and there is internal tap-to-tap delay.
Will update to specify tap to delay correlation along with supported tap va=
lues range.

As per feedback from mark, will move CS timing to API implementation as the=
y are not
Tegra SPI specific and applicable in general.

>
> > =20
> >  Example:
> > =20
> > @@ -45,4 +51,14 @@ spi@7000d600 {
> >  	reset-names =3D "spi";
> >  	dmas =3D <&apbdma 16>, <&apbdma 16>;
> >  	dma-names =3D "rx", "tx";
> > +
> > +	<spi-client>@<bus_num> {
> > +		...
> > +		...
> > +		nvidia,cs-setup-clk-count =3D <10>;
> > +		nvidia,cs-hold-clk-count =3D <10>;
> > +		nvidia,rx-clk-tap-delay =3D <0>;
> > +		nvidia,tx-clk-tap-delay =3D <16>;
> > +		...
> > +	};
> >  };
> > --
> > 2.7.4
> >=20
