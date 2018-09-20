From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 2/2] spi: Introduce new driver for Qualcomm QuadSPI
 controller
Date: Thu, 20 Sep 2018 15:46:22 -0700
Message-ID: <3b7c090f-42ef-1b5d-0708-0b3b52d49302@infradead.org>
References: <20180920224055.164856-1-ryandcase@chromium.org>
 <20180920224055.164856-2-ryandcase@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-msm@vger.kernel.org,
        Girish Mahadevan <girishm@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Ryan Case <ryandcase@chromium.org>, Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180920224055.164856-2-ryandcase@chromium.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

Just curious:

On 9/20/18 3:40 PM, Ryan Case wrote:
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index de03d67bcd2b..36922e12c3b0 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -549,6 +549,12 @@ config SPI_RSPI
>  	help
>  	  SPI driver for Renesas RSPI and QSPI blocks.
>  
> +config SPI_QCOM_QSPI
> +	tristate "QTI QPSPI controller"

	Is that       QPSPI correct?
	This is the only place that QPSPI or PSPI is used in this patch.


> +	depends on ARCH_QCOM
> +	help
> +	  QSPI(Quad SPI) driver for Qualcomm QSPI controller.
> +
>  config SPI_QUP
>  	tristate "Qualcomm SPI controller with QUP interface"
>  	depends on ARCH_QCOM || (ARM && COMPILE_TEST)


-- 
~Randy
