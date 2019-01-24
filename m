From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Thu, 24 Jan 2019 04:13:11 +0100
Message-ID: <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/24/19 3:23 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/24 上午 09:54
>>
>>
>> > +#define RPC_CMNCR      0x0000   // R/W
>>
>> Is there any reason for using those horrible C++ comments ?
> 
> By Mark's comments for the SPDX header needs to be C++ style and
> I patch the whole RPC driver comments using C++ style otherwise it looks
> messy.

I think the C++ comments should only be applied to the SPDX identifier,
maybe the header, but not the entire file.

>> [...]
>>
>> > +module_platform_driver(rpc_spi_driver);
>>
>> RPC is not a SPI controller, it's a SPI and HF controller.
>>
>> Also, how difficult will it be to add the HF support ?
> 
> One of my customers needs RPC SPI driver for our company's
> Octal-Flash,MX25UW51245G.
> We don't have HF product and hope you could understanding.

I am worried that when we need to add RPC HF support (which is what all
boards but the D3 Draak use), we will have to rewrite the entire driver
and/or convert it to MFD and that would be a tremendous undertaking. I'd
prefer to have the driver ready for the HF addition before it's accepted
upstream.

-- 
Best regards,
Marek Vasut
