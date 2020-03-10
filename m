From: <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3 4/4] mtd: spi-nor: remove mtk-quadspi driver
Date: Tue, 10 Mar 2020 07:41:26 +0000
Message-ID: <2471214.x7VzW1FXlQ@localhost.localdomain>
References: <20200306085052.28258-1-gch981213@gmail.com>
 <20200306085052.28258-5-gch981213@gmail.com>
 <20200309121020.GD4101@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: <gch981213@gmail.com>, <linux-mediatek@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <matthias.bgg@gmail.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
To: <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200309121020.GD4101@sirena.org.uk>
Content-Language: en-US
Content-ID: <6A321634F4832945827FEDE57CD2E761@namprd11.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi, Mark,

On Monday, March 9, 2020 2:10:20 PM EET Mark Brown wrote:
> > This driver is superseded by the new spi-mtk-nor driver.
> >=20
> > Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
>=20
> Is this move OK from a MTD point of view - should I apply this when the
> rest goes in?  The patch was in prior versions too and is obviously
> straightforward.

If you find the rest of the patches ok, this can go through the spi tree, f=
eel=20
free to add my
Acked-by: Tudor Ambarus <tudor.ambarus@microchip.com>

There will be a conflict with the following patch https://
patchwork.ozlabs.org/patch/1247791/, but nothing that we can't handle.
I'll try to allocate time for reviewing the remaining patches in this set i=
n=20
the following days.

Cheers,
ta
