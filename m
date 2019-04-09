From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH 1/1] spi: pxa2xx: add driver enabling message
Date: Tue, 9 Apr 2019 16:48:10 +0300
Message-ID: <51e9e073-625d-f5c0-6b2e-410f6ddb6346@linux.intel.com>
References: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
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
In-Reply-To: <1554736964-6058-1-git-send-email-f.suligoi@asem.it>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi

On 4/8/19 6:22 PM, Flavio Suligoi wrote:
> Add an info message for the PXA2xx device driver start-up,
> with the indication of the transfer mode used (DMA or GPIO).
> 
> This info is useful to individuate the timing when
> the module starts.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> ---
>   drivers/spi/spi-pxa2xx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..d449501 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1826,6 +1826,9 @@ static int pxa2xx_spi_probe(struct platform_device *pdev)
>   		goto out_error_clock_enabled;
>   	}
>   
> +	dev_info(dev, "PXA2xx SPI master controller (%s mode)\n",
> +		 platform_info->enable_dma ? "DMA" : "PIO");
> +
>   	return status;
>   
Would this look better if moved before devm_spi_register_controller() call?

-- 
Jarkko
