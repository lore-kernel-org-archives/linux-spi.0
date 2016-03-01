From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH] spi: Fix incomplete handling of
 SPI_MASTER_MUST_RX/_MUST_TX
Date: Tue, 1 Mar 2016 17:47:49 +0530
Message-ID: <56D5886D.4060504@microchip.com>
References: <1454366363-10564-1-git-send-email-joshua.henderson@microchip.com>
 <20160201231733.GK4455@sirena.org.uk> <56B42C68.4030909@microchip.com>
 <20160208161542.GF7265@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Joshua Henderson <joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160208161542.GF7265-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Mark,

On 02/08/2016 09:45 PM, Mark Brown wrote:

> On Fri, Feb 05, 2016 at 10:30:24AM +0530, Purna Chandra Mandal wrote:
>
> Please fix your mail client to word wrap within paragraphs at something
> substantially less than 80 columns.  Doing this makes your messages much
> easier to read and reply to.
>
>> Idea is good, but not sufficient.
>> Dummy buffers are _reallocated_ to accommodate larger size of transfer. In this if
>> [originally NULL] .rx_buf/.tx_buf is not reset back to NULL after the transfer
>> is over spi-core will find those .rx/tx_buf non-NULL in next _transfer() call and
>> will pass the stale rx/tx_buf to spi controller driver which will definitely
>> corrupt the memory and crash the system.
> This needs to be clear to readers; a fairly obvious way of dealing with
> this would be to rellocate down to a page rather than freeing.

Yea. But current krealloc() implementation allocates new memory if new size
is more than the allocated space, (and frees the old). If we allocate
PAGE_SIZE of dummy buffer (at first call irrespective of required size),
re-use it and don't allow transfer size to grow more than PAGE_SIZE we
will be fine provided all SPI clients agree to the size restriction.
The moment we'll try to re-allocate new buffer we will reach the same
point we wanted to avoid here.

>> Above all the whole design depends on trust that core will not play with any data-structure
>> which will break object-oriented/layered approach. So better to undo the modification
>> (when needed to facilitate some functionality) unless core wants those information to be passed
>> back to caller/client for reporting success or error or else.
> That's really not the case, we already make a range of other
> modifications to complete partially filled transfers in order to
> simplify driver code.

Purna

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
