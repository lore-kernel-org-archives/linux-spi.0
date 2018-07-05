From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH v2 01/12] spi: spi-mem: Extend the SPI mem interface to
 set a custom memory name
Date: Thu, 5 Jul 2018 14:50:49 +0200
Message-ID: <b478c9a2-2c58-bbd7-1a9b-66d8c86ccc45@exceet.de>
References: <1530789310-16254-1-git-send-email-frieder.schrempf@exceet.de>
 <1530789310-16254-2-git-send-email-frieder.schrempf@exceet.de>
 <20180705143948.2c864bf6@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 linux-kernel@vger.kernel.org, shawnguo@kernel.org, linux-spi@vger.kernel.org,
 marek.vasut@gmail.com, han.xu@nxp.com, broonie@kernel.org,
 linux-mtd@lists.infradead.org, miquel.raynal@bootlin.com,
 fabio.estevam@nxp.com, david.wolfe@nxp.com, computersforpeace@gmail.com,
 dwmw2@infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180705143948.2c864bf6@bbrezillon>
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

On 05.07.2018 14:39, Boris Brezillon wrote:
> Hi Frieder,
> 
> On Thu,  5 Jul 2018 13:14:57 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> When porting (Q)SPI controller drivers from the MTD layer to the SPI
>> layer, the naming scheme for the memory devices changes. To be able
>> to keep compatibility with the old drivers naming scheme, a function
>> is added to the SPI mem interface to let controller drivers set a
>> custom name for the memory.
>>
>> Example for the FSL QSPI driver:
>>
>> Name with the old driver: 21e0000.qspi,
>> or with multiple devices: 21e0000.qspi-0, 21e0000.qspi-1, ...
>>
>> Name with the new driver without spi_mem_get_name: spi4.0
>>
>> Signed-off-by: Frieder Schrempf <frieder.schrempf@exceet.de>
>> ---
>> Changes in v2:
>> ==============
>> * Add a name field to struct spi_mem and fill it while probing
>>
>>   drivers/spi/spi-mem.c       | 30 ++++++++++++++++++++++++++++++
>>   include/linux/spi/spi-mem.h |  7 ++++++-
>>   2 files changed, 36 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/spi/spi-mem.c b/drivers/spi/spi-mem.c
>> index 990770d..048101c 100644
>> --- a/drivers/spi/spi-mem.c
>> +++ b/drivers/spi/spi-mem.c
>> @@ -311,6 +311,26 @@ int spi_mem_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>>   EXPORT_SYMBOL_GPL(spi_mem_exec_op);
>>   
>>   /**
>> + * spi_mem_get_name() - Let drivers using the SPI mem interface specify a
>> + *			custom name for the memory to avoid compatibility
>> + *			issues with ported drivers.
> 
> You're not describing what this function does, but why it was
> introduced. Not sure the spi-mem user/driver cares about that, these are
> just internal details. Probably something you should put in the
> ->get_name() hook doc.

Ok. You're right.

> 
>> + * @mem: the SPI memory
>> + *
>> + * When porting (Q)SPI controller drivers from the MTD layer to the SPI
>> + * layer, the naming scheme for the memory devices changes. To be able to
>> + * keep compatibility with the old drivers naming scheme, this function can
>> + * be used to get a custom name from the controller driver.
>> + * If no custom name is available, the name of the SPI device is returned.
> 
> Ditto. Just say that this function returns the spi-mem device name which
> can be used by the upper layer if they need to expose a user-friendly
> name.

Ok.

> 
>> + *
>> + * Return: a char array that contains the name for the flash memory
> 
> 	      ^ a string?
> 
>       Return: a string containing the name of the memory device to be
> 	     used by the spi-mem user

Ok.

> 
>> + */
>> +const char *spi_mem_get_name(struct spi_mem *mem)
>> +{
>> +	return mem->name;
>> +}
>> +EXPORT_SYMBOL_GPL(spi_mem_get_name);
>> +
>> +/**
>>    * spi_mem_adjust_op_size() - Adjust the data size of a SPI mem operation to
>>    *			      match controller limitations
>>    * @mem: the SPI memory
>> @@ -344,6 +364,7 @@ static inline struct spi_mem_driver *to_spi_mem_drv(struct device_driver *drv)
>>   static int spi_mem_probe(struct spi_device *spi)
>>   {
>>   	struct spi_mem_driver *memdrv = to_spi_mem_drv(spi->dev.driver);
>> +	struct spi_controller *ctlr = spi->controller;
>>   	struct spi_mem *mem;
>>   
>>   	mem = devm_kzalloc(&spi->dev, sizeof(*mem), GFP_KERNEL);
>> @@ -351,6 +372,15 @@ static int spi_mem_probe(struct spi_device *spi)
>>   		return -ENOMEM;
>>   
>>   	mem->spi = spi;
>> +
>> +	if (ctlr->mem_ops && ctlr->mem_ops->get_name)
>> +		mem->name = ctlr->mem_ops->get_name(mem);
>> +	else
>> +		mem->name = dev_name(&spi->dev);
>> +
>> +	if (IS_ERR_OR_NULL(mem->name))
>> +		return PTR_ERR(mem->name);
>> +
>>   	spi_set_drvdata(spi, mem);
>>   
>>   	return memdrv->probe(mem);
>> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
>> index 4fa34a2..c3f82d1 100644
>> --- a/include/linux/spi/spi-mem.h
>> +++ b/include/linux/spi/spi-mem.h
>> @@ -124,7 +124,8 @@ struct spi_mem_op {
>>   /**
>>    * struct spi_mem - describes a SPI memory device
>>    * @spi: the underlying SPI device
>> - * @drvpriv: spi_mem_drviver private data
>> + * @drvpriv: spi_mem_driver private data
> 
> Can you fix this typo in a separate patch?

Ok. I'll move it to a separate patch.

> 
>> + * @name: name of the SPI memory device
>>    *
>>    * Extra information that describe the SPI memory device and may be needed by
>>    * the controller to properly handle this device should be placed here.
>> @@ -135,6 +136,7 @@ struct spi_mem_op {
>>   struct spi_mem {
>>   	struct spi_device *spi;
>>   	void *drvpriv;
>> +	char *name;
>>   };
>>   
>>   /**
>> @@ -178,6 +180,7 @@ struct spi_controller_mem_ops {
>>   			    const struct spi_mem_op *op);
>>   	int (*exec_op)(struct spi_mem *mem,
>>   		       const struct spi_mem_op *op);
>> +	const char *(*get_name)(struct spi_mem *mem);
> 
> You forgot to document this hook. Also, it's important to mention that
> if the name returned by this function is dynamically allocated, it
> should be allocated with devm_xxxx(), because we don't have a
> ->free_name() function.

Indeed. I'll add the documentation.

Thanks,
Frieder

> 
>>   };
>>   
>>   /**
>> @@ -236,6 +239,8 @@ bool spi_mem_supports_op(struct spi_mem *mem,
>>   int spi_mem_exec_op(struct spi_mem *mem,
>>   		    const struct spi_mem_op *op);
>>   
>> +const char *spi_mem_get_name(struct spi_mem *mem);
>> +
>>   int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>>   				       struct module *owner);
>>   
> 
> Thanks,
> 
> Boris
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
