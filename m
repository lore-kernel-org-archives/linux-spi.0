From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Fri, 15 Jun 2018 13:42:12 +0000
Message-ID: <DB6PR0402MB28382767652782E0CC6C14A0997C0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
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
        Fabio Estevam <fabio.estevam@nxp.com>,
        David Wolfe <david.wolfe@nxp.com>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180615145019.734f23a9@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

I am still debugging the issue.
With some analysis, able to check that proper values are not being written =
for QUADSPI_SFA2AD/ QUADSPI_SFB1AD/ QUADSPI_SFB2AD register.

In current code, value of map_addr are being assigned to these register.
             map_addr =3D q->memmap_phy +
                        2 * q->devtype_data->ahb_buf_size;

     qspi_writel(q, map_addr, q->iobase + QUADSPI_SFA1AD + (i * 4));

But instead of "q->devtype_data->ahb_buf_size" it should be flash size.=20
For my case flash size is 0x4000000 and with this hard coded value I am abl=
e to perform Write and Erase operation.
One more change, I have to do is adding the flash_size when writing the bas=
e_address in SFAR register for case when "mem->spi->chip_select =3D=3D 1"
	qspi_writel(q, q->memmap_phy + 0x4000000, base + QUADSPI_SFAR);

Thus, there should be mechanism or the entry in structure where we can have=
 the information of the size of the connected slave device.

With both of above hardcoded changes, I am able to perform Write and Erase =
operation on my second flash device but still facing issue in Read operatio=
n, debugging in progress for that.

--
Regards
Yogesh Gaur


-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Friday, June 15, 2018 6:20 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; F=
abio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; co=
mputersforpeace@gmail.com; dwmw2@infradead.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Tue, 12 Jun 2018 08:51:25 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

>=20
> I am working on lsxxx platform. With further debugging, I found that my e=
rase operation for second flash device is not working properly.
> Need to have debugging for this in Frieder Patch.

Did you find the problem? Could it be a wrong "reg =3D <>" definition in yo=
ur DT (Frieder changed the CS numbering scheme in the new driver)?
