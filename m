From: Cyrille Pitchen <cyrille.pitchen-AIFe0yeh4nAAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH, 1/1] mtd: spi-nor: Added support for gd25q16
Date: Mon, 23 Jan 2017 11:29:36 +0100
Message-ID: <ffd3b461-fa79-8cc3-c214-67595f85b0c2@atmel.com>
References: <1484940351-8145-1-git-send-email-kdasu.kdev@gmail.com>
 <8647a273-4ad8-264b-5dcd-a48662dae40d@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
To: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <8647a273-4ad8-264b-5dcd-a48662dae40d-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Le 21/01/2017 à 12:36, Marek Vasut a écrit :
> On 01/20/2017 08:25 PM, Kamal Dasu wrote:
>> Add GigaDevice GD25Q16 (16M-bit) to supported list.
>>
>> Signed-off-by: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> Acked-by: Marek Vasut <marek.vasut-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>

Applied to git://github.com/spi-nor/linux.git

Please note that in the subject line, I've replaced "Added support ..." by
"Add support ...". Indeed, looking at submitting-patches.rst:

Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
to do frotz", as if you are giving orders to the codebase to change
its behaviour.

This is a very small detail so I thought there would be no need to send
another version for that.

Thanks!

>> ---
>>  drivers/mtd/spi-nor/spi-nor.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index da7cd69..8530d51 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -833,6 +833,11 @@ static int spi_nor_is_locked(struct mtd_info *mtd, loff_t ofs, uint64_t len)
>>  
>>  	/* GigaDevice */
>>  	{
>> +		"gd25q16", INFO(0xc84015, 0, 64 * 1024,  32,
>> +			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>> +			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>> +	},
>> +	{
>>  		"gd25q32", INFO(0xc84016, 0, 64 * 1024,  64,
>>  			SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ |
>>  			SPI_NOR_HAS_LOCK | SPI_NOR_HAS_TB)
>>
> 
> 

Applied to
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
