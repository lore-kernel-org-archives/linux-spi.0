From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1 2/3] spi: pxa2xx: Introduce dma-burst-sz property
 support
Date: Tue, 26 Feb 2019 13:46:49 +0200
Message-ID: <b845fbcf-d9d9-f682-9604-31c7a9c8c418@linux.intel.com>
References: <20190226092441.49198-1-andriy.shevchenko@linux.intel.com>
 <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 devicetree@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226092441.49198-2-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
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

On 2/26/19 11:24 AM, Andy Shevchenko wrote:
> Some masters may have different DMA burst size than hard coded default.
> In such case respect the value given by dma-burst-size property.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
>   drivers/spi/spi-pxa2xx-pci.c   | 8 +++++++-
>   drivers/spi/spi-pxa2xx.c       | 5 ++++-
>   include/linux/spi/pxa2xx_spi.h | 1 +
>   4 files changed, 15 insertions(+), 3 deletions(-)
...
> @@ -1566,9 +1568,10 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
>   	ssp->pdev = pdev;
>   	ssp->port_id = pxa2xx_spi_get_port_id(adev);
>   
> -	pdata->is_slave = of_property_read_bool(pdev->dev.of_node, "spi-slave");
> +	pdata->is_slave = device_property_read_bool(dev, "spi-slave");

Unrelated change. Not sure is it worth of its own patch.

-- 
Jarkko
