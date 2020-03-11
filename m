From: Chuanhong Guo <gch981213-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/3] spi: spi-mem: MediaTek: Add SPI NAND Flash interface
 driver for MediaTek MT7622
Date: Wed, 11 Mar 2020 15:31:29 +0800
Message-ID: <CAJsYDV+dAikBZ4gg_3u7z_jgV2ZehhyWyRQ709dNQV0XdDOUbQ@mail.gmail.com>
References: <1536716612-24610-1-git-send-email-xiangsheng.hou@mediatek.com>
 <1536716612-24610-4-git-send-email-xiangsheng.hou@mediatek.com>
 <20181023075247.004982c9@bbrezillon> <1540532796.24602.11.camel@mhfsdcap03> <20181026080833.2fedbd94@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Cc: Xiangsheng Hou <xiangsheng.hou-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
        marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
        ryder.lee-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
        xiaolei.li-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org,
        =?UTF-8?B?QmVubGlhbmcgWmhhbyAo6LW15pys5LquKQ==?=
        <benliang.zhao-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>,
        =?UTF-8?B?QmF5aSBDaGVuZyAo56iL5YWr5oSPKQ==?=
        <bayi.cheng-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
        honghui.zhang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
To: Boris Brezillon <boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20181026080833.2fedbd94@bbrezillon>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Boris!

I'm about to pick this driver up and start upstream it in the future.
So I'm answering
your questions below and would like to get your further suggestions.

On Fri, Oct 26, 2018 at 2:09 PM Boris Brezillon
<boris.brezillon-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org> wrote:
> > > There's a fundamental issue with this driver: spi-mem was designed to be
> > > memory agnostic, and you seem to have a SPI controller that supports
> > > only SPI NANDs. Is that correct, or is it just that you developed the
> > > driver with SPI NANDs in  mind?
> > >
> > Yes, this driver supports only SPI NANDs.
> > Actually, Mediatek's controller is designed for NAND specifically, which
> > can support SPI NANDs and PARALLEL NANDs,and this driver is just for SPI
> > NANDs.
>
> Hm, I'm not so sure about that (I might be wrong though), it seems you
> can send any command you want, not only SPI NAND related ones. Maybe the
> controller is optimized for SPI NANDs but can do all kind of SPI
> transfers.

You are correct here. This controller can perform generic spi-mem operations,
and it has special routines for page cache R/W that utilize controller's ECC
functionality. I think the purpose of this is to provide better ECC capability
for some SPI NANDs with worse ECC algorithm on chip.

> > > Don't know what's possible to do with your controller, and maybe it's
> > > not able to execute random SPI memory operations, but in this case we
> > > should consider a different solution to support this driver.
> > >
> > > Do you have a public datasheet I can look at?
> > >
> > We do not have a public datasheet for Mediatek controller currently.
>
> Unfortunately, there's not much I can do without a clear understanding
> of how the controller works.
>

I found a public datasheet [0] on wiki page for Banana Pi R64 [1].
Register description is available under "NAND flash interface" section
starting at page 592.
There's a hackier version of this driver in OpenWrt [2] which checks
opcode and use controller routine for page cache R/W.

ECC part of this controller can also be used as a standalone ECC
algorithm and perform ECC operations on data provided by CPU.
But I think if it's implement this way, we wasted the page cache
R/W routines in this controller.

I have two other initial thoughts:
1. abstract some kind of ECC functionality in spi-mem interface
    I haven't really learned ECC stuff so I don't know whether this is
    possible and what kind of argument we needs for it.
2. modify SPI-NAND core to add support for special SPI-NAND controller.
    This limits controller's ability and adds extra burden for future extention
    of SPI-NAND framework.

Which way would you prefer and do you have other suggestions?

[0] https://drive.google.com/file/d/1cW8KQmmVpwDGmBd48KNQes9CRn7FEgBb/view?usp=sharing
[1] http://wiki.banana-pi.org/Banana_Pi_BPI-R64#Documents
[2] https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=target/linux/mediatek/patches-4.19/0306-spi-spi-mem-MediaTek-Add-SPI-NAND-Flash-interface-dr.patch;h=2370925372f69aed0566339a4808056580e88837;hb=HEAD
-- 
Regards,
Chuanhong Guo
