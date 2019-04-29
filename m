From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH] spi: zynqmp: Fix build break
Date: Mon, 29 Apr 2019 09:28:13 -0700
Message-ID: <6d31dc90-7d0a-fc8d-cbc3-331200a01755@xilinx.com>
References: <2bb66114-c976-9c44-6db3-33a5dd12edde@monstr.eu>
 <20190429162246.6061-1-olof@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>
To: Olof Johansson <olof@lixom.net>, <linux-spi@vger.kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190429162246.6061-1-olof@lixom.net>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On 29. 04. 19 9:22, Olof Johansson wrote:
> Missing include:
> drivers/spi/spi-zynqmp-gqspi.c:1025:13: error: implicit declaration of
>   function 'zynqmp_pm_get_eemi_ops'; did you mean
>   'zynqmp_process_dma_irq'? [-Werror=implicit-function-declaration]
> 
> Fixes: 3d0313786470a ('drivers: Defer probe if firmware is not ready')
> Cc: Rajan Vaja <rajan.vaja@xilinx.com>
> Cc: Jolly Shah <jollys@xilinx.com>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqspi.c
> index d07b6f940f9f..9850a0efe85a 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -14,6 +14,7 @@
>  #include <linux/delay.h>
>  #include <linux/dma-mapping.h>
>  #include <linux/dmaengine.h>
> +#include <linux/firmware/xlnx-zynqmp.h>
>  #include <linux/interrupt.h>
>  #include <linux/io.h>
>  #include <linux/module.h>
> 


Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
