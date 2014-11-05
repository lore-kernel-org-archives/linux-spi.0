From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Wed, 5 Nov 2014 14:25:03 -0600
Message-ID: <545A879F.7020600@opensource.altera.com>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com> <1415181423.472.15.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	<feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, <setka-3PjVBYxTQDg@public.gmane.org>, <tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org>
To: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1415181423.472.15.camel-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


On 11/05/2014 03:57 AM, Andy Shevchenko wrote:
> On Tue, 2014-11-04 at 16:36 -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org wrot=
e:
>> From: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>>
>> Changing SPI transfer speed using a utility such as spi_config with
>> spidev updates chip->speed_hz which is compared to the next transfer
>> speed.
>>
>> When speed_hz is not declared in a SPI transfer, the transfer speed =
is
>> not updated for the next read/write on /dev/spidevX.Y. The element
>> spi_transfer->speed_hz is filled with spi->max_speed_hz. The test of
>> if (transfer->speed_hz !=3D speed) doesn't work because the chip->sp=
eed_hz
>> matches transfer->speed_hz and the clock divider is not updated.
>>
>> This fix: On each transfer update the clock divider, compare to the
>> previous clock divider and update if necessary. This fixes another
>> bug where the clock divider calculation at the top of the
>> pump_transfers() function could be an odd-number.
>>
> My intention is to use SPI core API as much as possible. Thus,
> pump_transfers() I think should be gone in future. Instead of doing a=
n
> additional work can you provide a helper function to set speed_hz and
> call it from pump_transfers()?
>
Hi. I see your point but this patch may change significantly as a resul=
t=20
of discussion. If some form of clock divider changes are implemented,=20
I'm happy to make a helper function.
Thanks for reviewing!
>
>> Reported-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
>> Signed-off-by: Vlastimil Setka <setka-3PjVBYxTQDg@public.gmane.org>
>> Signed-off-by: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
>> ---
>>   drivers/spi/spi-dw.c |   33 ++++++++++++++++++---------------
>>   1 file changed, 18 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index 72e12ba..3456b34 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -376,9 +376,6 @@ static void pump_transfers(unsigned long data)
>>   	chip =3D dws->cur_chip;
>>   	spi =3D message->spi;
>>  =20
>> -	if (unlikely(!chip->clk_div))
>> -		chip->clk_div =3D dws->max_freq / chip->speed_hz;
>> -
>>   	if (message->state =3D=3D ERROR_STATE) {
>>   		message->status =3D -EIO;
>>   		goto early_exit;
>> @@ -415,21 +412,27 @@ static void pump_transfers(unsigned long data)
>>  =20
>>   	cr0 =3D chip->cr0;
>>  =20
>> -	/* Handle per transfer options for bpw and speed */
>> -	if (transfer->speed_hz) {
>> -		speed =3D chip->speed_hz;
>> +	/* Always calculate the desired clock divider */
>> +	speed =3D transfer->speed_hz ? transfer->speed_hz : chip->speed_hz=
;
>> +
>> +	if (speed > dws->max_freq) {
>> +		dev_err(&spi->dev, "Unsupported SPI freq: %d Hz\n", speed);
>> +		message->status =3D -EIO;
>> +		goto early_exit;
>> +	}
>> +
>> +	/* clk_div doesn't support odd number */
>> +	clk_div =3D dws->max_freq / speed;
>> +	clk_div =3D (clk_div + 1) & 0xfffe;
>>  =20
>> -		if (transfer->speed_hz !=3D speed) {
>> -			speed =3D transfer->speed_hz;
>> +	/* Determine if the clock divider changed, if so update chip struc=
t */
> Maybe "=E2=80=A6update speed_hz" ?
>
>> +	if (clk_div !=3D chip->clk_div)
>> +		chip->clk_div =3D clk_div;
>> +	else
>> +		clk_div =3D 0; /* Prevent register programming below */
>>  =20
>> -			/* clk_div doesn't support odd number */
>> -			clk_div =3D dws->max_freq / speed;
>> -			clk_div =3D (clk_div + 1) & 0xfffe;
>> +	chip->speed_hz =3D speed;
>>  =20
>> -			chip->speed_hz =3D speed;
>> -			chip->clk_div =3D clk_div;
>> -		}
>> -	}
>>   	if (transfer->bits_per_word) {
>>   		bits =3D transfer->bits_per_word;
>>   		dws->n_bytes =3D dws->dma_width =3D bits >> 3;
>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
