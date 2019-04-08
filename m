From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [LINUX PATCH v2 3/3] spi: spi-mem: Add support for Zynq QSPI
 controller
Date: Mon, 8 Apr 2019 10:51:57 -0700
Message-ID: <20190408175157.GA11988@roeck-us.net>
References: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: broonie@kernel.org, bbrezillon@kernel.org, vigneshr@ti.com,
        linux-spi@vger.kernel.org, dwmw2@infradead.org,
        marek.vasut@gmail.com, richard@nod.at,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        michal.simek@xilinx.com, nagasuresh12@gmail.com
To: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1554105553-20207-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, Apr 01, 2019 at 01:29:13PM +0530, Naga Sureshkumar Relli wrote:
> Add support for QSPI controller driver used by Xilinx Zynq SOC.
> 
> Signed-off-by: Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
> ---
> Changes in v2
>  - Updated the driver to call spi_mem_default_supports_op() from
>    ctrl->supports_op()
> Changes in v1
>  - Added COMPILE_TEST macro
>  - converted MASKs to GENMASK() and BIT() macros
>  - Renamed MODEBITS to ZYNQ_QSPI_MODEBITS
>  - Removed checking buswidth() code, as it is already handled by framework
>  - Updated in comments regarding baud rate calculation
> ---
>  drivers/spi/Kconfig         |  10 +-
>  drivers/spi/Makefile        |   1 +
>  drivers/spi/spi-zynq-qspi.c | 761 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 771 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/spi/spi-zynq-qspi.c
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 9f89cb1..7bf7d38 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -816,9 +816,17 @@ config SPI_XTENSA_XTFPGA
>  	  16 bit words in SPI mode 0, automatically asserting CS on transfer
>  	  start and deasserting on end.
>  
> +config SPI_ZYNQ_QSPI
> +	tristate "Xilinx Zynq QSPI controller"
> +	depends on ARCH_ZYNQ || COMPILE_TEST

This results in

drivers/spi/spi-zynq-qspi.c: In function 'zynq_qspi_write_op':
drivers/spi/spi-zynq-qspi.c:410:3: error: implicit declaration of function 'writesl'; did you mean 'writel'?

drivers/spi/spi-zynq-qspi.c: In function 'zynq_qspi_read_op':
drivers/spi/spi-zynq-qspi.c:436:3: error: implicit declaration of function 'readsl'; did you mean 'readl'?

when building allmodconfig/allyesconfig on architectures not supporting
writesl/readsl (such as alpha or parisc).

Guenter
