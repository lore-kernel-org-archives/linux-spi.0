From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Mon, 18 Jun 2018 13:32:27 +0000
Message-ID: <DB6PR0402MB2838C4F67D17337ADBC5D5F899710@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611121618.40f4b609@bbrezillon>
        <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180612091328.67734adb@bbrezillon>
        <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180615145019.734f23a9@bbrezillon>
        <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180615155541.4f43e9bb@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "richard@nod.at" <richard@nod.at>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615155541.4f43e9bb@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org



-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Friday, June 15, 2018 7:26 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>; Fabio Estevam <fabio.=
estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; dwmw2@infradead.org
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; c=
omputersforpeace@gmail.com
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Fri, 15 Jun 2018 13:42:12 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> Hi Boris,
>=20
> I am still debugging the issue.
> With some analysis, able to check that proper values are not being writte=
n for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.
>=20
> In current code, value of map_addr are being assigned to these register.
>              map_addr =3D q->memmap_phy +
>                         2 * q->devtype_data->ahb_buf_size;
>=20
>      qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));
>=20
> But instead of "q->devtype_data->ahb_buf_size" it should be flash size.

No, because we're only using 2 * ->ahb_buf_size in the direct mapping for e=
ach device, and we're modifying the mapping dynamically based on the select=
ed device. Maybe we got the logic wrong though.

Yes, for register QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD, we need t=
o save starting actual address from where this flash is getting started.
Thus, if my first flash size is 64MB, then register QUADSPI_SFA2AD would ha=
ve value of q->memmap_phy + 0x4000000 i.e. (QUADSPI_SFA1AD + sizeof First F=
lash)
If second flash is of size 32MB, then register QUADSPI_SFB1AD would have va=
lue of value of QUADSPI_SFA2AD + sizeof second flash.

> For my case flash size is 0x4000000 and with this hard coded value I am a=
ble to perform Write and Erase operation.
> One more change, I have to do is adding the flash_size when writing the b=
ase_address in SFAR register for case when "mem->spi->chip_select =3D=3D 1"
> 	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);

I don't want to expose the full device in the direct mapping yet (that's pa=
rt of the direct-mapping API I posted here [1]). What this version of the d=
river does is, map only 2 time the ahb_size so that we can bypass the inter=
nal cache of the QSPI engine.

To perform any operation on second flash, we need to provide it's base addr=
ess should be saved in SFAR register for this particular operation.
Exposing only 2 time of ahb_size is design decision but value in SFAR regis=
ter should be correct.

>=20
> Thus, there should be mechanism or the entry in structure where we can ha=
ve the information of the size of the connected slave device.

Because that's exactly the kind of thing I'd like to avoid. What if the dev=
ice is bigger than the reserved memory region? What if the sum of all devic=
es does not fit in there? Here I tried to support all cases by just mapping=
 the portion of memory we need.

So IMO, there should be mechanism to have value of start address of each sl=
ave device. This might can be done from DTS entry of each slave device conn=
ected to the controller.
