From: Boris Brezillon <boris.brezillon@bootlin.com>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Mon, 11 Jun 2018 09:46:16 +0200
Message-ID: <20180611094616.5c8f82cf@bbrezillon>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
        <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
        <DB6PR0402MB283845A1A98672FE63C89550997B0@DB6PR0402MB2838.eurprd04.prod.outlook.com>
        <20180608145130.09f979f9@bbrezillon>
        <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Frieder Schrempf <frieder.schrempf@exceet.de>,
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
To: Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <DB6PR0402MB2838D514CF38AC5E6C004E8499780@DB6PR0402MB2838.eurprd04.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Yogesh,

On Mon, 11 Jun 2018 06:31:00 +0000
Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com> wrote:

> 
> > 
> > Observation 2:
> > I have observed data sanity issue after performing read/write 
> > operations using MTD interface. Explained below
> > 
> > root:~# mtd_debug erase /dev/mtd0 0x1000000 0x40000
> > Erased 262144 bytes from address 0x01000000 in flash                      --> Erase at address 0x1000000 of erase size 0x40000
> > root:~# mtd_debug read /dev/mtd0 0x0 0x100 rp
> > Copied 256 bytes from address 0x00000000 in flash to rp                   --> Read 0x100 bytes from flash from address 0x0 in file rp
> > root:~# mtd_debug write /dev/mtd0 0x1000000 0x100 rp
> > Copied 256 bytes from rp to address 0x01000000 in flash                   --> Write 0x100 bytes to flash address 0x1000000 from file rp
> > root:~# mtd_debug read /dev/mtd0 0x1000000 0x100 wp
> > Copied 256 bytes from address 0x01000000 in flash to wp                  --> Read 0x100 bytes from flash from address 0x1000000 in file wp
> > root:~# diff rp wp                                                                                           --> compare both rp and wp files, if they are different output comes on console stating file are different
> > Files rp and wp differ
> > root:~# hexdump wp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 ffff ffff ffff ffff ffff ffff ffff ffff
> > *
> > 0000100
> > root:~# hexdump rp
> > 0000000 aa55 aa55 0000 8010 541c 4000 0040 0000
> > 0000010 0000 0000 0000 0000 0000 0000 0000 000a
> > 0000020 0000 0030 0000 0000 11a0 00a0 2580 0000
> > 0000030 0000 0000 0040 0000 005b 0000 0000 0000
> > 0000040 2403 0000 0000 0000 0000 0000 0000 0000
> > 0000050 0000 0000 0000 0000 0000 0000 0000 0000
> > *
> > 0000070 0011 0000 09e7 0000 0000 4411 9555 0050
> > 0000080 0000 0000 0000 0000 f9bc afa1 0404 31e0
> > 0000090 0000 0000 0400 31e0 0000 2010 08dc 31eb
> > 00000a0 2880 0050 1300 31eb 4e20 8010 0000 80ff
> > 00000b0 0000 0000 beef dead beef dead beef dead
> > 00000c0 beef dead beef dead beef dead beef dead
> > *
> > 0000100
> > root:~#
> > 
> > In hexdump output of the file which being read from address 0x1000000,wp, it can be observed that only first 64 bytes (0x40) are written on the flash.
> > 
> > Observation 3:
> > As we can support JFFS2 filesystem on NOR flash, so we can expect JFFS2 commands should work fine on NOR flash.
> > But with this driver change my mount command is not working.
> > 
> > In my target there are 2 flash slave devices connected, and I have given argument to create MTD partition like "mtdparts=20c0000.quadspi-1:5M(rcw),10M(test),46M(rootfs) " for 2nd flash.
> > Below is output for /proc/mtd commands
> >     root@ls1012ardb:~# cat /proc/mtd
> >     dev:    size   erasesize  name
> >     mtd0: 04000000 00040000 "20c0000.quadspi-0"   --> First 64MB flash
> >     mtd1: 00500000 00040000 "rcw"                               --> Second 64 MB flash device, 3 MTD partition are created for it.
> >     mtd2: 00a00000 00040000 "test"
> >     mtd3: 02e00000 00040000 "rootfs"
> > 
> >     root@ls1012ardb:~# mkdir /media/ram ; flash_eraseall /dev/mtd3
> >     flash_eraseall has been replaced by `flash_erase <mtddev> 0 0`; please use it
> >     Erasing 256 Kibyte @ 0 --  0 % complete [   18.299929] random: crng init done
> >     Erasing 256 Kibyte @ 2dc0000 -- 100 % complete
> >     root@ls1012ardb:~# mount -t jffs2 /dev/mtdblock3 /media/ram/
> > 
> > This command didn't finish successfully and there are lot of messages coming on console mentioning failure in jffs2_scan_eraseblock()
> >     [  187.118677] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0000: 0x2886 instead
> >     [  187.128159] jffs2: jffs2_scan_eraseblock(): Magic bitmask 0x1985 not found at 0x013c0004: 0x7a3b instead
> >     [  187.137641] jffs2: jffs2_scan_eraseblock(): Magic bitmask 
> > 0x1985 not found at 0x013c0008: 0xb10f instead
> > 
> > If I remove this patch series and check with older implementation, JFFS2 mounting is working fine.  
> 
> Problems 2 and 3 should definitely be fixed. That's weird because I remember that Frieder tested the new driver with a NOR chip, maybe not with JFFS2 though.
> 
> For write issue, it would be happening due to the changes pushed in spi-mem framework.

Now I understand why Frieder didn't face this issue: he was testing on
an imx6 which has a 512 bytes TX FIFO, while you're probably testing on
a vhybrid or layerscape platform which only has a 64 bytes TX FIFO.

I think it's time to accept having partial page writes. This has come
up several times (last time was [1]) and it looks like the fsl quadspi
driver was already doing this sort of things (well hidden in the probe
path [2] :-)).

Marek, any comment on that?

Regards,

Boris

[1]https://patchwork.ozlabs.org/patch/905507/
[2]https://elixir.bootlin.com/linux/v4.17/source/drivers/mtd/spi-nor/fsl-quadspi.c#L1106
