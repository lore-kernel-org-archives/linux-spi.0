From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver
Date: Wed, 30 Jan 2019 08:15:25 +0100
Message-ID: <e4351834-5c7d-b751-b3c7-97dce5207783@gmail.com>
References: <1548227352-14910-1-git-send-email-masonccyang@mxic.com.tw>
 <1548227352-14910-2-git-send-email-masonccyang@mxic.com.tw>
 <bb63b646-b549-dc3b-a604-17ba156e735c@gmail.com>
 <OF767ACC95.EECC73BE-ON4825838C.000BD6A3-4825838C.000D23A6@mxic.com.tw>
 <67fa5f94-886b-f09c-c93d-832e427ffec8@gmail.com>
 <OF891E176A.614DBEEF-ON4825838C.0022D454-4825838C.002396ED@mxic.com.tw>
 <0b3ea94f-a4f3-0780-301b-f88ff2ad2fb1@gmail.com>
 <OFEAAE10B4.20C3E45D-ON48258390.0007CD37-48258390.0009066E@mxic.com.tw>
 <2d762c16-d714-9171-9450-b6adf1a6509c@gmail.com>
 <OF1DC7FF88.3574E5B9-ON48258391.000A5001-48258391.000D5DDE@mxic.com.tw>
 <a0f86e7c-dd16-f3fa-5387-b0da6900975c@gmail.com>
 <OFA6EF1EB2.198B44D0-ON48258392.00099520-48258392.000D03A4@mxic.com.tw>
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
In-Reply-To: <OFA6EF1EB2.198B44D0-ON48258392.00099520-48258392.000D03A4@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 1/30/19 3:22 AM, masonccyang@mxic.com.tw wrote:
> Hi Marek,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/01/29 下午 12:45
>>
>> To
>>
>> masonccyang@mxic.com.tw,
>>
>> cc
>>
>> bbrezillon@kernel.org, broonie@kernel.org, "Geert Uytterhoeven"
>> <geert+renesas@glider.be>, "Simon Horman" <horms@verge.net.au>,
>> juliensu@mxic.com.tw, linux-kernel@vger.kernel.org, linux-renesas-
>> soc@vger.kernel.org, linux-spi@vger.kernel.org,
>> sergei.shtylyov@cogentembedded.com, zhengxunli@mxic.com.tw
>>
>> Subject
>>
>> Re: [PATCH v7 1/2] spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
> driver
>>
>> On 1/29/19 3:26 AM, masonccyang@mxic.com.tw wrote:
>> > Hi Marek,
>>
>> Hi,
>>
>> >> >> "Marek Vasut" <marek.vasut@gmail.com>
>> >> >> >> >> > +module_platform_driver(rpc_spi_driver);
>> >> >> >> >>
>> >> >> >> >> RPC is not a SPI controller, it's a SPI and HF controller.
>> >> >> >> >>
>> >> >> >> >> Also, how difficult will it be to add the HF support ?
>> >> >> >> >
>> >> >> >> > One of my customers needs RPC SPI driver for our company's
>> >> >> >> > Octal-Flash,MX25UW51245G.
>> >> >> >> > We don't have HF product and hope you could understanding.
>> >> >> >>
>> >> >> >> I am worried that when we need to add RPC HF support (which is
>> > what all
>> >> >> >> boards but the D3 Draak use), we will have to rewrite the entire
>> > driver
>> >> >> >> and/or convert it to MFD and that would be a tremendous
>> >> > undertaking. I'd
>> >> >> >> prefer to have the driver ready for the HF addition before it's
>> >> > accepted
>> >> >> >> upstream.
>> >> >> >>
>> >> >> >
>> >> >> > I think maybe your concerned would be happened only if HF driver
>> >> > goes with
>> >> >> > spi-mem layer.
>> >> >> >
>> >> >> > A comment for HF from Daniel Fishman. FYR.
>> >> >> >
>> >> >> > https://www.quora.com/What-is-a-hyper-flash-memory-and-how-is-it-
>> >> >> different-from-normal-flash-memory
>> >> >>
>> >> >> I have a decent idea what HF and SPI NOR are, since I wrote the RPC
>> >> >> driver for both HF and SPI mode for U-Boot (as I mentioned earlier).
>> >> >>
>> >> >> The HF in Linux would use the CFI NOR part of MTD framework. My
> concern
>> >> >> is that when we need to add HF support into this driver, this driver
>> >> >> will have to be basically rewritten, since the architecture
> won't allow
>> >> >> for that. I'd like to avoid that, since the majority of Gen3 boards,
>> >> >> expect for the D3 Draak, use RPC in HF mode.
>> >> >
>> >> > FYI~
>> >> >
>> >> > MX25UW51245g(64MByte Octa)                      S26KL512S(64MByte HF)
>> >> >    8 IO                                                  8 IO
>> >> > 200MHz DDR@1.8v                                   166MHz DDR@1.8v
>> >> >
>> >> > support Read-while-write                       Not support
>> >> > good for OTA,etc
>> >> > powerful application
>> >>
>> >> What does that mean ?
>> >
>> > I have no idea why would you say "since the majority of Gen3 boards use
>> > RPC in HF mode" ?
>>
>> Well, the H3/M3W/M3N S-X(S) and the H3/M3 ULCB and E3 Ebisu all boot
>> from HF. Only the D3 Draak uses QSPI NOR.
> 
> It's understandable because mx25uw51245g is a new product and it has been
> adopted by Renesas’ Automotive Instrument Cluster RH850/D1M1A MCU.

The aforementioned boards are not going away however. There's too many
users to ignore those.

> We also have patched R-Car's BL for booting from Octa-Flash as bellow log:
> 
> NOTICE:  BL2: R-Car D3 Initial Program Loader(CA53) Rev.0.5.1
> NOTICE:  BL2: PRR is R-Car D3 Ver1.0
> NOTICE:  BL2: Boot device is MXIC_OctaFlash
> NOTICE:  BL2: LCM state is CM
> NOTICE:  BL2: DDR3L-1866(rev.0.02)
> NOTICE:  BL2: QoS is default setting(rev.0.07)
> NOTICE:  BL2: v1.3(release):
> NOTICE:  BL2: Built : 09:56:31, Sep 26 2018
> NOTICE:  BL2: Normal boot
> NOTICE:  BL2: dst=0xe63111f0 src=0x8180000 len=512(0x200)
> NOTICE:  BL2: dst=0x43f00000 src=0x8180400 len=6144(0x1800)
> NOTICE:  BL2: dst=0x44000000 src=0x81c0000 len=65536(0x10000)
> NOTICE:  BL2: dst=0x50000000 src=0x8640000 len=1048576(0x100000)

This looks like a very old ATF version. Anyway, please submit those
patches upstream, they should be generic.

>> > So far as I know that HF is provided by Cypress only and
>> > any mass production product use the component which is provided by only
>> > one provider
>> > will be a big risk.
>> >
>> > Compare to HF, there are more provider of SPI/Octa could support the
>> > mass production product
>> > as their second provider.
>> >
>> > In addition, from the technical points of view, mx25uw51245g is more
>> > powerful than HF and
>> > good for complicate user application, i.e., OTA and so on.
>>
>> Did you consider protocol overhead too ? I don't think you can compare
>> them just by raw numbers of pins and bus frequency.
>>
>> Note that over-the-air update (if that's what you mean by OTA) is
>> completely separate from the underlying storage device.
> 
> It's key feature of mx25uw51245g supports Read-while-Write capability
> that allows read access from one memory bank while writing to another
> memory bank.

Note that this sales pitch is rather off-topic.

>> > I think customer have more choice for their flash memory component.
>> Note that none of this is really relevant to my concerns above regarding
>> HF support. This driver should be implemented as MFD driver and the SPI
>> part should use the MFD core part , just like the future HF part.
>>
> 
> Even though they are both internal NOR memory chip, is it a trend of Kernel
> for the different HW controller and protocol ?

I'm not sure I understand the question, but the HF behaves like a CFI
NOR, that's why it should be operated via the CFI part of the MTD
framework. The SPI NOR behaves, well, like a SPI NOR and so should be
operated via the SPI NOR part of the MTD framework.

However, a lot of the code operating the RPC is common for the HF and
SPI NOR modes, which is why that part should be a MFD driver or some
common core driver.

> What about others,i.e., raw-NAND and spi-NAND ?

I don't think the RPC supports those, does it ?

> oh, a little bit leaving the topic !
> anyway, nice to talk to you about this R-Car Gen3 RPC driver.
[...]

-- 
Best regards,
Marek Vasut
