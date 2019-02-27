From: Jiada Wang <jiada_wang@mentor.com>
Subject: Re: Bug in spi: imx: Add support for SPI Slave mode
Date: Wed, 27 Feb 2019 10:55:02 +0900
Message-ID: <2ea41684-69b2-e7e8-0d2b-325c799104e1@mentor.com>
References: <20170905051232.21203-1-jiada_wang@mentor.com>
 <1551217306.3075.188.camel@impinj.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stefan@agner.ch" <stefan@agner.ch>
To: Trent Piepho <tpiepho@impinj.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "broonie@kernel.org" <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551217306.3075.188.camel@impinj.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Trent

Thanks for reporting

On 2019/02/27 6:41, Trent Piepho wrote:
> On Tue, 2017-09-05 at 14:12 +0900, Jiada Wang wrote:
>> Previously i.MX SPI controller only works in Master mode.
>> This patch adds support to i.MX51, i.MX53 and i.MX6 ECSPI
>> controller to work also in Slave mode.
> 
> Recently DMA has been enabled for imx6/7 with SPI.  This results in
> memory corruption in some instances I've traced the problem to this
> patch.
> 
> 
>>   static int spi_imx_transfer(struct spi_device *spi,
>>   				struct spi_transfer *transfer)
>>   {
>>   	struct spi_imx_data *spi_imx = spi_master_get_devdata(spi->master);
>>   
>> +	/* flush rxfifo before transfer */
>> +	while (spi_imx->devtype_data->rx_available(spi_imx))
>> +		spi_imx->rx(spi_imx);
>> +
>> +	if (spi_imx->slave_mode)
>> +		return spi_imx_pio_transfer_slave(spi, transfer);
>> +
>>   	if (spi_imx->usedma)
>>   		return spi_imx_dma_transfer(spi_imx, transfer);
>>   	else
> 
> This is in the main xfer function that is used for both master mode and
> slave mode.  Normally RX data is received after the xfer is started, as
> part of the spi_imx_pio/dma_transfer() process.  But this patch has
> added a "flush rxfifo" command before this.  Why?
>
in the commit message of commit ("spi: imx: Add support for SPI Slave 
mode"), it mentions

"The stale data in RXFIFO will be dropped when the Slave does any new 
transfer"

> If it's necessary to empty the fifo before an xfer, then how did this
> driver ever work before this change?  I see no change anywhere else
> that would make this a new requirement.
> 
only slave mode needs to flush stale data in RXFIFO,

> If the rx fifo is not empty, and this code actually does rx something
> from the fifo, then how can it possibly work to place it into the
> xfer's RX buffer? How do you know the buffer is large enough (it's not!
> that's my DMA bug!)?  Won't it offset the actual rx data that comes
> after it in the xfer's buffer?
> 
Currently I am not able to test and this patch was created several years 
before, but as I can recall, the purpose is to flush stale data in RXFIFO
before spi->rx_buf is set, but seems there is bug, after the first xfer,
rx_buf will always point to somewhere, which can lead to memory corruption.

> In my test, switching from DMA to PIO, which happens if the 1st xfer is
>   large enough to pass a >fifo/2 size test, and uses DMA, and the 2nd
> xfer is smaller, and will use PIO, results in the PIO xfer trying to
> empty the rx buffer in this code above.  If there is not enough space
> in the xfer's rx buffer, and there is no reason for there to be any
> space at all, it clobbers memory.
> 
> I suspect the author of this wasn't aware that spi_imx->rx() will write
> the data received into the current xfer's rx buffer rather than throw
> it away, and never tested this actually getting used for a transfer
> where the rx data mattered.
> 
yes, you are right,
as I don't have access to HW, can you please submit a fix
(for example reset rx_buf after each xfer?)
> Still, I'd like to know why the flush rx thing is even here.  Nothing
> in the commit message or any discussion I could find addressed this.
> 
master side may xfer data longer than slave side is expecting,
the extra data received in RXFIFO, need to be dropped before new xfer

Thanks,
Jiada
