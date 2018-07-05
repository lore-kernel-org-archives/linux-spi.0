From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 02/12] mtd: m25p80: Call spi_mem_get_name() to let
 controller set a custom name
Date: Thu, 5 Jul 2018 15:06:01 +0200
Message-ID: <abcd1bc3-9ce7-0402-86f6-d43dacad0fb5@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-3-git-send-email-frieder.schrempf@exceet.de>
 <20180705145628.57a48e87@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, Philipp Puschmann <pp@emlix.com>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, richard@nod.at,
 Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, prabhakar.kushwaha@nxp.com,
 linux-kernel@vger.kernel.org, shawnguo@kernel.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, han.xu@nxp.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180705145628.57a48e87@bbrezillon>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Hi Boris,

On 05.07.2018 14:56, Boris Brezillon wrote:
> On Thu,  5 Jul 2018 13:14:58 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> By calling spi_mem_get_name(), the driver of the (Q)SPI controller can
>> set a custom name for the memory device if necessary.
>> This is useful to keep mtdparts compatible when controller drivers are
>> ported from the MTD to the SPI layer.
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>>   drivers/mtd/devices/m25p80.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
>> index e84563d..482f0ef 100644
>> --- a/drivers/mtd/devices/m25p80.c
>> +++ b/drivers/mtd/devices/m25p80.c
>> @@ -199,8 +199,7 @@ static int m25p_probe(struct spi_mem *spimem)
>>   			hwcaps.mask |= SNOR_HWCAPS_READ_1_2_2;
>>   	}
>>   
>> -	if (data && data->name)
>> -		nor->mtd.name = data->name;
>> +	nor->mtd.name = spi_mem_get_name(spimem);
> 
> Hm, not sure you can do that without breaking setup that pass a
> flash_platform_data object with a name.
> 
> Also, you should keep the name extracted from the label property if any
> (this is done earlier, when spi_nor_set_flash_node() is called).
> 
> 	if (data && data->name)
> 		nor->mtd.name = data->name;
> 
> 	if (!nor->mtd.name)
> 		nor->mtd.name = spi_mem_get_name(spimem);

I missed both facts, that data could be passed with a name assigned 
already and that spi_nor_set_flash_node() might assign a name from dt.
I should have looked at the code more closely.

Thanks for pointing that out. I'll fix it.

Frieder

> 
>>   
>>   	/* For some (historical?) reason many platforms provide two different
>>   	 * names in flash_platform_data: "name" and "type". Quite often name is
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
