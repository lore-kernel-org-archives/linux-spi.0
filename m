From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Tue, 12 Jun 2018 09:13:28 +0200
Message-ID: <20180612091328.67734adb@bbrezillon>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB6PR0402MB2838563F1BA71A9A21ABBE01997F0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Tue, 12 Jun 2018 06:42:42 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> I have tried JFFS2 mounting with smaller partition size but still getting failure.
> For partition size equal or less than 1MB, getting errors as
>     [   25.044930] jffs2: Too few erase blocks (4)
> Thus, need to have size more than 1MB.
> 
> For 2MB partition size getting error message from jffs2_scan_eraseblock().
>     root@ls1012ardb:~# cat /proc/mtd
>     dev:    size   erasesize  name
>     mtd0: 04000000 00040000 "20c0000.quadspi-0"
>     mtd1: 00500000 00040000 "rcw"
>     mtd2: 00a00000 00040000 "test"
>     mtd3: 00200000 00040000 "rootfs"
>     root@ls1012ardb:~#  mkdir /media/ram ; flash_eraseall /dev/mtd3
>     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use it
>     Erasing 256 Kibyte @ 1c0000 -- 100 % complete
>     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
>     [   26.380989] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000000: 0x0dd0 instead
>     [   26.390509] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x0000004c: 0x7366 instead
>     [   26.399999] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x00000050: 0x736c instead

That's weird. Can you tell me on which platform you're testing?
lsxxx or vf610? Can you dump the NOR after the erase to make sure the
memory is actually erased (filled with 0xff)?
