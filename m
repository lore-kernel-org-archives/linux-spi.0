From: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] spi: sh-msiof: Fix limit maximum word transfer size of
 FIFO size
Date: Mon, 16 Mar 2015 10:18:40 +0900
Message-ID: <CABMQnVK=-okU4L8vCnY15Vpwy9uCoOLzmnOPkpxj4=U6JXzSOg@mail.gmail.com>
References: <1426127476-18456-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
 <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Linux-sh list <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdXmr7QH8jSkyH2q6xCise7ew5YzyAFc6Zb0psHZt3mGrg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

Thanks for your comment.

2015-03-12 21:35 GMT+09:00 Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>:
> Hi Iwamatsu-san,
>
> On Thu, Mar 12, 2015 at 3:31 AM, Nobuhiro Iwamatsu
> <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
>> This driver is the case of tx_buf was set or SPI_MASTER_MUST_TX is set to
>> master_flags, will be transmit mode. However, the current code, when
>> transmit mode and buffer is NULL, will be set to value of receive mode
>> size.
>
> If SPI_MASTER_MUST_TX is set, tx_buf will never be NULL.
> If an SPI slave driver submits a receive-only request, the SPI core will
> provide a dummy buffer (spi_master.dummy_tx).

I see.
>
>> This is when the SPI_MASTER_MUST_TX is set to master_flags, sets to
>> transmit and receive either small size of FIFO, so as not to set the
>> actual size larger than value of FIFO.
>>
>> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.yj-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>> ---
>>  drivers/spi/spi-sh-msiof.c | 24 +++++++++++++++++++-----
>>  1 file changed, 19 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/spi/spi-sh-msiof.c b/drivers/spi/spi-sh-msiof.c
>> index e57eec0..260f433 100644
>> --- a/drivers/spi/spi-sh-msiof.c
>> +++ b/drivers/spi/spi-sh-msiof.c
>> @@ -606,12 +606,26 @@ static int sh_msiof_spi_txrx_once(struct sh_msiof_spi_priv *p,
>>  {
>>         int fifo_shift;
>>         int ret;
>> +       int rx_words = min_t(int, words, p->rx_fifo_size);
>> +       int tx_words = min_t(int, words, p->tx_fifo_size);
>>
>> -       /* limit maximum word transfer to rx/tx fifo size */
>> -       if (tx_buf)
>> -               words = min_t(int, words, p->tx_fifo_size);
>> -       if (rx_buf)
>> -               words = min_t(int, words, p->rx_fifo_size);
>> +       /*
>> +        * limit maximum word transfer to rx/tx fifo size.
>> +        *
>> +        * If SPI_MASTER_MUST_TX was enabled in master_flags, words was
>> +        * set to small value of FIFO.
>> +        */
>> +       if (p->chipdata->master_flags & SPI_MASTER_MUST_TX) {
>> +               if (rx_words > tx_words)
>> +                       words = tx_words;
>> +               else
>> +                       words = rx_words;
>> +       } else {
>> +               if (tx_buf)
>> +                       words = tx_words;
>> +               if (rx_buf)
>> +                       words = rx_words;
>> +       }
>>
>>         /* the fifo contents need shifting */
>>         fifo_shift = 32 - bits;
>
> Sorry, I fail to see what exactly this is fixing.
>
> If SPI_MASTER_MUST_TX is set, all hardware SPI transfers are either
>   a) transmit-only.
>   b) bidirectional (transmit buffer may be a dummy, provided by the SPI core).
>
> For case a, only the TX FIFO size matters.
>   - The original code ignored the RX FIFO size (rx_buf == NULL),
>   - After your change, it always uses the minimum of the TX and RX FIFO sizes
>     (granted, the RX FIFO size is larger, so this doesn't make a difference on
>     current hardware).

Yes.

>
> For case b, both FIFO sizes matter, and the original code handled that fine
> (tx_buf != NULL, rx_buf != NULL).
>
> What am I missing?
> Are you using a backport with broken SPI_MASTER_MUST_TX handling in the SPI
> core?

When tx_buf != NULL and rx_buf != NULL, current code uses FIFO size of
rx_buffer.
Since TX FIFO size is smaller than RX FIFO  size, corrent code set the
wrong value to SITMDR2 register.
Therefore, this patch selects a smaller FIFO size, adds the function to set.

Does this has become a description?

>
> I've just verified that with today's tree (renesas-drivers-2015-03-12-v4.0-rc3),
> SPI_MASTER_MUST_TX works fine, and a dummy tx_buf is passed when needed.

I think correctly work on hardware. However, driver has been set to
the correct register value?

>
> Thanks!
>
> Gr{oetje,eeting}s,
>
>                         Geert

Best regards,
  Nobuhiro

-- 
Nobuhiro Iwamatsu
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
