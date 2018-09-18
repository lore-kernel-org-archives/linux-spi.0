From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH] mtd: spi-nor: Support controllers with limited TX FIFO
 size
Date: Tue, 18 Sep 2018 12:51:51 +0200
Message-ID: <81e0653f-1e07-6ec9-f12a-d448e269c87a@exceet.de>
References: <1528870092-14526-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20180709233427.1a714de7@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-mtd@lists.infradead.org, computersforpeace@gmail.com,
        david.wolfe@nxp.com, han.xu@nxp.com, festevam@gmail.com,
        prabhakar.kushwaha@nxp.com, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
To: Boris Brezillon <boris.brezillon@bootlin.com>,
        Yogesh Gaur <yogeshnarayan.gaur@nxp.com>, marek.vasut@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709233427.1a714de7@bbrezillon>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Marek, hi Boris,

On 09.07.2018 23:34, Boris Brezillon wrote:
> +Fabio
> 
> Hi Yogesh,
> 
> On Wed, 13 Jun 2018 11:38:12 +0530
> Yogesh Gaur <yogeshnarayan.gaur@nxp.com> wrote:
> 
>> Some SPI controllers can't write nor->page_size bytes in a single
>> step because their TX FIFO is too small.
>>
>> Allow nor->write() to return a size that is smaller than the requested
>> write size to gracefully handle this case.
> 
> There's been a discussion between Marek and I regarding this patch and
> patch "mtd: devices: m25p80: Make sure WRITE_EN is issued before each
> write". Marek would like to avoid letting drivers do non-aligned page
> writes when the MTD user requested full page writes.
> 
> So, the question is, is the FSL QSPI engine capable of handling that
> when the NOR page is being than the TX FIFO? According to the current
> implementation it's not [1], but it looks like we have a way to
> know when the TX FIFO is not full so we could potentially refill the
> FIFO either from the CPU or using DMA if that's possible (not sure the
> eDMA engine can fill the QSPI TX FIFO directly).
> 
> What I find worrisome with this solution is this particular statement
> in the datasheet:
> 
> "
> When the QuadSPI module tries to pull data out of an empty TX Buffer
> the TX Buffer underrun is signaled by the QSPI_FR[TBUF] flag. The
> current IP Command leading to the underrun condition is continued until
> the specified number of bytes has been sent to the serial flash device,
> in the underrun condition when QuadSPI module tries to pull out data of
> empty TX buffer, the data transferred is undefined i.e. once the
> underrun flag is set, it will return the garbage value until the
> required number of bytes are not sent.
> "
> 
> If we fail to fill the TX FIFO fast enough for any reasons (contention
> on the APB/AHB/AXI bus in case of DMA, task being scheduled out in
> case of PIO access), that means we transfer garbage to the NOR...
> Clearly something we should avoid at any cost.
> 
> Yogesh, Fabio, Han, any comment on this?

I want to revive the discussion about this patch. Meanwhile we have 
received confirmation from NXP, that the hardware can't handle writing 
data chunks bigger than the TX buffer size, even when we use DMA to 
refill the buffer [1].

This means, that this patch is required to get the FSL QSPI driver 
working with the SPI mem framework.

Could you please reconsider this patch?

Thanks,
Frieder

[1] 
http://lists.infradead.org/pipermail/linux-mtd/2018-September/083799.html

> 
> Thanks,
> 
> Boris
> 
> [1]https://elixir.bootlin.com/linux/v4.18-rc4/source/drivers/mtd/spi-nor/fsl-quadspi.c#L1117
> 
>>
>> Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
>> ---
>>   drivers/mtd/spi-nor/spi-nor.c | 7 -------
>>   1 file changed, 7 deletions(-)
>>
>> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
>> index 5bfa36e..3e63543 100644
>> --- a/drivers/mtd/spi-nor/spi-nor.c
>> +++ b/drivers/mtd/spi-nor/spi-nor.c
>> @@ -1431,13 +1431,6 @@ static int spi_nor_write(struct mtd_info *mtd, loff_t to, size_t len,
>>   			goto write_err;
>>   		*retlen += written;
>>   		i += written;
>> -		if (written != page_remain) {
>> -			dev_err(nor->dev,
>> -				"While writing %zu bytes written %zd bytes\n",
>> -				page_remain, written);
>> -			ret = -EIO;
>> -			goto write_err;
>> -		}
>>   	}
>>   
>>   write_err:
> 
