From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [RFC PATCH spi] spi: pxa2xx: pxa2xx_spi_transfer_one() can be
 static
Date: Wed, 18 Apr 2018 09:04:48 +0300
Message-ID: <22cf611b-6a88-ec72-bb3c-51f8b62a8019@linux.intel.com>
References: <201804180300.Pn9JAJQ2%fengguang.wu@intel.com>
 <20180417195323.GA69680@ivb43>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: kbuild-all@01.org, linux-spi@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: kbuild test robot <lkp@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180417195323.GA69680@ivb43>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 04/17/18 22:53, kbuild test robot wrote:
> 
> Fixes: d5898e19c0d7 ("spi: pxa2xx: Use core message processing loop")
> Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
> ---
>   spi-pxa2xx.c |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index c852ea5..40f1346 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -911,9 +911,9 @@ static bool pxa2xx_spi_can_dma(struct spi_controller *master,
>   	       xfer->len >= chip->dma_burst_size;
>   }
>   
> -int pxa2xx_spi_transfer_one(struct spi_controller *master,
> -			    struct spi_device *spi,
> -			    struct spi_transfer *transfer)
> +static int pxa2xx_spi_transfer_one(struct spi_controller *master,
> +				   struct spi_device *spi,
> +				   struct spi_transfer *transfer)

Thanks Fengguang. I don't understand how I managed to drop "static" 
while doing manual s/pump_transfers/pxa2xx_spi_transfer_one/ :-)

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
