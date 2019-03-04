From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 1/2] spi: pxa2xx: Introduce DMA burst size support
Date: Mon, 4 Mar 2019 14:37:23 +0200
Message-ID: <0ceb5c1f-d4c2-3bd6-5016-d1c579da19b6@linux.intel.com>
References: <20190226114921.48205-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226114921.48205-1-andriy.shevchenko@linux.intel.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org

On 2/26/19 1:49 PM, Andy Shevchenko wrote:
> Some masters may have different DMA burst size than hard coded default.
> In such case respect the value given by DMA burst size provided via
> platform data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
>   drivers/spi/spi-pxa2xx-pci.c   | 5 ++++-
>   drivers/spi/spi-pxa2xx.c       | 1 +
>   include/linux/spi/pxa2xx_spi.h | 1 +
>   4 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-dma.c b/drivers/spi/spi-pxa2xx-dma.c
> index 2fa7f4b43492..3343fff81c7b 100644
> --- a/drivers/spi/spi-pxa2xx-dma.c
> +++ b/drivers/spi/spi-pxa2xx-dma.c
> @@ -239,13 +239,15 @@ int pxa2xx_spi_set_dma_burst_and_threshold(struct chip_data *chip,
>   					   u32 *threshold)
>   {
>   	struct pxa2xx_spi_chip *chip_info = spi->controller_data;
> +	struct driver_data *drv_data = spi_controller_get_devdata(spi->controller);
> +	u32 dma_burst_size = drv_data->master_info->dma_burst_size;
>   
>   	/*
>   	 * If the DMA burst size is given in chip_info we use that,
>   	 * otherwise we use the default. Also we use the default FIFO
>   	 * thresholds for now.
>   	 */
> -	*burst_code = chip_info ? chip_info->dma_burst_size : 1;
> +	*burst_code = chip_info ? chip_info->dma_burst_size : dma_burst_size;
>   	*threshold = SSCR1_RxTresh(RX_THRESH_DFLT)
>   		   | SSCR1_TxTresh(TX_THRESH_DFLT);
>   
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index d3de925892cb..3faef7335137 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -5,7 +5,6 @@
>    */
>   #include <linux/clk-provider.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>

Minor note, no need to resend if ok to maintainers:
Unrelated change. Looks like already commit 0202775bc3a2 
("spi/pxa2xx-pci: switch to use pcim_* interfaces") made this needless.

Otherwise looks ok to me.

-- 
Jarkko
