From: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: only use up TX/RX bounce buffer space when
 needed
Date: Sun, 15 Feb 2015 10:30:22 +0000
Message-ID: <54E0753E.30208@mev.co.uk>
References: <1423743188-1821-1-git-send-email-abbotti@mev.co.uk> <20150214044910.GF9110@finisterre.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20150214044910.GF9110-bheZrs9scGb3/WHNxyQH9YN0K6Il/+VY@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 14/02/15 04:49, Mark Brown wrote:
> On Thu, Feb 12, 2015 at 12:13:08PM +0000, Ian Abbott wrote:
>> Devices have separate, pre-allocated TX and RX bounce buffers of fixed
>> size.  Currently, each transfer uses up space in both buffers even if
>> the user-supplied no TX data or no RX space.  Change it to only use up
>> space in the TX and RX bounce buffers as required.
>
> This is a bit hard to parse.  I think you're talking about buffers in
> spidev here but it's unclear and you've not described in what way you're
> changing the code and we do currently only seem to copy data when the
> user has asked for it.

Yes, I was talking about spidev. I did tag it in the subject line of the 
commit message, though I'm sorry if the rest of it is difficult to parse.

Yes, we copy data when the user asked for it. The patch is trying to 
avoid wasting space in the TX and/or RX buffers when the user _didn't_ 
ask for it.

>> Since dummy transfers with no user-supplied TX data and no user-supplied
>> RX space will no longer use up space in the bounce buffers, limit the
>> overall SPI message length to INT_MAX instead of the buffer size.
>
> That doesn't seem to follow at all.  No mention has been made of
> eliminating the buffers entirely or otherwise ensuring that we can
> handle transfers of any length - not using the buffer for transmit isn't
> going to make the receive buffer any bigger and indeed...
>
>>   		if (u_tmp->rx_buf) {
>> +			rx_total += k_tmp->len;
>> +			if (rx_total > bufsiz) {
>> +				status = -EMSGSIZE;
>> +				goto done;
>> +			}
>
> ...we do still seem to be limited to the buffer size here as one would
> expect?

Yes, the patch limits the total user-specified TX data and the total 
user-specified RX data to the pre-allocated buffer size individually 
rather than limiting the total sum of user RX and TX data.

> Basically I'm not entirely clear what this change is supposed to be
> doing or what the expected benefit is.  I *think* the goal is to allow
> multi-transfer messages with a mix of unidirectional transfers to be
> larger but the changelog needs to be clearer and it's not 100% clear why
> we'd bother to check for INT_MAX.

My intention was to use the pre-allocated buffers more efficiently in 
the case of multiple, half-duplex transfers in different directions, not 
to allow transfers of any length.

The check against INT_MAX is there because a struct spi_ioc_transfer 
might have rx_buf==NULL, tx_buf==NULL and len!=0, in which case it would 
no longer use up space in either of the pre-allocated buffers so neither 
rx_total nor tx_total would increase.  Checking the sum of the len 
fields against INT_MAX prevents arithmetic overflow in the return value 
of the function.

-- 
-=( Ian Abbott @ MEV Ltd.    E-mail: <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org> )=-
-=(                          Web: http://www.mev.co.uk/  )=-
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
