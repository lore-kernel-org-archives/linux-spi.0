From: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/2] spi: imx: dynamic burst length adjust for PIO mode
Date: Mon, 1 May 2017 03:15:49 -0700
Message-ID: <59070AD5.7030405@mentor.com>
References: <20170208062028.22313-1-jiada_wang@mentor.com> <20170208062028.22313-2-jiada_wang@mentor.com> <20170214182019.s3o5uphsfz4bxlkq@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170214182019.s3o5uphsfz4bxlkq-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark

Sorry, somehow I missed your following comment

On 02/14/2017 10:20 AM, Mark Brown wrote:
> On Wed, Feb 08, 2017 at 03:20:27PM +0900, Jiada Wang wrote:
>
> This looks basically fine, a couple of fairly minor things here:
>
>> +	for (i = 0; i<  transfer->len / 4; i++) {
>> +		u8 temp;
>> +
>> +		temp = *(buf + i * 4);
>> +		*(buf + i * 4) = *(buf + i * 4 + 3);
>> +		*(buf + i * 4 + 3) = temp;
> Should this be using one of the cpu_to_ functions?  It's a bit unclear
> what the goal is here and if it'll work if the kernel is big endian
> (which people do do with i.MX systems IIRC).
indeed, with big endian kernel, this function won't work
I will replace the algo here with cpu_to_* in next version

Thanks,
Jiada

>> +	if (spi_imx->bpw_w == 1)
>> +		spi_imx_buf_rx_u8(spi_imx);
>> +	else if (spi_imx->bpw_w == 2)
>> +		spi_imx_buf_rx_u16(spi_imx);
> switch statement please.
>
>> +	if (spi_imx->dynamic_burst) {
>> +		spi_imx->count_index =
>> +				spi_imx->count>  MX51_ECSPI_CTRL_MAX_BURST ?
>> +				spi_imx->count % MX51_ECSPI_CTRL_MAX_BURST :
>> +				spi_imx->count % sizeof(u32);
> Just write a normal if statement please, it's easier to read.

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
