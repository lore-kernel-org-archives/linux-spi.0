From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH][spi-next] spi: stm32: fix range limit checks on div
Date: Thu, 22 Jun 2017 16:50:50 +0100
Message-ID: <620dc7c8-fbc4-1742-8e41-afc0444f1869@canonical.com>
References: <20170622154142.22481-1-colin.king@canonical.com>
 <0133c805-c919-f115-7c94-65d88bed8ca2@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie DELAUNAY <amelie.delaunay-qxv4g6HH51o@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <0133c805-c919-f115-7c94-65d88bed8ca2-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 22/06/17 16:49, Amelie DELAUNAY wrote:
> Hi Colin,
> 
> I'm preparing a v2 for the initial patchset introducing spi-stm32, if
> you agree, I can directly add your fix.

Yep, please do, sounds like a plan.

Colin
> 
> Regards,
> Amelie
> 
> On 06/22/2017 05:41 PM, Colin King wrote:
>> From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>>
>> Currently the check for range limits on div is incorrect and will
>> never return -EINVAL. Fix this by replacing && with ||
>>
>> Detected by CoverityScan, CID#1446580 ("Structurally dead code")
>>
>> Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> ---
>>   drivers/spi/spi-stm32.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-stm32.c b/drivers/spi/spi-stm32.c
>> index 0553f61ab3b7..b75909e7b117 100644
>> --- a/drivers/spi/spi-stm32.c
>> +++ b/drivers/spi/spi-stm32.c
>> @@ -262,7 +262,7 @@ static int stm32_spi_prepare_mbr(struct stm32_spi
>> *spi, u32 speed_hz)
>>        * no need to check it there.
>>        * However, we need to ensure the following calculations.
>>        */
>> -    if ((div < SPI_MBR_DIV_MIN) &&
>> +    if ((div < SPI_MBR_DIV_MIN) ||
>>           (div > SPI_MBR_DIV_MAX))
>>           return -EINVAL;
>>  

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
