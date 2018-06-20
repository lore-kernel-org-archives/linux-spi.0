From: Piotr Bugalski <bugalski.piotr@gmail.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
Date: Wed, 20 Jun 2018 16:31:13 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1806201627330.26137@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com> <20180618162124.21749-2-bugalski.piotr@gmail.com> <20180619151506.GG11230@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619151506.GG11230@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Mark,

Thank you very much for quick answer.

On Tue, 19 Jun 2018, Mark Brown wrote:

> On Mon, Jun 18, 2018 at 06:21:23PM +0200, Piotr Bugalski wrote:
>
>> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
>> +{
>> +	return 0;
>> +}
>
> If this can be empty should we adjust the callers to allow it to just be
> omitted?
>

If I remember well some commits ago spi-mem required even empty 
adjust_op_size. Now it seems unnecessary, but I forgot to remove the 
code. I will fix it in next version.

>> +static int atmel_qspi_remove(struct platform_device *pdev)
>> +{
>> +	struct spi_controller *ctrl = platform_get_drvdata(pdev);
>> +	struct atmel_qspi *aq = spi_controller_get_devdata(ctrl);
>> +
>> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIDIS);
>> +	clk_disable_unprepare(aq->clk);
>> +
>> +	spi_unregister_controller(ctrl);
>> +
>> +	return 0;
>> +}
>
> You should unregister the controller before disabling the hardware,
> otherwise something could come in and try to start an operation on the
> controller (or already be running one) while the hardware is disabled
> which might blow up.
>

Sure, deinit should be done in reverse order of init, you are perfectly 
right, just my mistake. I'll fix it in next version.

Best Regards,
Piotr
