From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2] spi: pxa2xx: fix SCR (divisor) calculation
Date: Fri, 12 Apr 2019 15:35:38 +0300
Message-ID: <729d9db2-de3e-e64c-862d-db8a25775b02@linux.intel.com>
References: <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
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
In-Reply-To: <1555054339-17096-1-git-send-email-f.suligoi@asem.it>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 4/12/19 10:32 AM, Flavio Suligoi wrote:
> Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> that the SSP transmission rate can be greater than the device rate.
> 
> When the division between the SSP clock and the device rate generates
> a reminder, we have to increment by one the divisor.
> In this way the resulting SSP clock will never be greater than the
> device SPI max frequency.
> 
> For example, with:
> 
>   - ssp_clk  = 50 MHz
>   - dev freq = 15 MHz
> 
> without this patch the SSP clock will be greater than 15 MHz:
> 
>   - 25 MHz for PXA25x_SSP and CE4100_SSP
>   - 16,56 MHz for the others
> 
> Instead, with this patch, we have in both case an SSP clock of 12.5MHz,
> so the max rate of the SPI device clock is respected.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
> Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> 
> v2: - simplify the code using "DIV_ROUND_UP"
> v1: - first version
> 
>   drivers/spi/spi-pxa2xx.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index f7068cc..a35fdcb 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -884,10 +884,14 @@ static unsigned int ssp_get_clk_div(struct driver_data *drv_data, int rate)
>   
>   	rate = min_t(int, ssp_clk, rate);
>   
> +	/*
> +	 * Calculate the divisor for the SCR (Serial Clock Rate), avoiding
> +	 * that the SSP transmission rate can be greater than the device rate
> +	 */
>   	if (ssp->type == PXA25x_SSP || ssp->type == CE4100_SSP)
> -		return (ssp_clk / (2 * rate) - 1) & 0xff;
> +		return (DIV_ROUND_UP(ssp_clk, 2 * rate) - 1) & 0xff;
>   	else
> -		return (ssp_clk / rate - 1) & 0xfff;
> +		return (DIV_ROUND_UP(ssp_clk, rate) - 1)  & 0xfff;
>   }
>   
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
