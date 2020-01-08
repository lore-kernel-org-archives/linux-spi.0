From: "Ramuthevar, Vadivel MuruganX"
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Subject: Re: [PATCH v6 2/2] spi: cadence-quadpsi: Add support for the Cadence
 QSPI controller
Date: Wed, 8 Jan 2020 13:55:59 +0800
Message-ID: <42773e8e-3c5e-c034-a1cb-864ed63b6937@linux.intel.com>
References: <20191230074102.50982-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20191230074102.50982-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <ac26ecfe-d45c-db70-df8f-91da32c9925a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Cc: robh+dt@kernel.org, dan.carpenter@oracle.com,
        cheol.yong.kim@intel.com, qi-ming.wu@intel.com
To: Vignesh Raghavendra <vigneshr@ti.com>, broonie@kernel.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ac26ecfe-d45c-db70-df8f-91da32c9925a@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Thank you for the review  comments and your time.

On 8/1/2020 1:25 PM, Vignesh Raghavendra wrote:
> Hi,
> [...]
> On 30/12/19 1:11 pm, Ramuthevar,Vadivel MuruganX wrote:
>> +static int cqspi_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct struct_cqspi *cqspi;
>> +	struct spi_master *master;
>> +	struct reset_control *rstc, *rstc_ocp;
>> +	const struct cqspi_driver_platdata *ddata;
>> +	struct cqspi_platform_data *pdata = NULL;
>> +	struct resource *res = NULL;
>> +	int ret;
>> +
>> +	master = spi_alloc_master(&pdev->dev, sizeof(*cqspi));
>> +	if (!master) {
>> +		dev_err(&pdev->dev, "spi_alloc_master failed\n");
>> +		return -ENOMEM;
>> +	}
>> +	master->mode_bits = SPI_RX_QUAD | SPI_TX_DUAL | SPI_RX_DUAL |
>> +				SPI_RX_OCTAL;
>> +	master->setup = cqspi_setup;
>> +	master->mem_ops = &cqspi_mem_ops;
>> +	master->dev.of_node = pdev->dev.of_node;
>> +	cqspi = spi_master_get_devdata(master);
>> +	cqspi->pdev = pdev;
>> +
>> +	pdata = devm_kmalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
> devm_kzalloc()?
Noted, will fix it.
>> +	if (!pdata)
>> +		return -ENOMEM;
>> +
>> +	pdev->dev.platform_data = pdata;
>> +
>> +	/* Obtain QSPI clock. */
>> +	cqspi->clk = devm_clk_get(&pdev->dev, "qspi");
> clock-name of "qspi" is not mandatory as per DT binding and current DT
> files don't have clock-names property. This therefore cause probe to
> fail. This should remain:
>
> 	cqspi->clk = devm_clk_get(&pdev->dev, "NULL");
sure , I will add NULL instead of "qspi"
>> +	if (IS_ERR(cqspi->clk)) {
>> +		dev_err(&pdev->dev, "cannot get qspi clk\n");
>> +		return PTR_ERR(cqspi->clk);
>> +	}
>> +	pdata->master_ref_clk_hz = clk_get_rate(cqspi->clk);
>> +
>> +	ret = clk_prepare_enable(cqspi->clk);
>> +	if (ret < 0) {
>> +		dev_err(&pdev->dev, "failed to enable qspi clock: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	/* Obtain configuration from OF. */
>> +	ret = cqspi_of_get_pdata(pdev);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "Get platform data failed.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	cqspi->res = res;
>> +	/* Obtain and remap controller address. */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	cqspi->iobase = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(cqspi->iobase)) {
>> +		dev_err(dev, "Cannot remap controller address.\n");
>> +		return PTR_ERR(cqspi->iobase);
>> +	}
>> +
>> +	/* Obtain and remap AHB address. */
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>> +	cqspi->qspi_ahb_virt = devm_ioremap_resource(dev, res);
>> +	if (IS_ERR(cqspi->qspi_ahb_virt)) {
>> +		dev_err(dev, "Cannot remap AHB address.\n");
>> +		return PTR_ERR(cqspi->qspi_ahb_virt);
>> +	}
>> +	cqspi->ahbbase = res;
>> +	cqspi->ahb_size = resource_size(res);
>> +
>> +	/* Obtain QSPI reset control */
>> +	rstc = devm_reset_control_get_optional_exclusive(dev, "qspi");
>> +	if (IS_ERR(rstc)) {
>> +		dev_err(dev, "Cannot get QSPI reset.\n");
>> +		return PTR_ERR(rstc);
>> +	}
>> +
>> +	rstc_ocp = devm_reset_control_get_optional_exclusive(dev, "qspi-ocp");
>> +	if (IS_ERR(rstc_ocp)) {
>> +		dev_err(dev, "Cannot get QSPI OCP reset.\n");
>> +		return PTR_ERR(rstc_ocp);
>> +	}
>> +
>> +	reset_control_assert(rstc);
>> +	reset_control_deassert(rstc);
>> +
>> +	reset_control_assert(rstc_ocp);
>> +	reset_control_deassert(rstc_ocp);
>> +
>> +	ddata  = of_device_get_match_data(dev);
>> +	if (ddata && (ddata->quirks & CQSPI_NEEDS_WR_DELAY))
>> +		cqspi->wr_delay = 5 * DIV_ROUND_UP(NSEC_PER_SEC,
>> +						   pdata->master_ref_clk_hz);
>> +
>> +	if (ddata && (ddata->quirks & CQSPI_DISABLE_DAC_MODE))
>> +		cqspi->use_dac_mode = false;
>> +
>> +	init_completion(&cqspi->transfer_complete);
>> +
>> +	/* Obtain IRQ line. */
>> +	cqspi->irq = platform_get_irq(pdev, 0);
>> +	if (cqspi->irq < 0) {
>> +		dev_err(dev, "platform_get_irq failed.\n");
>> +		ret = -ENXIO;
>> +	}
>> +	ret = devm_request_irq(dev, cqspi->irq, cqspi_irq_handler, 0,
>> +			       pdev->name, cqspi);
>> +	if (ret) {
>> +		dev_err(dev, "request_irq failed.\n");
>> +		goto out_clk_disable;
>> +	}
>> +
>> +	master->bus_num = pdata->bus_num;
>> +	master->num_chipselect = pdata->num_chipselect;
> Where is pdata->bus_num and pdata->num_chipselect initialized? This
> causes devm_spi_register_master() to fail randomly as num_chipselect may
> be 0.
Agreed!, I also observed the issue after sending the patches , will fix 
it in the next patch-set.
Regards
Vadivel
>> +	mutex_init(&cqspi->lock);
>> +	platform_set_drvdata(pdev, master);
>> +	cqspi_controller_init(cqspi);
>> +	cqspi->current_cs = -1;
>> +
>> +	ret = devm_spi_register_master(dev, master);
>> +	if (ret) {
>> +		dev_err(&pdev->dev, "devm_spi_register_master failed.\n");
>> +		goto err_of;
>> +	}
>> +
>> +	return 0;
>> +
>> +out_clk_disable:
>> +	clk_disable_unprepare(cqspi->clk);
>> +err_of:
>> +	spi_master_put(master);
>> +	dev_err(&pdev->dev, "Cadence QSPI controller probe failed\n");
>> +	return ret;
>> +}
>> +
