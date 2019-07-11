From: Han Xu <han.xu@nxp.com>
Subject: RE: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc AHB
 memory for FSPI
Date: Thu, 11 Jul 2019 19:45:19 +0000
Message-ID: <AM6PR04MB49670C9EA59A507F9C78B42097F30@AM6PR04MB4967.eurprd04.prod.outlook.com>
References: <20190710023128.13115-1-han.xu@nxp.com>
 <20190710023128.13115-2-han.xu@nxp.com> <20190710151628.GF14859@sirena.co.uk>
 <AM6PR04MB49672BE152440416ACCE275197F00@AM6PR04MB4967.eurprd04.prod.outlook.com>
 <20190711124117.GG14859@sirena.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: Ashish Kumar <ashish.kumar@nxp.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190711124117.GG14859@sirena.co.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



> -----Original Message-----
> From: Mark Brown <broonie@kernel.org>
> Sent: Thursday, July 11, 2019 7:41 AM
> To: Han Xu <han.xu@nxp.com>
> Cc: Ashish Kumar <ashish.kumar@nxp.com>; linux-spi@vger.kernel.org; linux=
-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: Re: [EXT] Re: [PATCH 1/3] spi: spi-nxp-fspi: dynamically alloc A=
HB memory
> for FSPI
>=20
> On Wed, Jul 10, 2019 at 03:35:46PM +0000, Han Xu wrote:
>=20
> > > > dynamically alloc AHB memory for FSPI controller
>=20
> > > Why?  This is currently done at probe which is what you'd expect to
> > > happen here, there's no explanation as to why this change is being ma=
de.
>=20
> > Explained in cover letter, It failed to alloc the whole memory mapping
> > area during probe on some platforms, since the AHB memory area could
> > be pretty large. The error may look like:
>=20
> > [    1.129404] fsl-quadspi 1550000.spi: ioremap failed for resource [me=
m
> 0x40000000-0x7fffffff]
>=20
> The commit itself needs to have some explanation of what it's doing so it=
's in the
> git log, particularly for something odd like this.  More generally this j=
ust doesn't feel
> like it's solving the problem - essentially we're just deferring the mapp=
ing and then
> keep on failing operations until the allocation succeeds for some reason.=
  That's
> going to be disruptive for users of the device and it doesn't seem like i=
t's going to
> be a robust solution.  Why does the allocation not work initially and why=
 is it more
> likely to work later on?

Yes, I will explain the reason in next version. To allocate the whole 256MB=
 memory at one time exceed the vmalloc limit, so we dynamically allocate sm=
all amount of memory just as needed. There is no failing operation, just de=
ferring and re-allocate if new access area beyond the previous allocate are=
a.
