From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI
 controller
Date: Tue, 15 Jan 2019 09:54:27 +0000
Message-ID: <VI1PR04MB572615130C849F1B8A807F9A99810@VI1PR04MB5726.eurprd04.prod.outlook.com>
References: <1546939346-20181-1-git-send-email-yogeshnarayan.gaur@nxp.com>
        <1546939346-20181-2-git-send-email-yogeshnarayan.gaur@nxp.com>
        <dbb6ddc8-5939-3d4b-7031-931afa79fccb@kontron.de>
 <20190114093759.2ce51b55@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "boris.brezillon@bootlin.com" <boris.brezillon@bootlin.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
To: Boris Brezillon <bbrezillon@kernel.org>,
        Schrempf Frieder <frieder.schrempf@kontron.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190114093759.2ce51b55@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

> -----Original Message-----
> From: Boris Brezillon [mailto:bbrezillon@kernel.org]
> Sent: Monday, January 14, 2019 2:08 PM
> To: Schrempf Frieder <frieder.schrempf@kontron.de>
> Cc: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; linux-
> mtd@lists.infradead.org; boris.brezillon@bootlin.com; marek.vasut@gmail.c=
om;
> broonie@kernel.org; linux-spi@vger.kernel.org; devicetree@vger.kernel.org=
;
> mark.rutland@arm.com; robh@kernel.org; linux-kernel@vger.kernel.org;
> computersforpeace@gmail.com; shawnguo@kernel.org; linux-arm-
> kernel@lists.infradead.org
> Subject: Re: [PATCH v6 1/5] spi: spi-mem: Add driver for NXP FlexSPI cont=
roller
>=20
> On Thu, 10 Jan 2019 17:28:57 +0000
> Schrempf Frieder <frieder.schrempf@kontron.de> wrote:
>=20
> > Hi Yogesh,
> >
> > my comments below are mainly about things I already mentioned in my
> > review for v5 and about removing or simplifying some unnecessary or
> > complex code.
> >
[...]
> >
>=20
> Once you've addressed all of Frieder's comments you can add
>=20
> Reviewed-by: Boris Brezillon <bbrezillon@kernel.org>
>=20
Thanks.
I have send next version, v7, of the patch series having added code changes=
 as per Frieder's comments. [1]
Based on the feedback from Frieder, would add yours r-o-b tag.

--
Regards
Yogesh Gaur
[1] https://patchwork.ozlabs.org/project/linux-mtd/list/?series=3D86130

> Regards,
>=20
> Boris
