From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
Subject: Re: [PATCH 1/1] ARM: spi supports 32bytes buffer for DUAL and QUAD
Date: Mon, 07 Nov 2016 09:27:44 +0900
Message-ID: <581FCA80.7000007@jinso.co.jp>
References: <1478248734-32044-1-git-send-email-cm-hiep@jinso.co.jp> <1478248734-32044-2-git-send-email-cm-hiep@jinso.co.jp> <20161105073239.GA30888@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Cc: broonie@kernel.org, geert+renesas@glider.be,
        linux-spi@vger.kernel.org, kuninori.morimoto.gx@renesas.com,
        yoshihiro.shimoda.uh@renesas.com, ryusuke.sakato.bx@renesas.com,
        linux-renesas-soc@vger.kernel.org, nv-dung@jinso.co.jp,
        h-inayoshi@jinso.co.jp
To: =?windows-1252?Q?Niklas_S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20161105073239.GA30888@bigcity.dyn.berto.se>
Sender: linux-renesas-soc-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Niklas,

Thanks for your comment.

On 11/05/2016 04:32 PM, Niklas Söderlund wrote:
> Hi Cao,
>
> On 2016-11-04 17:38:54 +0900, Cao Minh Hiep wrote:
>> From: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>>
>> This patch supports 32bytes of buffer for DUAL and QUAD in QSPI by
>> Using Transmit/Receive Buffer Data Triggering Number.
>> In order to improve the DUAL and QUAD's performance of SPI
>> while transferring data in PIO mode, it sends/receives each 32bytes
>> data instead of each byte data as current situation.
>>
>> Signed-off-by: Hiep Cao Minh <cm-hiep@jinso.co.jp>
>> ---
>>   drivers/spi/spi-rspi.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 49 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/spi/spi-rspi.c b/drivers/spi/spi-rspi.c
>> index a816f07..fb12bc5 100644
>> --- a/drivers/spi/spi-rspi.c
>> +++ b/drivers/spi/spi-rspi.c
>> @@ -413,7 +413,7 @@ static unsigned int qspi_set_send_trigger(struct rspi_data *rspi,
>>   	return n;
>>   }
>>   
>> -static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
>> +static int qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
>>   {
>>   	unsigned int n;
>>   
>> @@ -428,6 +428,7 @@ static void qspi_set_receive_trigger(struct rspi_data *rspi, unsigned int len)
>>   		qspi_update(rspi, SPBFCR_RXTRG_MASK,
>>   			     SPBFCR_RXTRG_1B, QSPI_SPBFCR);
>>   	}
>> +	return n;
>>   }
>>   
>>   #define set_config_register(spi, n) spi->ops->set_config_register(spi, n)
>> @@ -514,6 +515,51 @@ static int rspi_pio_transfer(struct rspi_data *rspi, const u8 *tx, u8 *rx,
>>   	return 0;
>>   }
>>   
>> +static int rspi_pio_transfer_in_or_our(struct rspi_data *rspi, const u8 *tx,
>> +				       u8 *rx, unsigned int n)
> Nitpicking, s/rspi_pio_transfer_in_or_our/rspi_pio_transfer_in_or_out/
> or am I missing something?
You're right!. It should be "rspi_pio_transfer_in_or_out"
I'll update it in an other patch.

Thanks.
Jinzai Solution Inc,
Hiep.
