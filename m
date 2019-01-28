From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Mon, 28 Jan 2019 12:03:00 +0100
Message-ID: <2d762c16-d714-9171-9450-b6adf1a6509c@gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
 <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
 <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
 <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
 <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org, broonie@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org, sergei.shtylyov@cogentembedded.com,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/28/19 2:38 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> >> >> > +module_platform_driver(rpc_spi_driver);
>> >> >>
>> >> >> RPC is not a SPI controller, it's a SPI and HF controller.
>> >> >>
>> >> >> Also, how difficult will it be to add the HF support ?
>> >> >
>> >> > One of my customers needs RPC SPI driver for our company's
>> >> > Octal-Flash,MX25UW51245G.
>> >> > We don't have HF product and hope you could understanding.
>> >>
>> >> I am worried that when we need to add RPC HF support (which is what all
>> >> boards but the D3 Draak use), we will have to rewrite the entire driver
>> >> and/or convert it to MFD and that would be a tremendous
> undertaking. I'd
>> >> prefer to have the driver ready for the HF addition before it's
> accepted
>> >> upstream.
>> >>
>> >
>> > I think maybe your concerned would be happened only if HF driver
> goes with
>> > spi-mem layer.
>> >
>> > A comment for HF from Daniel Fishman. FYR.
>> >
>> > https://www.quora.com/What-is-a-hyper-flash-memory-and-how-is-it-
>> different-from-normal-flash-memory
>>
>> I have a decent idea what HF and SPI NOR are, since I wrote the RPC
>> driver for both HF and SPI mode for U-Boot (as I mentioned earlier).
>>
>> The HF in Linux would use the CFI NOR part of MTD framework. My concern
>> is that when we need to add HF support into this driver, this driver
>> will have to be basically rewritten, since the architecture won't allow
>> for that. I'd like to avoid that, since the majority of Gen3 boards,
>> expect for the D3 Draak, use RPC in HF mode.
> 
> FYI~
> 
> MX25UW51245g(64MByte Octa)                      S26KL512S(64MByte HF)
>    8 IO                                                  8 IO
> 200MHz DDR@1.8v                                   166MHz DDR@1.8v
> 
> support Read-while-write                       Not support
> good for OTA,etc
> powerful application

What does that mean ?

-- 
Best regards,
Marek Vasut
