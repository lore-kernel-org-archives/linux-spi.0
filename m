From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Thu, 24 Jan 2019 14:27:52 +0300
Message-ID: <25ce4224-54fd-d52e-8512-a3845cfe7682@cogentembedded.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <12af2632-491d-0e01-66c9-0ead4f9d985a@cogentembedded.com>
 <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, marek.vasut@gmail.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFC86383C3.5347178A-ON4825838C.00093E95-4825838C.000B9D6F@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 01/24/2019 05:06 AM, masonccyang@mxic.com.tw wrote:

>> > +// SPDX-License-Identifier: GPL-2.0
>> > +//
>> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
>> > +// Copyright (C) 2018 Macronix International Co., Ltd.
>> > +//
>> > +// R-Car Gen3 RPC-IF SPI/QSPI/Octa driver
>>
>>    Do we really support Octa?
> 
> yes and it needs to patch spi-nor layer and RPC driver for sure.

   It?

>> > +//
>> > +// Authors:
>> > +//   Mason Yang <masonccyang@mxic.com.tw>
>> > +//
>> [...]
>> > +#include <asm/unaligned.h>
>> [...]
>> > +   } else if (rx_buf) {
>> > +      //
>> > +      // RPC-IF spoils the data for the commands without an address
>> > +      // phase (like RDID) in the manual mode, so we'll have to work
>> > +      // around this issue by using the external address space read
>> > +      // mode instead.
>> > +      //
>> > +      if (!(smenr & RPC_SMENR_ADE(0xf))) {
>> > +         regmap_update_bits(rpc->regmap, RPC_CMNCR,
>> > +                  RPC_CMNCR_MD, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRCR,
>> > +                 RPC_DRCR_RBURST(32) | RPC_DRCR_RBE);
>> > +         regmap_write(rpc->regmap, RPC_DREAR, RPC_DREAR_EAC(1));
>> > +         regmap_write(rpc->regmap, RPC_DRCMR, rpc->cmd);
>> > +         regmap_write(rpc->regmap, RPC_DRDMCR, rpc->dummy);
>> > +         regmap_write(rpc->regmap, RPC_DROPR, 0);
>> > +         regmap_write(rpc->regmap, RPC_DRENR, smenr);
>> > +         memcpy_fromio(rx_buf, rpc->dirmap, rpc->xferlen);
>>
>>    Just noticed: if rpc->dirmap is NULL (which is now allowed), we
>> have a kernel oops
>> here. :-(
> 
> Do you patch your spi-mem.c ?

   What do you mean? The only extra patch I have to apply now to renesas.git repo's devel
branch is "mtd: devices: m25p80: Use the spi-mem dirmap API"...

> both dirmap_create() in your rpc driver and spi-mem layer should handle it well.

   I just saw that you don't fail the driver's probe() method if devm_ioremap_resource()
fails for the "dirmap" and "wbuf" resources...

>> [...]
>> > +static const struct of_device_id rpc_spi_of_ids[] = {
>> > +   { .compatible = "renesas,r8a77995-rpc", },
>>
>>    Why (if it has no differences with the generic gen3 value below)?
>> Please remove.
> 
> By Geert's comments in dts,
> 
>          rpc: rpc@ee200000 {
>                 compatible = "renesas,r8a7795-rpc", "renesas,rcar-gen3-rpc";
>                 reg = <0 0xee200000 0 0x200>, <0 0x08000000 0 0x4000000>,
>                       <0 0xee208000 0 0x100>;
> 
> I modified it to "renesas,r8a77995-rpc" because this is Soc I developed and validated.

  Hopefully this matter is cleared up by Geert... :-)

> thanks,
> Mason

MBR, Sergei
