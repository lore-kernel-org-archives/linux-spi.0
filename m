From: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
Date: Fri, 16 May 2008 14:51:45 -0600
Message-ID: <fa686aa40805161351r6cc42c4ctb381fc4341fc7cd7@mail.gmail.com>
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	 <20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	 <20080516134720.22d0569b.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, dbrownell@users.sourceforge.net,
	fabrizio.garetto@gmail.com, jonsmirl@gmail.com
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760542AbYEPUv6@vger.kernel.org>
In-Reply-To: <20080516134720.22d0569b.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Fri, May 16, 2008 at 2:47 PM, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Fri, 16 May 2008 13:36:13 -0600 Grant Likely wrote:
>
>> diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
>> index 1d2a772..452c242 100644
>> --- a/Documentation/powerpc/booting-without-of.txt
>> +++ b/Documentation/powerpc/booting-without-of.txt
>> @@ -2870,6 +2871,66 @@ platforms are moved over to use the flattened-device-tree model.
>>               reg = <0xe8000000 32>;
>>       };
>>
>> +    s) SPI (Serial Peripheral Interface) busses
>> +
>> +    SPI busses can be described with a node for the SPI master device
>> +    and a set of child nodes for each SPI slave on the bus.  For this
>> +    discussion, it is assumed that the system's SPI controller is in
>> +    SPI master mode.  This binding does not describe SPI controllers
>> +    in slave mode.
>> +
>> +    The SPI master node requires the following properties:
>> +    - #address-cells  - number of cells required to define a chip select
>> +                     address on the SPI bus.
>> +    - #size-cells     - should be zero.
>> +    - compatible      - name of SPI bus controller following generic names
>> +                     recommended practice.
>> +    No other properties are required in the spi bus node.  It is assumed
>                                               ~~~
>
>> +    that a driver for an SPI bus device will understand that it is an SPI bus.
>> +    However, the binding does not attempt to define the specific method for
>> +    assigning chip select numbers.  Since SPI chip select configuration is
>> +    flexible and non-standardized, it is left out of this binding with the
>> +    assumption that board specific platform code will be used to manage
>> +    chip selects.  Individual drivers can define additional properties to
>> +    support describing the chip select layout.
>> +
>> +    SPI slave nodes must be children of the spi master node and can
>                                               ~~~
>
>> +    contain the following properties.
>> +    - reg             - (required) chip select address of device.
>> +    - compatible      - (required) name of SPI device following generic names
>> +                     recommended practice
>> +    - max-speed       - (optional) Maximum SPI clocking speed of device in Hz
>> +    - spi,cpol        - (optional) Device requires inverse clock polarity
>> +    - spi,cpha        - (optional) Device requires shifted clock phase
>> +    - linux,modalias  - (optional, Linux specific) Force binding of SPI device
>> +                     to a particular spi_device driver.  Useful for changing
>> +                     driver binding between spidev and a kernel spi driver.
>                                                                   ~~~
>
> Hi,
> You mostly capitalize "SPI" in sentences (i.e., when it's not part of
> a function name or OF data), so could the 3 underlined instances of it
> also be all caps?

No problem.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
