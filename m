From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
Subject: Re: [PATCH] spi: Fix incomplete handling of
 SPI_MASTER_MUST_RX/_MUST_TX
Date: Fri, 5 Feb 2016 10:30:24 +0530
Message-ID: <56B42C68.4030909@microchip.com>
References: <1454366363-10564-1-git-send-email-joshua.henderson@microchip.com>
 <20160201231733.GK4455@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Cc: Joshua Henderson <joshua.henderson-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>,
	<linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160201231733.GK4455-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Thanks Mark.

On 02/02/2016 04:47 AM, Mark Brown wrote:

> On Mon, Feb 01, 2016 at 03:39:23PM -0700, Joshua Henderson wrote:
>> From: Purna Chandra Mandal <purna.mandal-UWL1GkI3JZL3oGB3hsPCZA@public.gmane.org>
>> There is a BUG in the way SPI_MASTER_MUST_RX/TX is implemented which can create
> Bug is a WORD like any other WORD...

ack.

>> (1) spi core assigns dummy_rx buffer to transfer.rx_buf member and
>> (2) passes it to lower layer for handling. and lower layer completed the
>>     transfer/message in due time.
>> (3) spi core deletes the buffer if no other requests pending, but
>>     'transfer.rx_buf' continues to hold *stale* dummy buffer pointer.
>> (4) If spi client driver (like mmc_spi) reuses the same transfer structure and
>>     don't touch .rx_buf to NULL
>> mmc_spi doesn't reset the ptr unless data transfer direction changes in future
>> transaction(s). spi core will skip assigning new dummy buffer and underlying
>> master driver will treat .rx_buf as legitimate ptr. This will result into memory
>> corruption due to usage of free'd ptr.
> It's not clear to me that this is the best fix, it's causing problems to
> free the transfer but we could also fix that by just not freeing the
> dummy data once we realize we need it unless the adaptor is freed.  That
> should also be more efficient since it saves us having to allocate and
> free things.

Idea is good, but not sufficient.
Dummy buffers are _reallocated_ to accommodate larger size of transfer. In this if
[originally NULL] .rx_buf/.tx_buf is not reset back to NULL after the transfer
is over spi-core will find those .rx/tx_buf non-NULL in next _transfer() call and
will pass the stale rx/tx_buf to spi controller driver which will definitely
corrupt the memory and crash the system.

Above all the whole design depends on trust that core will not play with any data-structure
which will break object-oriented/layered approach. So better to undo the modification
(when needed to facilitate some functionality) unless core wants those information to be passed
back to caller/client for reporting success or error or else.


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
