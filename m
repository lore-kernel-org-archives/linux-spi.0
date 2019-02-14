From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Date: Thu, 14 Feb 2019 11:52:25 +0100
Message-ID: <0f26ffa5-e517-742f-ebd3-0093eda27145@gmail.com>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk> <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
 <20190213121635.GD7540@sirena.org.uk>
 <acb7940e-df38-97a7-8500-4825fb0f6604@gmail.com>
 <OF9B3A3A20.C0BF34B8-ON482583A1.002D5F3B-482583A1.00329653@mxic.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8bit
Cc: bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
To: masonccyang@mxic.com.tw, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <OF9B3A3A20.C0BF34B8-ON482583A1.002D5F3B-482583A1.00329653@mxic.com.tw>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2/14/19 10:12 AM, masonccyang@mxic.com.tw wrote:
> Hi,

Hi,

>> "Marek Vasut" <marek.vasut@gmail.com>
>> 2019/02/13 ¤U¤È 08:37
>>
>> On 2/13/19 1:16 PM, Mark Brown wrote:
>> > On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:
>> >
>> >> From current mainline branch, MFD seems support the device which is on
>> >> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function
>> >> by Read/Write the common same registers.
>> >
>> > That's most MFDs but there are some that do some level of enumeration
>> > (even if it's just looking at the device ID that got registered) to
>> > decide what subdevices get registered, that's what people are suggesting
>> > here I think.
>>
>> Right. Although I think some of the code could be shared between the SPI
>> and HF modes.
> 
> If it is right that MFD is based on the same hardware bus for multi
> function
> device,i.e,. based on SPI/I2C/PCI bus to register device by
> mfd_add_devices().
> 
> For a multi function device works on different hardware bus, it has nothing
> to do with mfd-core.c(MFD framework) even though their driver are in
> drivers/mfd directory, i.e,. mcp-core.x, sm501.c.
> 
> Since RPC-IF works on different hardware bus for SPI bus or CFI
> HyperFlash bus,
> is it a good idea to implement MFD framework for RPC-IF ?
> Or we just separate RPC-IF driver by spi mode and cfi mode ?
> 
> any comments/opinions on RPC-IF/MFD-framework is welcome!

Mark mentioned it before, you can use the MFD for MMIO too.
The goal here is to have some common code which is shared by the SPI and
HF part of the driver, and then a separate SPI handling code and HF
handling code. The common code should determine which part to activate
based on the DT.

-- 
Best regards,
Marek Vasut
