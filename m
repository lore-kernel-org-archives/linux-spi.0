From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Mon, 11 Jun 2018 10:21:22 +0000
Message-ID: <DB6PR0402MB28388D9DEB86629BB58DD5E499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180611094616.5c8f82cf@bbrezillon>
        <DB6PR0402MB283825171DF93AD3C8590DD799780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
 <20180611121618.40f4b609@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Cc: "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        Frieder Schrempf <frieder.schrempf@exceet.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "richard@nod.at" <richard@nod.at>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        David Wolfe <david.wolfe@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>,
        Han Xu <han.xu@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180611121618.40f4b609@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Monday, June 11, 2018 3:46 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; l=
inux-mtd@lists.infradead.org; linux-spi@vger.kernel.org; dwmw2@infradead.or=
g; computersforpeace@gmail.com; richard@nod.at; miquel.raynal@bootlin.com; =
broonie@kernel.org; David Wolfe <david.wolfe@nxp.com>; Fabio Estevam <fabio=
.estevam@nxp.com>; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu =
<han.xu@nxp.com>; linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Mon, 11 Jun 2018 09:38:14 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> > > Observation 3:
> > > As we can support JFFS2 filesystem on NOR flash, so we can expect JFF=
S2 commands should work fine on NOR flash.
> > > But with this driver change my mount command is not working.
> > >=20
> > > In my target there are 2 flash slave devices connected, and I have gi=
ven argument to create MTD partition like "mtdparts=3D20c0000.quadspi-1:5M(=
rcw),10M(test),46M(rootfs) " for 2nd flash.
> > > Below is output for /proc/mtd commands
> > >     root@ls1012ardb:~# cat /proc/mtd
> > >     dev:    size   erasesize  name
> > >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flas=
h
> > >     mtd1: 00500000 00040000 "rcw"                               --> S=
econd 64 MB flash device, 3 MTD partition are created for it.
> > >     mtd2: 00a00000 00040000 "test"
> > >     mtd3: 02e00000 00040000 "rootfs"

When I do mtd1 + mtd2 + mtd3, I end up with 0x3d00000 instead of 0x4000000.=
 Is that normal? Do you reserve a bit of space at the end or is it that rcw=
 is not starting at 0?

I have given partition size n bootargs as mtdparts=3D20c0000.quadspi-1:5M(r=
cw),10M(test),46M(rootfs)
5 + 10 + 46 =3D=3D> 61M i.e. 0x3d00000.
I have just reserve the bit at the end, we can modify these settings also.

> > >=20
> > >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> > >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; p=
lease use it
> > >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: cr=
ng init done
> > >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> > >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> > >=20
> > > This command didn't finish successfully and there are lot of messages=
 coming on console mentioning failure in jffs2_scan_eraseblock()
> > >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask=20
> > > 0x1985 not found at 0x013c0000: 0x2886 instead

Did you try to create a smaller partition? Maybe we have a problem when acc=
essing addresses higher than X with the new driver (X to be determined).

Would try and update you.

--
Regards
Yogesh Gaur

> > >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x19=
85 not found at 0x013c0004: 0x7a3b instead
> > >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask
> > > 0x1985 not found at 0x013c0008: 0xb10f instead
> > >=20
