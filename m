From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH 11/11] spi-dw: remove noop else clause
Date: Wed, 22 Jun 2011 20:13:45 -0700
Message-ID: <4E02AF69.2090800@gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com>	<1308794413-11069-12-git-send-email-dirk.brandewie@gmail.com> <20110623104756.1d1c8da4@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"spi-devel-general@lists.sourceforge.net"
	<spi-devel-general@lists.sourceforge.net>
To: Feng Tang <feng.tang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110623104756.1d1c8da4@feng-i7>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 06/22/2011 07:47 PM, Feng Tang wrote:
> On Thu, 23 Jun 2011 10:00:13 +0800
> "dirk.brandewie@gmail.com"<dirk.brandewie@gmail.com>  wrote:
>
>> From: Dirk Brandewie<dirk.brandewie@gmail.com>
>>
>> The value of spi->bits_per_word is checked on function entry to be 8
>> or 16.  The else clause has no meaning since it can never be reached.
>>
>> Signed-off-by: Dirk Brandewie<dirk.brandewie@gmail.com>
>> ---
>>   drivers/spi/spi-dw.c |    9 +++------
>>   1 files changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
>> index 7b3f607..5ddd45f 100644
>> --- a/drivers/spi/spi-dw.c
>> +++ b/drivers/spi/spi-dw.c
>> @@ -667,17 +667,14 @@ static int spi_dw_setup(struct spi_device *spi)
>>   		chip->enable_dma = chip_info->enable_dma;
>>   	}
>>
>> -	if (spi->bits_per_word<= 8) {
>> +	if (spi->bits_per_word == 8) {
>>   		chip->n_bytes = 1;
>>   		chip->dma_width = 1;
>> -	} else if (spi->bits_per_word<= 16) {
>> +	} else if (spi->bits_per_word == 16) {
>>   		chip->n_bytes = 2;
>>   		chip->dma_width = 2;
>> -	} else {
>> -		/* Never take>16b case for DW SPIC */
>> -		dev_err(&spi->dev, "invalid wordsize\n");
>> -		return -EINVAL;
>>   	}
>
> These "else" case is used to ban the slave spi devices which
> try to use 32 bits per word mode. This is like to tell those
> spi devices with 32 bpw capability "we don't support 32b, pls
> change"

The function has the prerequisite code:
	if (spi->bits_per_word != 8 && spi->bits_per_word != 16)
		return -EINVAL;

at the begining of the function so we will never be able to reach the else 
clause that is being removed.

>
>> +
>>   	chip->bits_per_word = spi->bits_per_word;
>>
>>   	chip->speed_hz = spi->max_speed_hz;
