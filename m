From: Stefan Agner <stefan-XLVq0VzYD2Y@public.gmane.org>
Subject: Re: [PATCH v2] spi-fsl-dspi: Fix CTAR Register access
Date: Thu, 10 Dec 2015 08:38:05 -0800
Message-ID: <864d33fc96f58cf0801b773ba75845e2@agner.ch>
References: <1449726930-7378-1-git-send-email-bhuvanchandra.dv@toradex.com>
 <2295258.Vc5Dp4nsCT@ws-stein> <56693B5B.6060100@toradex.com>
 <120830674.SMntmZQuCR@ws-stein>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <120830674.SMntmZQuCR@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 2015-12-10 01:06, Alexander Stein wrote:
> On Thursday 10 December 2015 14:14:11, Bhuvanchandra DV wrote:
>> On 12/10/2015 12:45 PM, Alexander Stein wrote:
>> > On Thursday 10 December 2015 11:25:30, Bhuvanchandra DV wrote:
>> >> DSPI instances in Vybrid have a different amount of chip selects
>> >> and CTARs (Clock and transfer Attributes Register). In case of
>> >> DSPI1 we only have 2 CTAR registers and 4 CS. In present driver
>> >> implementation CTAR offset is derived from CS instance which will
>> >> lead to out of bound access if chip select instance is greater than
>> >> CTAR register instance, hence use single CTAR0 register for all CS
>> >> instances. Since we write the CTAR register anyway before each access,
>> >> there is no value in using the additional CTAR registers. Also one
>> >> should not program a value in CTAS for a CTAR register that is not
>> >> present, hence configure CTAS to use CTAR0.
>> >
>> > Shouldn't the information put into struct fsl_dspi_devtype_data how much CTAR and CS the actual implementation has available? E.g. LS1021A has 6 CS and 4 CTAR
>>
>> I guess still this will not help us when CS instance greater than CTAR
>> instance is selected. Other point to consider here is we are writing the
>> CTAR register before every access, so for us there is no additional
>> advantage of using multiple CTAR registers.
> 
> Please have a look at 5cc7b04740effa5cc0af53f434134b5859d58b73 which
> addresses this problem for the 4 CTAR and 6 CS case.
> I'm unsure how multiple CTAR will help at all. But at the end the
> amount of CS seems to be different for different implementations. So
> this still needs to be added to fsl_dspi_devtype_data.

IMO the multiple CTAR registers are only really helpful for
bare-metal/microcontroller kind of application where you want to safe
every register write. The Kernel anyway writes the register before each
transfer, so there is no value making use of the multiple registers...

By just using the first CTAR, it is not required to have the amount of
CS around, the SPI frameowork takes care of assigning the CS, and that
is all what is needed...

--
Stefan
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
