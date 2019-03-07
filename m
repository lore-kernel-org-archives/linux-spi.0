From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH] [RFC] spi: pxa2xx: Do cs if restart the SSP during
 pxa2xx_spi_transfer_one()
Date: Thu, 7 Mar 2019 17:26:53 +0200
Message-ID: <cf5b89b6-e081-5ba2-2837-7d3cfde779ae@linux.intel.com>
References: <20190307072424.18820-1-jin.xiao@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: bo <bo.he@intel.com>
To: xiao jin <jin.xiao@intel.com>, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        broonie@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        yanmin.zhang@intel.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307072424.18820-1-jin.xiao@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi

Is this also related to the regression with d5898e19c0d7 ("spi: pxa2xx: 
Use core message processing loop") you have found or another issue?

Comments below.

On 3/7/19 9:24 AM, xiao jin wrote:
> The spi-pxa2xx can't read and write data correctly on our board.
> The pxa_ssp_type is LPSS_BXT_SSP in our case.
> 
> With more debug we find that it's related to restart the SPP
> during pxa2xx_spi_transfer_one().
> 
> In the normal case the spi_transfer_one_message() calls spi-pxa2xx
> cs_assert before transferring one message. After completing the
> transfer it calls spi-pxa2xx cs_deassert. The spi-pxa2xx works
> well.
> 
> But in some other case pxa2xx_spi_unprepare_transfer() is called
> that clears SSCR0_SSE bit before the next transfer. In the next
> transfer the spi-pxa2xx driver will restart the SSP as the SSE
> bit is cleared. The cs_assert before the SSP restart can't ensure
> spi-pxa2xx work well.
> 
> The patch is to do cs again if spi-pxa2xx restar the SSP during
> pxa2xx_spi_transfer_one()
> 
Hmm.. please correct me if I'm wrong but pxa2xx_spi_unprepare_transfer() 
is called always when there is no more messages pending and the spi core 
should have deasserted the CS already?

More below.

> Signed-off-by: xiao jin <jin.xiao@intel.com>
> Signed-off-by: he, bo <bo.he@intel.com>
> ---
>   drivers/spi/spi-pxa2xx.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 14f4ea59caff..1a2ea46858d9 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -928,6 +928,7 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>   	u32 cr1;
>   	int err;
>   	int dma_mapped;
> +	bool need_cs_change = false;
>   
>   	/* Check if we can DMA this transfer */
>   	if (transfer->len > MAX_DMA_LEN && chip->enable_dma) {
> @@ -1056,6 +1057,11 @@ static int pxa2xx_spi_transfer_one(struct spi_controller *master,
>   	if ((pxa2xx_spi_read(drv_data, SSCR0) != cr0)
>   	    || (pxa2xx_spi_read(drv_data, SSCR1) & change_mask)
>   	    != (cr1 & change_mask)) {
> +		/* It needs to deassert the chip selection
> +		 * firstly before restart the SPP */
> +		need_cs_change = true;
> +		cs_deassert(spi);
> +

I think code comes here at the beginning of each transfer so will be hit 
multiple times before pxa2xx_spi_unprepare_transfer() if SPI message 
consists of multiple transfers.

This makes me wondering if the device driver setting up the "struct 
spi_transfer" is maybe missing the cs_change flag set for transfers 
before last one in case HW needs CS toggling between transfers? For 
instance what following drivers are doing with the cs_change flag:

drivers/char/tpm/tpm_tis_spi.c: tpm_tis_spi_transfer()
drivers/input/touchscreen/ad7877.c: ad7877_read(), ad7877_read_adc()

-- 
Jarkko
