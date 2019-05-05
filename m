From: Robin Gong <yibin.gong@nxp.com>
Subject: RE: [EXT] Re: [PATCH v2 08/15] dt-bindings: spi: imx: add i.mx6ul to
 state errata fixed
Date: Sun, 5 May 2019 08:55:38 +0000
Message-ID: <VI1PR04MB45436CE1F6856137F586C94389370@VI1PR04MB4543.eurprd04.prod.outlook.com>
References: <1556265512-9130-1-git-send-email-yibin.gong@nxp.com>
 <1556265512-9130-9-git-send-email-yibin.gong@nxp.com>
 <20190501200711.GA31231@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "broonie@kernel.org" <broonie@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "plyatov@gmail.com" <plyatov@gmail.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dmaengine@vger.kernel.org" <dmaengine@vger.kernel.o
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190501200711.GA31231@bogus>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

> On Fri, Apr 26, 2019 at 08:05:51AM +0000, Robin Gong wrote:
> > ERR009165 fixed from i.mx6ul, add it to show the errata fixed.
> >
> > Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> > ---
> >  Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > index 2d32641..32c4263d 100644
> > --- a/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > +++ b/Documentation/devicetree/bindings/spi/fsl-imx-cspi.txt
> > @@ -10,6 +10,8 @@ Required properties:
> >    - "fsl,imx35-cspi" for SPI compatible with the one integrated on i.M=
X35
> >    - "fsl,imx51-ecspi" for SPI compatible with the one integrated on i.=
MX51
> >    - "fsl,imx53-ecspi" for SPI compatible with the one integrated on
> > i.MX53 and later Soc
> > +  - "fsl,imx6ul-ecspi" ERR009165 fixed on i.MX6UL and later Soc
> > +
> > + (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F=
w
> > +
> ww.nxp.com%2Fdocs%2Fen%2Ferrata%2FIMX6DQCE.pdf&amp;data=3D02%7C01
> %7Cyi
> > +
> bin.gong%40nxp.com%7C1eb9b302759b4af6fbe408d6ce709b8b%7C686ea1d
> 3bc2b
> > +
> 4c6fa92cd99c5c301635%7C0%7C1%7C636923380371230101&amp;sdata=3D%
> 2BxM9fN
> > + 6aEFkNlY5KU9qNiqqFMuDEfqGNrzADDiPO9gQ%3D&amp;reserved=3D0)
>=20
> What about other i.MX6 chips?
I only state in the cover letter of this patch set, for i.mx6q/dl/sl/sx sti=
ll need this
errata which is fixed i.mx chips after i.mx6ul including i.mx6ull,i.mx8m,i.=
mx8mm.
I'll double confirm again and describe it clearly in commit log in v3.
>=20
> Seems like this is missing some fallbacks. The binding doc should make it=
 clear
> what are all valid combinations of compatible strings.
In another Uwe's comment, I'm thinking move such errata information into sp=
i
driver level which makes binding doc clear. What do you think?
>=20
> >    - "fsl,imx8mq-ecspi" for SPI compatible with the one integrated on
> > i.MX8M
> >  - reg : Offset and length of the register set for the device
> >  - interrupts : Should contain CSPI/eCSPI interrupt
> > --
> > 2.7.4
> >
