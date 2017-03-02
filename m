From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] spi: zynqmp: Add runtime support
Date: Thu, 2 Mar 2017 07:09:56 -0800
Message-ID: <20170302150956.ogsvx7nrpkwbu33k@xsjsorenbubuntu.xilinx.com>
References: <1488446552-15689-1-git-send-email-shubhrajyoti.datta@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, <michal.simek-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        <shubhrajyoti.datta-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1488446552-15689-1-git-send-email-shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, 2017-03-02 at 14:52:32 +0530, Shubhrajyoti Datta wrote:
> Add runtime support for the zynqmp qspi driver.

runtime PM

A little more detail about why, what and how things are changed would be
nice.

> 
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 90 ++++++++++++++++++++++++++++++++++--------
>  1 file changed, 74 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index 0b3ba7a..980877a 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -20,6 +20,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/of_address.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_runtime.h>
>  #include <linux/spi/spi.h>
>  #include <linux/spinlock.h>
>  #include <linux/workqueue.h>
> @@ -156,6 +157,7 @@
>  #define GQSPI_FREQ_150MHZ	150000000
>  #define IOU_TAPDLY_BYPASS_MASK	0x7
>  
> +#define SPI_AUTOSUSPEND_TIMEOUT		3000
>  enum mode_type {GQSPI_MODE_IO, GQSPI_MODE_DMA};
>  
>  /**
> @@ -424,21 +426,9 @@ static void zynqmp_qspi_copy_read_data(struct zynqmp_qspi *xqspi,
>  static int zynqmp_prepare_transfer_hardware(struct spi_master *master)
>  {
>  	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
> -	int ret;
> -
> -	ret = clk_enable(xqspi->refclk);
> -	if (ret)
> -		return ret;
> -
> -	ret = clk_enable(xqspi->pclk);
> -	if (ret)
> -		goto clk_err;

Isn't there a pm_runtime_get_sync() needed now? Or how is the
clk_enable/resume triggered now?

>  
>  	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, GQSPI_EN_MASK);
>  	return 0;
> -clk_err:
> -	clk_disable(xqspi->refclk);
> -	return ret;
>  }
>  
>  /**
> @@ -455,8 +445,6 @@ static int zynqmp_unprepare_transfer_hardware(struct spi_master *master)
>  	struct zynqmp_qspi *xqspi = spi_master_get_devdata(master);
>  
>  	zynqmp_gqspi_write(xqspi, GQSPI_EN_OFST, 0x0);
> -	clk_disable(xqspi->refclk);
> -	clk_disable(xqspi->pclk);

Similar here, shouldn't the device be pm_runtime_put() here?

	Sören
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
