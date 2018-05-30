From: Frieder Schrempf <frieder.schrempf@exceet.de>
Subject: Re: [PATCH 03/11] spi: Add a driver for the Freescale/NXP QuadSPI
 controller
Date: Wed, 30 May 2018 17:13:44 +0200
Message-ID: <e55af89e-71ac-136e-09c6-98d20e133b78@exceet.de>
References: <1527686082-15142-1-git-send-email-frieder.schrempf@exceet.de>
 <1527686082-15142-4-git-send-email-frieder.schrempf@exceet.de>
 <20180530165816.371dc39c@bbrezillon>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: yogeshnarayan.gaur@nxp.com, richard@nod.at, prabhakar.kushwaha@nxp.com,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org, marek.vasut@gmail.com,
 han.xu@nxp.com, broonie@kernel.org, linux-mtd@lists.infradead.org,
 miquel.raynal@bootlin.com, fabio.estevam@nxp.com, david.wolfe@nxp.com,
 computersforpeace@gmail.com, dwmw2@infradead.org
To: Boris Brezillon <boris.brezillon@bootlin.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <20180530165816.371dc39c@bbrezillon>
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

On 30.05.2018 16:58, Boris Brezillon wrote:
> Hi Frieder,
> 
> On Wed, 30 May 2018 15:14:32 +0200
> Frieder Schrempf <frieder.schrempf@exceet.de> wrote:
> 
>> +
>> +static const char *fsl_qspi_get_name(struct spi_mem *mem)
>> +{
>> +	struct fsl_qspi *q = spi_controller_get_devdata(mem->spi->master);
>> +	struct device *dev = &mem->spi->dev;
>> +	const char *name;
>> +
>> +	/*
>> +	 * In order to keep mtdparts compatible with the old MTD driver at
>> +	 * mtd/spi-nor/fsl-quadspi.c, we set a custom name derived from the
>> +	 * platform_device of the controller.
>> +	 */
>> +	if (of_get_available_child_count(q->dev->of_node) == 1)
>> +		name = dev_name(q->dev);
>> +	else
>> +		name = devm_kasprintf(dev, GFP_KERNEL,
>> +				      "%s-%d", dev_name(q->dev),
>> +				      mem->spi->chip_select);
>> +
>> +	if (!name) {
>> +		dev_err(dev, "failed to get memory for custom flash name\n");
>> +		return dev_name(q->dev);
> 
> Hm, not sure that's what we want. We should probably fail when the
> allocation fails.

Right, we should definitely fail when the allocation fails.

> 
> How about letting ->get_name() return an error pointer or NULL in case
> of error. With the other I made suggestion in my review of patch 1
> (calling ->get_name() at probe time) you could refuse to probe the
> device when ->get_name() fails.

Ok, I will change that.

Thanks,

Frieder

> 
>> +	}
>> +
>> +	return name;
>> +}
>> +
> 
> Regards,
> 
> Boris
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
