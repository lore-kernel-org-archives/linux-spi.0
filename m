From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
 controller bindings
Date: Wed, 5 Dec 2018 13:53:16 +0100
Message-ID: <4976dae8-222f-b7a1-ca5b-4abf3c5f26db@gmail.com>
References: <1543828720-18345-1-git-send-email-masonccyang@mxic.com.tw>
 <1543828720-18345-3-git-send-email-masonccyang@mxic.com.tw>
 <2e719883-4cfd-b456-b894-853e99515092@gmail.com>
 <OF71F19EC8.23C369C1-ON4825835A.002EB699-4825835A.002F949D@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Cc: boris.brezillon@bootlin.com, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF71F19EC8.23C369C1-ON4825835A.002EB699-4825835A.002F949D@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 12/05/2018 09:39 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2018/12/05 ¤W¤È 10:04
>>
>> To
>>
>> "Mason Yang" <masonccyang@mxic.com.tw>, broonie@kernel.org, linux-
>> kernel@vger.kernel.org, linux-spi@vger.kernel.org,
>> boris.brezillon@bootlin.com, linux-renesas-soc@vger.kernel.org,
>> "Geert Uytterhoeven" <geert+renesas@glider.be>,
>>
>> cc
>>
>> juliensu@mxic.com.tw, "Simon Horman" <horms@verge.net.au>,
>> zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v2 2/2] dt-binding: spi: Document Renesas R-Car Gen3 RPC
>> controller bindings
>>
>> On 12/03/2018 10:18 AM, Mason Yang wrote:
>> > Document the bindings used by the Renesas R-Car Gen3 RPC SPI controller.
>>
>> RPC is SPI and HF controller, it is not a pure SPI controller.
>>
>> How does this deal with the HF part ? Keep in mind the bindings are ABI
>> and it will be difficult to redo them later.
> 
> After checking HF datasheet,
> 512_MBIT_256_MBIT_128_MBIT_HYPERFLASH_FAMILY_Datasheet.pdf.
> 
> 
> 
> From my point of view,
> HyperFlash is a kind of standard NOR Flash with high-speed SPI interface.
> But I might be wrong.
It behaves as a Parallel CFI NOR internally, and so it fits and works
with the CFI NOR drivers (see the U-Boot driver), except the interface
between the HF controller and the chip is custom. It's not SPI per-se.

-- 
Best regards,
Marek Vasut
