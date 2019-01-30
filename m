From: Boris Brezillon <bbrezillon@kernel.org>
Subject: Re: [PATCH 2/9] spi: atmel-quadspi: order header files inclusion
 alphabetically
Date: Wed, 30 Jan 2019 18:16:32 +0100
Message-ID: <20190130181616.175206b8@bbrezillon>
References: <20190130150818.24902-1-tudor.ambarus@microchip.com>
        <20190130150818.24902-3-tudor.ambarus@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: <broonie@kernel.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Ludovic.Desroches@microchip.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
To: <Tudor.Ambarus@microchip.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190130150818.24902-3-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, 30 Jan 2019 15:08:31 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Cosmetic change, no functional change.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>

Reviewed-by: Boris Brezillon <bbrezillon@kernel.com>

> ---
>  drivers/spi/atmel-quadspi.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index f79b17792a11..64475ad16c83 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -22,16 +22,15 @@
>   * This driver is based on drivers/mtd/spi-nor/fsl-quadspi.c from Freescale.
>   */
>  
> -#include <linux/kernel.h>
>  #include <linux/clk.h>
> -#include <linux/module.h>
> -#include <linux/platform_device.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
>  #include <linux/interrupt.h>
> -#include <linux/of.h>
> -
>  #include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
>  #include <linux/spi/spi-mem.h>
>  
>  /* QSPI register offsets */
