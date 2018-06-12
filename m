From: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Subject: RE: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 12 Jun 2018 08:51:25 +0000
Message-ID: <DB6PR0402MB28387FE79F2742C9BEBD4037997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
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
In-Reply-To: <20180612091328.67734adb@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

-----Original Message-----
From: Boris Brezillon [mailto:boris.brezillon@bootlin.com]=20
Sent: Tuesday, June 12, 2018 12:43 PM
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc: richard@nod.at; Prabhakar Kushwaha <prabhakar.kushwaha@nxp.com>; Han Xu=
 <han.xu@nxp.com>; linux-kernel@vger.kernel.org; linux-spi@vger.kernel.org;=
 marek.vasut@gmail.com; Frieder Schrempf <frieder.schrempf@exceet.de>; broo=
nie@kernel.org; linux-mtd@lists.infradead.org; miquel.raynal@bootlin.com; F=
abio Estevam <fabio.estevam@nxp.com>; David Wolfe <david.wolfe@nxp.com>; co=
mputersforpeace@gmail.com; dwmw2@infradead.org
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI =
controller

On Tue, 12 Jun 2018 06:42:42 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> I have tried JFFS2 mounting with smaller partition size but still getting=
 failure.
> For partition size equal or less than 1MB, getting errors as
>     [   25.044930] jffs2: Too few erase blocks (4)
> Thus, need to have size more than 1MB.
>=20
> For 2MB partition size getting error message from jffs2_scan_eraseblock()=
.
>     root@ls1012ardb:~# cat /proc/mtd
>     dev:    size   erasesize  name
>     mtd0: 04000000 00040000 "20c0000.quadspi-0"
>     mtd1: 00500000 00040000 "rcw"
>     mtd2: 00a00000 00040000 "test"
>     mtd3: 00200000 00040000 "rootfs"
>     root@ls1012ardb:~#  mkdir /media/ram ; flash_eraseall /dev/mtd3
>     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; pleas=
e use it
>     Erasing 256 Kibyte @ 1c0000 -- 100 % complete
>     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
>     [   26.380989] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x00000000: 0x0dd0 instead
>     [   26.390509] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x0000004c: 0x7366 instead
>     [   26.399999] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 n=
ot found at 0x00000050: 0x736c instead

That's weird. Can you tell me on which platform you're testing?
lsxxx or vf610? Can you dump the NOR after the erase to make sure the memor=
y is actually erased (filled with 0xff)?

I am working on lsxxx platform. With further debugging, I found that my era=
se operation for second flash device is not working properly.
Need to have debugging for this in Frieder Patch.

When I have created multiple partition for First flash device, then JFFS2 m=
ounting and booting of Linux kernel from rootfstype=3Djffs2 is successful.
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 00500000 00040000 "rcw"
    mtd1: 00a00000 00040000 "test"
    mtd2: 02e00000 00040000 "rootfs"
    mtd3: 04000000 00040000 "20c0000.quadspi-1"
In above list, for MTD2 partition, able to perform JFFS2 mounting.

Below is logs of erase for both flashes:
    root@ls1012ardb:~# cat /proc/mtd
    dev:    size   erasesize  name
    mtd0: 04000000 00040000 "20c0000.quadspi-0"
    mtd1: 04000000 00040000 "20c0000.quadspi-1"
    root@ls1012ardb:~# mtd_debug erase /dev/mtd0 0x1000000 0x2000000
    Erased 33554432 bytes from address 0x01000000 in flash
    root@ls1012ardb:~#
    root@ls1012ardb:~# mtd_debug read /dev/mtd0 0x1000000 0xa00000 rp
    Copied 10485760 bytes from address 0x01000000 in flash to rp
    root@ls1012ardb:~# hexdump rp
    0000000 ffff ffff ffff ffff ffff ffff ffff ffff
    *
    0a00000
    root@ls1012ardb:~#
    root@ls1012ardb:~# mtd_debug erase /dev/mtd1 0x1000000 0x2000000
     [   25.023027] random: crng init done
    Erased 33554432 bytes from address 0x01000000 in flash
    root@ls1012ardb:~# mtd_debug read /dev/mtd1 0x1000000 0xa00000 rp
    Copied 10485760 bytes from address 0x01000000 in flash to rp
    root@ls1012ardb:~#
    root@ls1012ardb:~# hexdump rp
    0000000 1985 2003 000c 0000 b0b1 e41e ffff ffff
    0000010 ffff ffff ffff ffff ffff ffff ffff ffff
    *
    0040000 1985 2003 000c 0000 b0b1 e41e ffff ffff
    0040010 ffff ffff ffff ffff ffff ffff ffff ffff

--
Yogesh Gaur
