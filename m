From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus number.
Date: Tue, 24 May 2016 13:41:26 -0700
Message-ID: <5744BC76.9090403@gmail.com>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se> <20160524174140.GE11605@leverpostej>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Christer Weinigel <christer@weinigel.se>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, Mark Brown <broonie@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160524174140.GE11605@leverpostej>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 5/24/2016 10:41 AM, Mark Rutland wrote:
> On Tue, May 24, 2016 at 06:39:20PM +0200, Christer Weinigel wrote:
>> Document how to use devicetree aliases to assign a stable
>> bus number to a spi bus.
>>
>> Signed-off-by: Christer Weinigel <christer@weinigel.se>
>>
>> ---
>>
>> Trivial documentation change.
>>
>> Not having used devicetree that much it was surprisingly hard to
>> figure out how to assign a stable bus number to a spi bus.  Add a
>> simple example that shows how to do that.
>>
>> Mark Cced as the SPI maintainer.  Or should trivial documentation
>> fixes like this be addressed to someone else?
>>
>>   /Christer
>>
>>  Documentation/devicetree/bindings/spi/spi-bus.txt | 10 ++++++++++
>>  1 file changed, 10 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> index 42d5954..c35c4c2 100644
>> --- a/Documentation/devicetree/bindings/spi/spi-bus.txt
>> +++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
>> @@ -94,3 +94,13 @@ SPI example for an MPC5200 SPI bus:
>>  			reg = <1>;
>>  		};
>>  	};
>> +
>> +Normally SPI buses are assigned dynamic bus numbers starting at 32766
>> +and counting downwards.  It is possible to assign the bus number
>> +statically using devicetee aliases.  For example, on the MPC5200 the
>> +"spi@f00" device above is connected to the "soc" bus.  To set its
>> +bus_num to 1 add an aliases entry like this:
> 
> As Mark Brown pointed out, this is very Linux-specific (at least in the
> wording of the above).

Yes, Linux-specific.  So the Linux documentation of bindings is the
correct place for it.

> 
> Generally, aliases are there to match _physical_ identifiers (e.g. to
> match physical labels for UART0, UART1, and on).
> 
> I'm not sure whether that applies here.

The code and behavior is in the Linux kernel.  It should be visible in
the documentation instead of being a big mystery of how it works.

> 
> Thanks,
> Mark.
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
