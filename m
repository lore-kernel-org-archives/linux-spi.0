From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v3 1/3] spi: spi-mem: Fix a typo in the documentation of
 struct spi_mem
Date: Thu, 2 Aug 2018 15:39:18 +0200
Message-ID: <8a365fb9-ab9b-b8f1-6dbe-587c6b9b8ad2@exceet.de>
References: <1533214434-28761-1-git-send-email-frieder.schrempf@exceet.de>
 <1533214434-28761-2-git-send-email-frieder.schrempf@exceet.de>
 <20180802150945.44cc8328@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: dwmw2@infradead.org, computersforpeace@gmail.com,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        cyrille.pitchen@wedev4u.fr, pp@emlix.com, Zhiqiang.Hou@nxp.com,
        linux-kernel@vger.kernel.org
To: Boris Brezillon <boris.brezillon@bootlin.com>, broonie@kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802150945.44cc8328@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Boris, hi Mark,

On 02.08.2018 15:09, Boris Brezillon wrote:
> On Thu,  2 Aug 2018 14:53:52 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
> We usually try to avoid empty commit message, even if this one is
> pretty obvious, I'd suggest adding something here.
> 
> "
> Fix a typo in the @drvpriv description.
> "
> 
> ?

Forgot the commit message, sorry.

Mark, can you add it when you apply the patch or should I send a new 
version?

Thanks,
Frieder

> 
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
> 
> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
> 
>> ---
>>   include/linux/spi/spi-mem.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 4fa34a2..72cc9bc 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -124,7 +124,7 @@ struct spi_mem_op {
>>   /**
>>    * struct spi_mem - describes a SPI memory device
>>    * @spi: the underlying SPI device
>> - * @drvpriv: spi_mem_drviver private data
>> + * @drvpriv: spi_mem_driver private data
>>    *
>>    * Extra information that describe the SPI memory device and may be needed by
>>    * the controller to properly handle this device should be placed here.
> 
