From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
Date: Thu, 9 Jan 2020 15:54:00 +0000
Message-ID: <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        <xuejiancheng@hisilicon.com>, <fengsheng5@huawei.com>,
        <chenxiang66@hisilicon.com>
To: <broonie@kernel.org>, <marek.vasut@gmail.com>,
        <tudor.ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1575900490-74467-3-git-send-email-john.garry@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 09/12/2019 14:08, John Garry wrote:
> +	if (ret)
> +		return ret;
> +
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		hisi_sfc_v3xx_read_databuf(host, op->data.buf.in, len);
> +
> +	return 0;
> +}
> +
> +static int hisi_sfc_v3xx_exec_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)
> +{
> +	struct hisi_sfc_v3xx_host *host;
> +	struct spi_device *spi = mem->spi;
> +	u8 chip_select = spi->chip_select;
> +
> +	host = spi_controller_get_devdata(spi->master);
> +
> +	return hisi_sfc_v3xx_generic_exec_op(host, op, chip_select);
> +}
> +
> +static const struct spi_controller_mem_ops hisi_sfc_v3xx_mem_ops = {
> +	.adjust_op_size = hisi_sfc_v3xx_adjust_op_size,
> +	.exec_op = hisi_sfc_v3xx_exec_op,
> +};
> +
> +static int hisi_sfc_v3xx_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct hisi_sfc_v3xx_host *host;
> +	struct spi_controller *ctlr;
> +	u32 version;
> +	int ret;
> +
> +	ctlr = spi_alloc_master(&pdev->dev, sizeof(*host));
> +	if (!ctlr)
> +		return -ENOMEM;
> +


Hi Mark,

> +	ctlr->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD |
> +			  SPI_TX_DUAL | SPI_TX_QUAD;

I have an issue with dual/quad support. I naively thought that setting 
these bits would give me the highest protocol available.

However, now I notice that spi_device.mode needs to be set for supported 
protocols for the slave - I'm using the generic spi mem ops to check if 
protocols are supported based on this value.

 From checking acpi_spi_add_resource() or anywhere else, I cannot see 
how SPI_RX_DUAL or the others are set for spi_device.mode. What am I 
missing? Are these just not supported yet for ACPI? Or should the 
spi-nor code not be relying on this since we should be able to get this 
info from the SPI NOR part?

Cheers,
John

> +
> +	host = spi_controller_get_devdata(ctlr);
> +	host->dev = dev;
> +
> +	platform_set_drvdata(pdev, host);
> +
> +	host->regbase = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(host->regbase)) {
> +		ret = PTR_ERR(host->regbase);
> +		goto err_put_master;
