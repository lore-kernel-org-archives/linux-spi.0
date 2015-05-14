From: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Subject: Re: spi: race in spi_finalize_current_message starting queue_kthread_work before the message is unmapped
Date: Thu, 14 May 2015 11:49:57 +0200
Message-ID: <8B0C03C5-198F-4FB9-82FD-BB43074863C1@martin.sperl.org>
References: <8C375B28-1C09-4545-8A5B-78F6CD04102F@martin.sperl.org> <20150508221309.GK2761@sirena.org.uk> <352560EA-A323-449B-8F37-6066328D2081@martin.sperl.org> <20150511180016.GU3458@sirena.org.uk> <8F4019F0-7C56-4C9C-9193-A2A23B533165@martin.sperl.org> <20150512102034.GM2761@sirena.org.uk> <5551ECF9.1050006@martin.sperl.org> <20150512165053.GE3066@sirena.org.uk>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150512165053.GE3066-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


> On 12.05.2015, at 18:50, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> 
>> And inside __spi_map_msg we can just add some code to create the simple
>> scatter-gather mapping using a single preallocated page - so something
>> along the lines (assuming that either tx_buf or rx_buf must be set):
> 
> Yes, to repeat what I said earlier I'm hoping someone with a need for
> this will implement it.

Actually I was asking these questions to have some guidelines what is
acceptable and what is not for the implementation

So, I got a patch now that works with all my test cases (tft-framebuffer
device as well as enc28j60).

Submitting it shortly for review.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
