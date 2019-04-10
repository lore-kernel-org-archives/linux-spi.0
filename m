From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/1] spi: pxa2xx: add driver enabling message
Date: Wed, 10 Apr 2019 13:11:47 +0300
Message-ID: <ab279a3c-0870-8a9a-62d9-38b17670ed2f@linux.intel.com>
References: <358f26bc47bd4aa289971f0a763b27cb@asem.it>
 <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
To: Flavio Suligoi <f.suligoi@asem.it>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554889624-25000-1-git-send-email-f.suligoi@asem.it>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4/10/19 12:47 PM, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of:
> 
> - mode (slave device or master controller)
> - transfer mode (DMA or GPIO)
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
> 
> v1:	- first version
> v2:	- remove warning message "no DMA channels available, using PIO"
> 	- add "slave device"/"master controller" indication message
> 
>   drivers/spi/spi-pxa2xx.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..b9e04e2 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1696,7 +1696,6 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   	if (platform_info->enable_dma) {
>   		status = pxa2xx_spi_dma_setup(drv_data);
>   		if (status) {
> -			dev_warn(dev, "no DMA channels available, using PIO\n");
>   			platform_info->enable_dma = false;
>   		} else {
>   			controller->can_dma = pxa2xx_spi_can_dma;
> @@ -1818,6 +1817,10 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   	pm_runtime_set_active(&pdev->dev);
>   	pm_runtime_enable(&pdev->dev);
>   
> +	dev_info(dev, "PXA2xx SPI %s (%s mode)\n",
> +		platform_info->is_slave ? "slave device" : "master controller",
> +		platform_info->enable_dma ? "DMA" : "PIO");
> +

"slave device" is ambiguous. Please use "controller" with both, i.e. 
"PXA2xx SPI %s controller (%s mode)\n", ... ? "slave" : "master", ...

With that changed you may add:

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
