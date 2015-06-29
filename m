From: Ranjit Abhimanyu Waghmode <ranjit.waghmode@xilinx.com>
Subject: RE: [PATCH] spi: SPI_ZYNQMP_GQSPI should depend on HAS_DMA
Date: Mon, 29 Jun 2015 06:00:08 +0000
Message-ID: <7CFCFE83B8145347A1D424EC939F1C3CA763F3@XAP-PVEXMBX01.xlnx.xilinx.com>
References: <1435320432-4855-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Mark Brown <broonie@kernel.org>,
	Michal Simek <michals@xilinx.com>,
	Soren Brinkmann <sorenb@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1435320432-4855-1-git-send-email-geert@linux-m68k.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Acked-by: Ranjit Waghmode <ranjitw@xilinx.com>

> -----Original Message-----
> From: Geert Uytterhoeven [mailto:geert@linux-m68k.org]
> Sent: Friday, June 26, 2015 5:37 PM
> To: Mark Brown; Ranjit Abhimanyu Waghmode
> Cc: linux-spi@vger.kernel.org; linux-kernel@vger.kernel.org; Geert
> Uytterhoeven
> Subject: [PATCH] spi: SPI_ZYNQMP_GQSPI should depend on HAS_DMA
>
> If NO_DMA=y:
>
>     ERROR: "dma_unmap_single" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!
>     ERROR: "dma_mapping_error" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!
>     ERROR: "dma_map_single" [drivers/spi/spi-zynqmp-gqspi.ko] undefined!
>
> Add a dependency on HAS_DMA to fix this.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
>  drivers/spi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig index
> 1c0b261b66fcfdcb..b787b515bd73322b 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -618,7 +618,7 @@ config SPI_XTENSA_XTFPGA
>
>  config SPI_ZYNQMP_GQSPI
>       tristate "Xilinx ZynqMP GQSPI controller"
> -     depends on SPI_MASTER
> +     depends on SPI_MASTER && HAS_DMA
>       help
>         Enables Xilinx GQSPI controller driver for Zynq UltraScale+ MPSoC.
>
> --
> 1.9.1



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
