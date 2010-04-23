From: H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org>
Subject: Re: SPI-ADC
Date: Fri, 23 Apr 2010 11:58:58 -0500
Message-ID: <0D753D10438DA54287A00B0270842697636D941949@AUSP01VMBX24.collaborationhost.net>
References: <o2idc6d3181004212320neaf99b0az27938c369e1a5557@mail.gmail.com>
	<0D753D10438DA54287A00B0270842697636D940B1C@AUSP01VMBX24.collaborationhost.net>
	<y2tdc6d3181004222208uf6f4a9ecl7d0e2f084fd56a08@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org" <hskinnemoen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
To: arjun rath <rath.arjun-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <y2tdc6d3181004222208uf6f4a9ecl7d0e2f084fd56a08-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thursday, April 22, 2010 10:09 PM, arjun rath wrote:
> Hi ,

Please do a reply-all to keep the thread on the lists.  Also, please
do not top-post.  I fixed both here...

> On Thu, Apr 22, 2010 at 9:53 PM, H Hartley Sweeten <hartleys-3FF4nKcrg1dE2c76skzGb0EOCMrvLtNR@public.gmane.org> wrote:
>> On Wednesday, April 21, 2010 11:20 PM, arjun rath wrote:
>>> Hi Everybody,
>>>
>>> I am using a SPI based 12 bit adc(max1241) from maxim.I am trying to read
>>> the value from adc  using spi_read() in linux kernel.But every time i used
>>> to read i am getting *0xff* only.(i have to read two consecutive bytes).To
>>> the adc chip i am probing with CRO which always shows DOUT pin of ADC as
>>> high provided the input to ADC is always 1.1 volt.
>>> And the clock is also coming as seen in the CRO with Chip select line going
>>> low.
>>>
>>> Is it a delay problem since for adc's we have to wait for sometime for
>>> conversion of data....????
>>>
>>> Can anybody give some suggestion regarding this....
>>	
>> According to the datasheet, to start a conversion with the max124[0|1] you
>> need to pull the chip select low.  At the falling edge the T/H enters its
>> Hold mode and a conversion is initiated.  During this time the ADC will keep
>> the DOUT pin pulled low and the SCLK must be kept low during the conversion.
>> The end of conversion is signaled by DOUT going high.  At this point the
>> data can be shifted out with the SCLK signal.
>>	
>> It appears the SPI API is supposed to support this with the SPI_READY mode
>> flag.  But, the only SPI master driver in mainline that supports this flag
>> is the davinci_spi driver.
	
> Thanks for the reply.
>
> You mean to say with atmel spi master it is not possible(at91sam9263)...
> and to start the conversation i am pulling the chip select line low...

Looking at the atmel_spi driver it appears that it currently does not
support the SPI_READY mode.  So yes, with the driver as it is now it will
not work correctly with the max124[0|1] parts.

> Is it possible that i can write the serial protocol procedure what ever
> given in the datasheet instead of spi.

The max124[0|1] is still a spi device so using the atmel_spi driver is
the correct route.  You just need to add the necessary support to the
driver to handle the SPI_READY mode.

I added the author, Haavard Skinnemoen, to the Cc list to see if he has any
ideas to help.

Regards,
Hartley



------------------------------------------------------------------------------
