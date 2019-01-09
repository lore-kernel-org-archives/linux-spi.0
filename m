From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v5 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 9 Jan 2019 22:23:02 +0100
Message-ID: <fcfcdc30-965e-ec63-17ce-006c500963d9@gmail.com>
References: <1546921020-20436-1-git-send-email-masonccyang@mxic.com.tw>
 <1546921020-20436-2-git-send-email-masonccyang@mxic.com.tw>
 <74a5fba6-a77e-f71b-ce49-405fee8e0fda@cogentembedded.com>
 <CAMuHMdUPsN-VMhbttVK19gL_nPdaCTHHC7Dn3ajPoVhMqDJf_w@mail.gmail.com>
 <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Mason Yang <masonccyang@mxic.com.tw>,
        Mark Brown <broonie@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        juliensu@mxic.com.tw, Simon Horman <horms@verge.net.au>,
        zhengxunli@mxic.com.tw
To: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4373a7f-07c4-baff-30a3-d1f5a294e1bb@cogentembedded.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/9/19 8:04 PM, Sergei Shtylyov wrote:
> On 01/09/2019 09:49 PM, Geert Uytterhoeven wrote:
> 
>>>> Add a driver for Renesas R-Car Gen3 RPC-IF SPI controller.
>>>>
>>>> Signed-off-by: Mason Yang <masonccyang@mxic.com.tw>
>>>
>>>    You now need to add:
>>>
>>> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
>>
>>>> --- a/drivers/spi/Kconfig
>>>> +++ b/drivers/spi/Kconfig
>>>> @@ -544,6 +544,12 @@ config SPI_RSPI
>>>>       help
>>>>         SPI driver for Renesas RSPI and QSPI blocks.
>>>>
>>>> +config SPI_RENESAS_RPC_IF
>>>
>>>    Since the driver is called without -IF suffix, I wouldn't use it in the
>>> Kconfig name either, the following is enough:
>>>
>>>> +     tristate "Renesas R-Car Gen3 RPC-IF SPI controller"
>>>> +     depends on ARCH_RENESAS || COMPILE_TEST
>>>
>>>    Judging on the compilation error reported by the 0-day bot about readq(),
>>> we now need to depend on 64BIT or something...
>>
>> IIRC, this hardware block is also used on RZ/A, which is 32-bit.
> 
>   I'm not seeing it in the "RZ/A1H Group, RZ/A1M Group User’s Manual: Hardware"
> Rev 3.00. What SoC did you have in mind?

At least the GR Peach boots from this block, so that one :)

-- 
Best regards,
Marek Vasut
