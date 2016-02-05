From: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: pxa2xx: Fix too early chipselect deassert
Date: Fri, 5 Feb 2016 09:38:29 +0200
Message-ID: <56B45175.8090101@linux.intel.com>
References: <1454581857-12921-1-git-send-email-jarkko.nikula@linux.intel.com>
 <1454581857-12921-2-git-send-email-jarkko.nikula@linux.intel.com>
 <874mdo5gwm.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <874mdo5gwm.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 02/04/2016 11:01 PM, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
>
>> There is a chance that chipselect is deasserted too early while the last
>> clock cycle is still running. Protocol analyzers will see this as a failed
>> last byte. This is more likely to occur with slow bitrates, for instance
>> at 25 kbps.
>>
>> Reason for this is when using SPI mode 0 that both SPI host controller and
>> SPI slave will drive the data lines at the falling edge of clock signal
>> and sample at the rising edge. Receive FIFO gets the last bit now at the
>> rising edge and code sees transfer to be finished either by the interrupt
>> in PIO mode or by the DMA completion in DMA mode.
>>
>> The SSP Time Out register SSTO should take care of delaying the
>> completion but it does not seems to have effect at least on Intel
>> Skylake and Broxton even when using long enough values. Depending on
>> timing code may get into point where chipselect is deasserted while the
>> last clock cycle is still running at its second half cycle.
>>
>> Fix this by adding a wait loop in giveback() that waits until SSP becomes
>> idle before deasserting the chipselect.
>>
>> Reported-by: Weifeng Voon <weifeng.voon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> ---
>> For normal development cycle. This is not a fatal issue and I guess real SPI
>> slaves may not hickup because of it. But you never know.
>
> I feel quite nervous about this one, as it will affect all pxa variants, for a
> Skylake and Broxton issues.
>
> What makes me even more nervous is that I don't have a way to test it yet ...
>
> I will neither ack nor block it, let's have others judge it first.
>
I didn't see reason to do this conditionally as pxa2xx_spi_flush() is 
polling the busy bit too. However your question reminded me I haven't 
looked the PXA data sheets at all but just the code only that changes 
don't break the existing PXA cases.

According to PXA3xx datasheet the busy bit is defined as in Intel platforms.

-- 
Jarkko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
