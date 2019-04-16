From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Subject: Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller
 driver
Date: Tue, 16 Apr 2019 21:57:30 +0300
Message-ID: <770002ab-7e08-b695-b5a5-fce772b600a5@cogentembedded.com>
References: <1555313834-15107-1-git-send-email-masonccyang@mxic.com.tw>
 <1555313834-15107-2-git-send-email-masonccyang@mxic.com.tw>
 <935046cc-e2e5-b9b8-0c94-1be5ae604276@cogentembedded.com>
 <OF8A9D093C.B3035121-ON482583DE.00065F23-482583DE.00074AC0@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org,
        marek.vasut@gmail.com, mark.rutland@arm.com, robh+dt@kernel.org
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF8A9D093C.B3035121-ON482583DE.00065F23-482583DE.00074AC0@mxic.com.tw>
Content-Language: en-MW
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/16/2019 04:19 AM, masonccyang@mxic.com.tw wrote:

>> Re: [PATCH v10 1/3] mfd: Add Renesas R-Car Gen3 RPC-IF MFD controller driver
>>
>> The patch name is somewhat misleading -- there's no "MFD controller".
> 
> Can't get your point ?
> 
> RPC-IF support SPI and HF, it's a MFD controller and
> that's why I patch it to MFD as Marek's comments.

   I'd like the "controller" word dropped, as MFD stands for multi-function device
anyway. "Controller" seems to be superfluous here...

>> On 04/15/2019 10:37 AM, Mason Yang wrote:
>>
>> > Add a driver for Renesas R-Car Gen3 RPC-IF MFD controller.
>> >
>> > Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>> [...]
>> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> > index 26ad646..7914349 100644
>> > --- a/drivers/mfd/Kconfig
>> > +++ b/drivers/mfd/Kconfig
>> > @@ -978,6 +978,15 @@ config MFD_RDC321X
>> >       southbridge which provides access to GPIOs and Watchdog using the
>> >       southbridge PCI device configuration space.
>> >  
>> > +config MFD_RENESAS_RPC
>> > +   tristate "Renesas R-Car Gen3 RPC-IF MFD driver"
>> > +   select MFD_CORE
>> > +   depends on ARCH_RENESAS
>> > +   help
>> > +     This supports for Renesas R-Car Gen3 RPC-IF multifunction device
>>
>>    "For" node needed here.
> 
> ?

   Sorry, that was a typo: s/node/not/.

>> [...]
>> > diff --git a/include/linux/mfd/renesas-rpc.h b/include/linux/mfd/
>> renesas-rpc.h
>> > new file mode 100644
>> > index 0000000..61ada14
>> > --- /dev/null
>> > +++ b/include/linux/mfd/renesas-rpc.h
>> > @@ -0,0 +1,153 @@
>> > +// SPDX-License-Identifier: GPL-2.0
>> > +//
>> > +// Copyright (C) 2018 ~ 2019 Renesas Solutions Corp.
>> > +// Copyright (C) 2019 Macronix International Co., Ltd.
>> > +//
>> > +// R-Car Gen3 RPC-IF MFD driver
>> > +//
>> > +// Author:
>> > +//   Mason Yang <masonccyang@mxic.com.tw>
>> > +//
>> > +
>> > +#ifndef __MFD_RENESAS_RPC_H
>> > +#define __MFD_RENESAS_RPC_H
>> > +
>> > +#include <linux/clk.h>
>> > +#include <linux/io.h>
>> > +#include <linux/log2.h>
>> > +#include <linux/iopoll.h>
>> > +#include <linux/module.h>
>> > +#include <linux/mtd/mtd.h>
>> > +#include <linux/platform_device.h>
>> > +#include <linux/pm_runtime.h>
>> > +#include <linux/of.h>
>> > +#include <linux/regmap.h>
>> > +#include <linux/reset.h>
>>
>>    NAK. I have already told you that these #include's are only needed in the
>> drivers, not in this header.
> 
> why ?

   Why what? As a rule of thumb, we #include only headers necessary to build
the file in question.

> I think these #include files are still needed in HyperFlash driver.

   Hopefully not. Though that doesn't really matter much.

> i.e,. clk controller, mtd and so on.
> 
>>
>>    My idea is to contain all hardware manipulation in the MFD driver,
>> with SPI/HF drivers calling that code via a set of APIs declared in
>> this header.
>> The registers (declared below) would end up only needed by that
>> common MFD driver...
> 
> best regards,
> Mason

MBR, Sergei
