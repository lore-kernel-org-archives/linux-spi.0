From: "Mahadevan, Girish" <girishm@codeaurora.org>
Subject: Re: [PATCH] spi: spi-geni-qcom: Add SPI driver support for GENI based
 QUP
Date: Mon, 7 May 2018 15:40:46 -0600
Message-ID: <a9146e14-19d6-c718-a5d8-64aba6db5465@codeaurora.org>
References: <1525383283-18390-1-git-send-email-girishm@codeaurora.org>
 <20180503233849.GF13402@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        sdharia@codeaurora.org, kramasub@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        swboyd@chromium.org
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180503233849.GF13402@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark

On 5/3/2018 5:38 PM, Mark Brown wrote:
> On Thu, May 03, 2018 at 03:34:43PM -0600, Girish Mahadevan wrote:
>> This driver supports GENI based SPI Controller in the Qualcomm SOCs. The
>> Qualcomm Generic Interface (GENI) is a programmable module supporting a
>> wide range of serial interfaces including SPI. This driver supports SPI
>> operations using FIFO mode of transfer.
> 
> This is a DT based driver but there is no binding documentation.
> Binding documentation is required for any new DT stuff.
>

The DT documentation for the SPI driver was done as part of this patch
series
https://patchwork.kernel.org/patch/10318125/

>> +       depends on ARCH_QCOM || (ARM && COMPILE_TEST)
> > Why the ARM dependency?  There's no architecture specific headers
> included...

Agree, I will remove it. I will add the dependency on QCOM_GENI_SE(to be
consistent with the other GENI_QUP protocol drivers (I2C and UART))

>>  obj-$(CONFIG_SPI_PXA2XX_PCI)		+= spi-pxa2xx-pci.o
>>  obj-$(CONFIG_SPI_QUP)			+= spi-qup.o
>> +obj-$(CONFIG_SPI_QCOM_GENI)		+= spi-geni-qcom.o
>>  obj-$(CONFIG_SPI_ROCKCHIP)		+= spi-rockchip.o
> 
> Please keep Kconfig and Makefile alphabetically sorted to reduce
> conflicts.
> 
Ok.
>> +static struct spi_master *get_spi_master(struct device *dev)
>> +{
>> +	struct platform_device *pdev = to_platform_device(dev);
>> +	struct spi_master *spi = platform_get_drvdata(pdev);
>> +
>> +	return spi;
>> +}
> 
> This doesn't look at all driver specific with the current naming but it
> actually is given that other drivers may use other driver data so it
> should be renamed.  I'm also not clear why it's bouncing through the
> platform device, dev_get_drvdata() exists.
> 
Agree, this function isn't needed, dev_get_drvdata() should be sufficient.
>> +static int spi_geni_unprepare_message(struct spi_master *spi_mas,
>> +					struct spi_message *spi_msg)
>> +{
>> +	struct spi_geni_master *mas = spi_master_get_devdata(spi_mas);
>> +
>> +	mas->cur_speed_hz = 0;
>> +	mas->cur_word_len = 0;
>> +	return 0;
>> +}
> 
> Is this really useful?  If the driver needs to reconfigure for every
> message then it should just do that and not care about the state.  If it
> might end up caring about the state anyway that suggests there's some
> kind of bug somewhere that's being masked.
> 
Agree, it can be removed.
>> +static int spi_geni_prepare_transfer_hardware(struct spi_master *spi)
>> +{
>> +	struct spi_geni_master *mas = spi_master_get_devdata(spi);
>> +	int ret = 0;
>> +	struct geni_se *se = &mas->se;
>> +
>> +	ret = pm_runtime_get_sync(mas->dev);
>> +	if (ret < 0) {
> 
> Use auto_runtime_pm.
> 
Ok
>> +	if (unlikely(!mas->setup)) {
>> +		int proto = geni_se_read_proto(se);
> 
> Does this really need a likely/unlikely annotation - it shouldn't be any
> kind of hot path...  There's a lot of these annotations in the code.
> 
Ok
>> +		ret = devm_request_irq(mas->dev, mas->irq, geni_spi_isr,
>> +			       IRQF_TRIGGER_HIGH, "spi_geni", mas);
>> +		if (ret) {
>> +			dev_err(mas->dev, "Request_irq failed:%d: err:%d\n",
> 
> Why are we dynamically requesting the IRQ outside of probe?  Normally an
> interrupt is requested on startup and held through the life of the
> device.  I'm also not seeing any sign that it's freed except via devm...
> 
Ok, will move this to probe.
>> +	spi->bus_num = of_alias_get_id(pdev->dev.of_node, "spi");
> 
> Don't do this, just set bus_num to -1 and let the core assign an ID.
> 
Ok.
>> +	spi->dev.of_node = pdev->dev.of_node;
> 
> This is broken, the virtual SPI device does not exist in DT and this
> might break things.
> 
I don't follow, if I don't do this the framework won't be able to probe
the slave devices of the controller.
>> +	pm_runtime_enable(&pdev->dev);
>> +	ret = spi_register_master(spi);
> 
> No devm?
> 
Agree, I will change this to use devm_spi_register_master()

Best Regards
Girish
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora
Forum, a Linux Foundation Collaborative Project.
