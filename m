From: Han Xu <han.xu@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Date: Wed, 10 Jul 2019 15:35:46 +0000
Message-ID: <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com> <20190710151628.GF14859@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710151628.GF14859@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Wednesday, July 10, 2019 10:16 AM
> To: Han Xu <han.xu@nxp.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; linux-spi@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB m=
emory
> for FSPI
>=20
> On Wed, Jul 10, 2019 at 10:31:26AM +0800, han.xu@nxp.com wrote:
> > From: Han Xu <han.xu@nxp.com>
> >
> > dynamically alloc AHB memory for FSPI controller
>=20
> Why?  This is currently done at probe which is what you'd expect to happe=
n
> here, there's no explanation as to why this change is being made.

Explained in cover letter, It failed to alloc the whole memory mapping area=
 during
probe on some platforms, since the AHB memory area could be pretty large. T=
he
error may look like:

[    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [mem 0x=
40000000-0x7fffffff]
