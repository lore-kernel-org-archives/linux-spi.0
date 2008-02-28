From: Phil Wilshire <pwilshire-j9pdmedNgrk@public.gmane.org>
Subject: Re: spi_mmc bus concurrency fix
Date: Thu, 28 Feb 2008 03:15:06 -0500
Message-ID: <47C66D8A.3010904@cox.net>
References: <47C42D50.7020204@rubico.se>
	<200802271036.07909.david-b@pacbell.net> <47C5B084.6050408@cox.net>
	<200802272155.29706.david-b@pacbell.net>
Reply-To: pwilshire-j9pdmedNgrk@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bryan.wu-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org, uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org,
        spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
In-Reply-To: <200802272155.29706.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <http://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

David Brownell wrote:
> On Wednesday 27 February 2008, Phil Wilshire wrote:
>> Thats why I wanted an optional callback after each single transfer.
> 
> That would preclude using chained DMA requests in those cases, but
> presumably that'd be OK in this context.
> 
> 
>> So if you are waiting  for a status byte in the spi data
>> then the callback would add the a small read transfer a few times while 
>> checking the status.
> 
> Just a few?  If you're assuming it would add a new spi_transfer after
> the existing ones in that message ... that could add up to quite a lot
> of additional transfers, presumably ones that are dynamically allocated.
> 
> I've seen some MMC/SD cards need quite a lot of polling there...
> 
> 
>> When it times out (IE reaches a max retry limit) then the transfer can 
>> be halted returning some kind of failure state.
>>
>> If the correct status is found then the next transfer can be the data to 
>> be written  to the device.
>>
>> I thought about the single device queue based in chip select but that 
>> looked a but more complex.
> 
> That is, one queue per device.  Yes, more complicated than one
> shared between devices.  I was just pointing that out as an option
> that could be implemented transparently ... albeit not portably.
> 
> 
>> With the TRANSFER callback we have a good (IMHO) way to modify the 
>> message flow based on the data contents.
>>
>> The complete function may need two arguments. One to hold the SPI
>> Transfer in progress and the other to hold user state
>> (like max read loops and final state).
>>
>> Let me know if this would fit in the "overall formal design" and I'll 
>> stop hacking a custom solution.
> 
> It doesn't seem like the right approach to me.  In the specific use
> case of an MMC interface, three'd be a *LOT* of those callbacks, each
> adding another transfer to the current message.
> 
> And that breaks assumptions like being able to validate entire
> messages before starting to process them, bounded memory use,
> and so on.  I'd far rather see something that does less damage
> to the underlying models.
> 
> - Dave
> 
> 
Hi Dave,

I agree, I did have some concerns about the callback issue.
It also looks like we have enough people + momentum on this problem to
get a fix in good time. So I'll wait to see what happens.

Thanks for the reply
   Phil Wilshire
