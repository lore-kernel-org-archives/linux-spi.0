From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
Date: Thu, 4 Oct 2018 09:24:57 +0000
Message-ID: <VI1PR04MB1038ECE25B571117405A617799EA0@VI1PR04MB1038.eurprd04.prod.outlook.com>
References: <1538642920-3843-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1538642920-3843-5-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181004111822.48ab1f5c@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181004111822.48ab1f5c@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]
> Sent: Thursday, October 4, 2018 2:48 PM
> To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
> Cc: linux-mtd@lists.infradead.org; marek.vasut@gmail.com; vigneshr@ti.com=
;
> linux-spi@vger.kernel.org; devicetree@vger.kernel.org; robh@kernel.org;
> mark.rutland@arm.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org; computersforpeace@gmail.com;
> frieder.schrempf@exceet.de; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 4/4] arm64: dts: lx2160a: update fspi node
>=20
> On Thu,  4 Oct 2018 14:18:40 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
>=20
> > Flash mt35xu512aba connected to FlexSPI controller supports
> > 1-1-8 protocol.
> > Added flag spi-rx-bus-width and spi-tx-bus-width with values as
> > 8 and 1 respectively for both flashes connected at CS0 and CS1.
> >
> > Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
> > ---
> >  arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > index 901ca346..817175a 100644
> > --- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > +++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-rdb.dts
> > @@ -42,6 +42,8 @@
> >  		m25p,fast-read;
> >  		spi-max-frequency =3D <20000000>;
> >  		reg =3D <0>;
> > +		spi-rx-bus-width =3D <8>;
> > +		spi-tx-bus-width =3D <1>;
>=20
> Why 1? The flash is already flagged with SPI_NOR_OCTAL_READ, which means
> only the read path will use 1-1-8 mode, so you can safely set spi-tx-bus-=
width
> here and let the framework choose the appropriate mode based on the flash
> capabilities.

Ok.

>=20
> >  	};
> >
> >  	mt35xu512aba1: flash@1 {
> > @@ -51,6 +53,8 @@
> >  		m25p,fast-read;
> >  		spi-max-frequency =3D <20000000>;
> >  		reg =3D <1>;
> > +		spi-rx-bus-width =3D <8>;
> > +		spi-tx-bus-width =3D <1>;
> >  	};
> >  };
> >
