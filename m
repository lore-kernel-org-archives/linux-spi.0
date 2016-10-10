From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v6, 5/8] mtd: m25p80: Let m25p80_read() fallback to spi
 transfer
Date: Mon, 10 Oct 2016 10:29:49 +0200
Message-ID: <8309370e-f99f-ed51-4789-c1d97d9d8191@atmel.com>
References: <1472076269-4731-1-git-send-email-kdasu.kdev@gmail.com>
 <1472076269-4731-6-git-send-email-kdasu.kdev@gmail.com>
 <4b3b3d3e-b3f8-1d5b-65e3-0c37b6a29096@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Cc: <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, <jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, <vigneshr-l0cyMroinI0@public.gmane.org>,
        <yendapally.reddy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4b3b3d3e-b3f8-1d5b-65e3-0c37b6a29096-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi all,


Le 10/10/2016 à 10:04, Florian Fainelli a écrit :
> On 08/24/2016 03:04 PM, Kamal Dasu wrote:
>> In m25p80_read() even though spi_flash_read() is supported
>> by some drivers, under certain circumstances like unaligned
>> buffer, address or address range limitations on certain SoCs
>> let it fallback to core spi reads. Such drivers are expected
>> to return -EAGAIN so that the m25p80_read() uses standard
>> spi transfer.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> MTD folks, any comments on this?
> 
>> ---
>>  drivers/mtd/devices/m25p80.c | 11 +++++++++--
>>  1 file changed, 9 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index 9cf7fcd..77c2d2c 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -155,9 +155,16 @@ static ssize_t m25p80_read(struct spi_nor *nor, loff_t from, size_t len,
>>  		msg.data_nbits = m25p80_rx_nbits(nor);
>>  
>>  		ret = spi_flash_read(spi, &msg);
>> -		if (ret < 0)
>> +
>> +		if (ret >= 0)
>> +			return msg.retlen;
>> +
>> +		/*
>> +		 * some spi master drivers might need to fallback to
>> +		 * normal spi transfer
>> +		 */
>> +		if (ret != -EAGAIN)
I just wonder whether EINVAL would be a better choice.
>>  			return ret;
>> -		return msg.retlen;
>>  	}
>>  
>>  	spi_message_init(&m);
>>
> 

Best regards,

Cyrille
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
