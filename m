From: Clark Wang <xiaoning.wang@nxp.com>
Subject: RE: [PATCH V3 1/4] spi: lpspi: Replace all "master" with "controller"
Date: Sat, 8 Dec 2018 05:42:46 +0000
Message-ID: <AM6PR04MB5016114544649016E2090094F3AB0@AM6PR04MB5016.eurprd04.prod.outlook.com>
References: <20181207024924.6315-1-xiaoning.wang@nxp.com>
         <20181207024924.6315-2-xiaoning.wang@nxp.com>
 <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Joe Perches <joe@perches.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1bb3bde9a47a3ca8a026fab9e6af420c1ae59f97.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Joe,

This patch series adds slave mode for lpspi controller. So this driver can =
support both master and slave mode for lpspi controller after apply this pa=
tch series. Currently, both master mode and slave mode share the code in th=
is driver. Therefore, using spi_master to represent the structure of slave =
mode will cause confusion.

When Geert Uytterhoeven add the slave support for spi, he had done " Genera=
lize SPI 'master' to 'controller'" step, too. The commit ID is 8caab75fd2c2=
a92667cbb1cd315720bede3feaa9.

Thank you.

Regards,
Clark Wang

> -----Original Message-----
> From: Joe Perches <joe@perches.com>
> Sent: Saturday, December 8, 2018 13:14
> To: Clark Wang <xiaoning.wang@nxp.com>; broonie@kernel.org
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH V3 1/4] spi: lpspi: Replace all "master" with "contro=
ller"
>=20
> On Fri, 2018-12-07 at 02:50 +0000, Clark Wang wrote:
> > In order to enable the slave mode and make the code more readable,
> > replace all related structure names and object names which is named
> > "master" with "controller".
>=20
> In what sense does this make the code more readable?
>=20
