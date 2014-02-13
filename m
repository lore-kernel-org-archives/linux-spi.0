From: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-spi: Convert to let spi core validate xfer->bits_per_word
Date: Thu, 13 Feb 2014 16:27:40 +0800
Message-ID: <CAFRkauAEFO3JBkxWTsCcVByxkpmM7Fvs-r7By+h1nwY5LNFkpg@mail.gmail.com>
References: <1392214052.11101.2.camel@phoenix>
	<52FC8100.4020408@gaisler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52FC8100.4020408-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

2014-02-13 16:23 GMT+08:00 Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>:
> Hi!
>
> This patch probably also needs to make sure that bits_per_word can not be
> greater than mpc8xxx_spi->max_bits_per_word.
>
>
> On 2014-02-12 15:07, Axel Lin wrote:
>>
>> Set bits_per_word_mask so spi core will reject transfers that attempt to
>> use
>> an unsupported bits_per_word value.
>>
>> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
>> ---
>>   drivers/spi/spi-fsl-spi.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
>> index 4dcb292..28064ad 100644
>> --- a/drivers/spi/spi-fsl-spi.c
>> +++ b/drivers/spi/spi-fsl-spi.c
>> @@ -239,12 +239,6 @@ static int fsl_spi_setup_transfer(struct spi_device
>> *spi,
>>         if (!bits_per_word)
>>                 bits_per_word = spi->bits_per_word;
>>
>> -       /* Make sure its a bit width we support [4..16, 32] */
>> -       if ((bits_per_word < 4)
>> -           || ((bits_per_word > 16) && (bits_per_word != 32))
>> -           || (bits_per_word > mpc8xxx_spi->max_bits_per_word))
>
>
> This max_bits_per_word check here...
>
>
>> -               return -EINVAL;
>> -
>>         if (!hz)
>>                 hz = spi->max_speed_hz;
>>
>> @@ -631,6 +625,8 @@ static struct spi_master * fsl_spi_probe(struct device
>> *dev,
>>
>>         master->setup = fsl_spi_setup;
>>         master->cleanup = fsl_spi_cleanup;
>> +       master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 16) |
>> +                                    SPI_BPW_MASK(32);
>
>
> ...has no corresponding logic down here.

Actually, it does.
see spi.c and take a look at __spi_validate().

                if (master->bits_per_word_mask) {
                        /* Only 32 bits fit in the mask */
                        if (xfer->bits_per_word > 32)
                                return -EINVAL;
                        if (!(master->bits_per_word_mask &
                                        BIT(xfer->bits_per_word - 1)))
                                return -EINVAL;
                }

Regards,
Axel
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
