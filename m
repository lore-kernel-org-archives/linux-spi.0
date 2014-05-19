From: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: fix rx_buf in fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Mon, 19 May 2014 17:30:24 +0200
Message-ID: <537A2390.4070203@keymile.com>
References: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com> <20140516190723.GT22111@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140516190723.GT22111-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 05/16/2014 09:07 PM, Mark Brown wrote:
> On Fri, May 16, 2014 at 04:46:21PM +0200, Valentin Longchamp wrote:
> 
>> By default for every espi transfer, the rx_buf is placed right after the
>> tx_buf. This can lead to a buffer overflow when the size of both the TX
>> and RX data cumulated is higher than the allocated 64K buffer for the
>> transfer (this is the case when sending for instance a read command and
>> reading 64K back, please see:
>> http://article.gmane.org/gmane.linux.drivers.mtd/53411 )
>>
>> This gets fixed by always setting the RX buffer pointer at the begining
>> of the transfer buffer.
> 
> This still doesn't seem safe - we're now going to be DMAing to and from
> the same buffer at the same time (and doubtless mapping it twice...).
> Would it not be safer to allocate separate rx and tx buffers?  Indeed
> can we not use the core DMA mapping support to avoid the need to copy at
> all (it will construct scatterlists in PAGE_SIZE chunks)?
> 

I agree that if the DMA does the transfers, to be completely safe we should have
2 separate buffers. But in the case of the spi-fsl-espi driver, I don't think
that some DMA transfers to fill up the hardware buffers are involved. This is
done by the CPU directly to the SPI_TF/SPI_RF registers since there are no real
HW buffers accessible (maybe this is possible in the spi-fsl-cpm driver, where
there are hints about DMA ?).

Or are you talking about the initial memcpy call that fills up the local buffer
in both rw_trans() and cmd_trans() ? And maybe your second point with the
scatterlists is about replacing these memcpy calls ?

Can you please precise because I have not fully understood your answer.

Thanks

Valentin
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
