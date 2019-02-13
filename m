From: Marek Vasut <marek.vasut@gmail.com>
Subject: Re: Applied "spi: Add Renesas R-Car Gen3 RPC-IF SPI controller
 driver" to the spi tree
Date: Wed, 13 Feb 2019 13:37:31 +0100
Message-ID: <acb7940e-df38-97a7-8500-4825fb0f6604@gmail.com>
References: <20190212142236.2807D1128113@debutante.sirena.org.uk>
 <4f91497a-96ee-4c10-436f-4d011edb3834@gmail.com>
 <20190212144359.GD20635@sirena.org.uk> <20190212164940.GI20635@sirena.org.uk>
 <OF9C8DA179.15D69C0A-ON482583A0.00283EB5-482583A0.002E45C8@mxic.com.tw>
 <20190213121635.GD7540@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: bbrezillon@kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        zhengxunli@mxic.com.tw
To: Mark Brown <broonie@kernel.org>, masonccyang@mxic.com.tw
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190213121635.GD7540@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 2/13/19 1:16 PM, Mark Brown wrote:
> On Wed, Feb 13, 2019 at 04:25:32PM +0800, masonccyang@mxic.com.tw wrote:
> 
>> From current mainline branch, MFD seems support the device which is on 
>> the same hardware bus(i.e, I2C, SPI, MMIO and SPMI)for multi-function 
>> by Read/Write the common same registers.
> 
> That's most MFDs but there are some that do some level of enumeration
> (even if it's just looking at the device ID that got registered) to
> decide what subdevices get registered, that's what people are suggesting
> here I think.

Right. Although I think some of the code could be shared between the SPI
and HF modes.

>> I am checking and not sure if MMIO of MFD could support RPC-IF for 
>> different hardware bus on SPI and CFI.
>> I also doubt if this method is a correct solution for RPC-IF works
>> either in SPI mode or CFI mode.
> 
> For MMIO devices MFD just passes through the parent resources.
> 


-- 
Best regards,
Marek Vasut
