From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property
 support
Date: Thu, 07 Mar 2019 20:24:24 +0100
Message-ID: <87ef7i5vyv.fsf@belgarion.home>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 linux-spi@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Jarkko Nikula <jarkko.nikula@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, Daniel Mack <daniel@zonque.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226092441.49198-2-andriy.shevchenko@linux.intel.com> (Andy
 Shevchenko's message of "Tue, 26 Feb 2019 12:24:40 +0300")
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> @@ -1512,6 +1513,7 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>  	const struct acpi_device_id *adev_id = NULL;
>  	const struct pci_device_id *pcidev_id = NULL;
>  	const struct of_device_id *of_id = NULL;
> +	struct device *dev = &pdev->dev;
>  	enum pxa_ssp_type type;
>  
>  	adev = ACPI_COMPANION(&pdev->dev);
> @@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>  	ssp->pdev = pdev;
>  	ssp->port_id = pxa2xx_spi_get_port_id(adev);
>  
> -	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
> +	pdata->is_slave = device_property_read_bool(dev, "spi-slave");
Isn't this an unrelated change to the introduction of dma-burst-sz ?

Other than this :
Reviewed-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

-- 
Robert
