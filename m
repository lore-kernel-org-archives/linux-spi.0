From: Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Date: Tue, 9 Apr 2019 22:00:17 +0530
Message-ID: <4c9cb550-e0b6-8f66-979d-ab8237e28166@ti.com>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>, <broonie@kernel.org>,
        <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190408143949.10688-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 08/04/19 8:09 PM, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> When building with CONFIG_SPI_MEM is not set
> gc warns this:
> 
> drivers/spi/spi-zynq-qspi.o: In function `zynq_qspi_supports_op':
> spi-zynq-qspi.c:(.text+0x1da): undefined reference to `spi_mem_default_supports_op'
> 
> Fixes: 67dca5e580f1 ("spi: spi-mem: Add support for Zynq QSPI controller")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  include/linux/spi/spi-mem.h | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index c845cd6..1941b84 100644
> --- a/include/linux/spi/spi-mem.h
> +++ b/include/linux/spi/spi-mem.h
> @@ -295,6 +295,10 @@ int spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
>  void spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  					  const struct spi_mem_op *op,
>  					  struct sg_table *sg);
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op);
> +
>  #else
>  static inline int
>  spi_controller_dma_map_mem_op_data(struct spi_controller *ctlr,
> @@ -310,6 +314,13 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  				     struct sg_table *sg)
>  {
>  }
> +
> +bool spi_mem_default_supports_op(struct spi_mem *mem,
> +				 const struct spi_mem_op *op)

This needs to be declared static inline to avoid multiple definitions.
Right?

> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SPI_MEM */
>  
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> @@ -341,9 +352,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
>  
>  void spi_mem_driver_unregister(struct spi_mem_driver *drv);
>  
> -bool spi_mem_default_supports_op(struct spi_mem *mem,
> -				 const struct spi_mem_op *op);
> -
>  #define spi_mem_driver_register(__drv)                                  \
>  	spi_mem_driver_register_with_owner(__drv, THIS_MODULE)
>  
> 

-- 
Regards
Vignesh
