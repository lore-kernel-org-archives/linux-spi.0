From: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2/2] SPI: spi-gpio: Add DT bindings
Date: Wed, 25 Jul 2012 14:17:15 +0200
Message-ID: <500FE3CB.9020902@gmail.com>
References: <1343216652-1463-1-git-send-email-zonque@gmail.com>
	<1343216652-1463-2-git-send-email-zonque@gmail.com>
	<20120725121131.GA2628@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
To: Wolfram Sang <w.sang-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120725121131.GA2628-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 25.07.2012 14:11, Wolfram Sang wrote:
> On Wed, Jul 25, 2012 at 01:44:12PM +0200, Daniel Mack wrote:
>> This patch adds DT bindings to the spi-gpio driver and some
>> documentation about how to use it.
>>
>> Signed-off-by: Daniel Mack <zonque-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> ---
>>  Documentation/devicetree/bindings/spi/spi-gpio.txt |   29 ++++++
>>  drivers/spi/spi-gpio.c                             |   99 +++++++++++++++++++-
>>  2 files changed, 125 insertions(+), 3 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/spi/spi-gpio.txt
>>
>> diff --git a/Documentation/devicetree/bindings/spi/spi-gpio.txt b/Documentation/devicetree/bindings/spi/spi-gpio.txt
>> new file mode 100644
>> index 0000000..8a824be
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/spi/spi-gpio.txt
>> @@ -0,0 +1,29 @@
>> +SPI-GPIO devicetree bindings
>> +
>> +Required properties:
>> +
>> + - compatible: should be set to "spi-gpio"
>> + - #address-cells: should be set to <0x1>
>> + - ranges
>> + - gpio-sck: GPIO spec for the SCK line to use
>> + - gpio-miso: GPIO spec for the MISO line to use
>> + - gpio-mosi: GPIO spec for the MOSI line to use
>> + - cs-gpios: GPIOs to use for chipselect lines
>> + - num-chipselects: number of chipselect lines
>> +
>> +Example:
>> +
>> +	spi {
>> +		compatible = "spi-gpio";
>> +		#address-cells = <0x1>;
>> +		ranges;
>> +
>> +		gpio-sck = <&gpio 95 0>;
>> +		gpio-miso = <&gpio 98 0>;
>> +		gpio-mosi = <&gpio 97 0>;
>> +		cs-gpios = <&gpio 125 0>;
>> +		num-chipselects = <1>;
> 
> Can't we use of_gpio_named_count() instead of this property?

I thought so too, but it's probably also a good idea to keep this driver
in line to what other drivers do, no? Anyway, I can of course change it
if desired.

>> +
>> +		/* clients */
> 
> Minor: A simple example is helpful for people new to devicetree as I
> experienced in the last days.

Hmm, aren't there enough examples in a) the full dts files in the kernel
and b) in the documenation of spi clients?


Thanks,
Daniel


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
