From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: Re: [PATCH] spi: armada-3700: fix unsigned compare than zero on irq
Date: Tue, 13 Dec 2016 11:01:52 +0000
Message-ID: <47d82067-0a4c-32e9-fe78-16f2e6735aa6@canonical.com>
References: <20161213102812.9029-1-colin.king@canonical.com>
 <c173347e-c93b-2652-0b10-14e85d5f96bd@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <c173347e-c93b-2652-0b10-14e85d5f96bd-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 13/12/16 10:55, Romain Perier wrote:
> Hello,
> 
> Le 13/12/2016 à 11:28, Colin King a écrit :
>> From: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>>
>> spi->irq is an unsigned integer hence the check if status is less than
>> zero has no effect.  Fix this by replacing spi->irq with an int irq
>> so the less than zero compare will correctly detect errors.
>>
>> Issue found with static analysis with CoverityScan, CID1388567
>>
>> Signed-off-by: Colin Ian King <colin.king-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
>> ---
>>  drivers/spi/spi-armada-3700.c | 9 +++++----
>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/spi/spi-armada-3700.c
>> b/drivers/spi/spi-armada-3700.c
>> index e89da0a..4e92178 100644
>> --- a/drivers/spi/spi-armada-3700.c
>> +++ b/drivers/spi/spi-armada-3700.c
>> @@ -800,7 +800,7 @@ static int a3700_spi_probe(struct platform_device
>> *pdev)
>>      struct spi_master *master;
>>      struct a3700_spi *spi;
>>      u32 num_cs = 0;
>> -    int ret = 0;
>> +    int irq, ret = 0;
>>
>>      master = spi_alloc_master(dev, sizeof(*spi));
>>      if (!master) {
>> @@ -846,12 +846,13 @@ static int a3700_spi_probe(struct
>> platform_device *pdev)
>>          goto error;
>>      }
>>
>> -    spi->irq = platform_get_irq(pdev, 0);
>> -    if (spi->irq < 0) {
>> -        dev_err(dev, "could not get irq: %d\n", spi->irq);
>> +    irq = platform_get_irq(pdev, 0);
>> +    if (irq < 0) {
>> +        dev_err(dev, "could not get irq: %d\n", irq);
>>          ret = -ENXIO;
>>          goto error;
>>      }
>> +    spi->irq = irq;
>>
>>      init_completion(&spi->done);
>>
>>
> 
> Why don't you change only the type of "irq" in struct a3700_spi ?
> 
> Thanks,
> Romain

..because I've observed that a lot of driver seems to use a unsigned int
for the irq in their driver specific structs and I also didn't want to
modify this to an int in case it some subtle signed/unsigned logic
somewhere else that I was not aware of. Just seemed like the least risky
fix to me.

Colin

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
