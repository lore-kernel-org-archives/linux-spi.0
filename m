From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: spi-gpio: Add DT bindings
Date: Wed, 25 Jul 2012 14:35:46 +0200
Message-ID: <500FE822.5050309@gmail.com>
References: <1343216652-1463-1-git-send-email-zonque@gmail.com>
	<1343216652-1463-2-git-send-email-zonque@gmail.com>
	<20120725121131.GA2628@pengutronix.de> <500FE3CB.9020902@gmail.com>
	<20120725123244.GB2628@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org,
	Shawn Guo <shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120725123244.GB2628-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 25.07.2012 14:32, Wolfram Sang wrote:
> 
>>>> +Example:
>>>> +
>>>> +	spi {
>>>> +		compatible = "spi-gpio";
>>>> +		#address-cells = <0x1>;
>>>> +		ranges;
>>>> +
>>>> +		gpio-sck = <&gpio 95 0>;
>>>> +		gpio-miso = <&gpio 98 0>;
>>>> +		gpio-mosi = <&gpio 97 0>;
>>>> +		cs-gpios = <&gpio 125 0>;
>>>> +		num-chipselects = <1>;
>>>
>>> Can't we use of_gpio_named_count() instead of this property?
>>
>> I thought so too, but it's probably also a good idea to keep this driver
>> in line to what other drivers do, no?
> 
> I'd prefer to drop it unless there is a real need for it. CCing Shawn to
> ask why "fsl,spi-num-chipselects" was added to the spi-imx driver
> instead of using of_gpio_{named_}count(). Was there a reason?
> 
>>>> +
>>>> +		/* clients */
>>>
>>> Minor: A simple example is helpful for people new to devicetree as I
>>> experienced in the last days.
>>
>> Hmm, aren't there enough examples in a) the full dts files in the kernel
>> and b) in the documenation of spi clients?
> 
> Many, yes; enough, don't know :) I just experienced that people
> missed this information in some of the i2c host controller binding
> descriptions, despite it was available elsewhere.

I would rather say specific examples in the documenation for generic bus
drivers cause more confusion than they clear :)


Daniel


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
