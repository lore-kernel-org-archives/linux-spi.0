From: Gareth Williams <gareth.williams.jx@renesas.com>
Subject: RE: [PATCH v2 2/4] dt-bindings: snps,dw-apb-ssi: Add optional clock
 domain information
Date: Tue, 1 Oct 2019 13:50:19 +0000
Message-ID: <TY2PR01MB292460F29AE0664CFFD70EFDDF9D0@TY2PR01MB2924.jpnprd01.prod.outlook.com>
References: <1568793876-9009-1-git-send-email-gareth.williams.jx@renesas.com>
 <1568793876-9009-3-git-send-email-gareth.williams.jx@renesas.com>
 <20191001120203.GA28106@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191001120203.GA28106@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Rob,

On Tue, Oct 01, 2019 at 13:02:34AM +0100, Rob Herring wrote:
> On Wed, Sep 18, 2019 at 09:04:34AM +0100, Gareth Williams wrote:
> > Note in the bindings documentation that pclk should be renamed if a
> > clock domain is used to enable the optional bus clock.
> >
> > Signed-off-by: Gareth Williams <gareth.williams.jx@renesas.com>
> > ---
> > v2: Introduced this patch.
> > ---
> >  Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > index f54c8c3..3ed08ee 100644
> > --- a/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > +++ b/Documentation/devicetree/bindings/spi/snps,dw-apb-ssi.txt
> > @@ -16,7 +16,8 @@ Required properties:
> >  Optional properties:
> >  - clock-names : Contains the names of the clocks:
> >      "ssi_clk", for the core clock used to generate the external SPI cl=
ock.
> > -    "pclk", the interface clock, required for register access.
> > +    "pclk", the interface clock, required for register access. If a cl=
ock domain
> > +     used to enable this clock then it should be named "pclk_clkdomain=
".
>=20
> What's a clock domain?
>=20
> Unless this is a h/w difference in the IP block, then this change doesn't=
 make
> sense.
This is a reference to the use of clock domains that are implemented throug=
h
generic power domains. The domain is implemented in=20
drivers/clk/renesas/r9a06g032-clocks.c and general details of clock domains
can be found at=20
https://elinux.org/images/1/14/Last_One_Out%2C_Turn_Off_The_Lights.pdf

>=20
> >  - cs-gpios : Specifies the gpio pins to be used for chipselects.
> >  - num-cs : The number of chipselects. If omitted, this will default to=
 4.
> >  - reg-io-width : The I/O register width (in bytes) implemented by
> > this
> > --
> > 2.7.4
> >
