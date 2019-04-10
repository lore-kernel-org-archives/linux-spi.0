From: YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH v2] spi: spi-mem: Fix build error without CONFIG_SPI_MEM
Date: Wed, 10 Apr 2019 20:20:32 +0800
Message-ID: <31c64408-a290-4135-ec33-0401133dbfef@huawei.com>
References: <20190408143949.10688-1-yuehaibing@huawei.com>
 <20190410121341.17560-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <vigneshr@ti.com>
To: <broonie@kernel.org>, <naga.sureshkumar.relli@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190410121341.17560-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Well, Naga Sureshkumar Relli has post new patch based this, Pls ignore this.

On 2019/4/10 20:13, Yue Haibing wrote:
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
> v2: make stub helper static inline
> ---
>  include/linux/spi/spi-mem.h | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> index c845cd6..3d57db8 100644
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
> @@ -310,6 +314,14 @@ spi_controller_dma_unmap_mem_op_data(struct spi_controller *ctlr,
>  				     struct sg_table *sg)
>  {
>  }
> +
> +static inline bool
> +spi_mem_default_supports_op(struct spi_mem *mem,
> +			    const struct spi_mem_op *op)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_SPI_MEM */
>  
>  int spi_mem_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op);
> @@ -341,9 +353,6 @@ int spi_mem_driver_register_with_owner(struct spi_mem_driver *drv,
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
