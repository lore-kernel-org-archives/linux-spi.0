From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v1] spi: pxa2xx-pci: Drop unused header inclusion
Date: Tue, 19 Mar 2019 09:04:46 +0200
Message-ID: <d7bda1b9-574c-8fd2-bbbb-3fd36615620c@linux.intel.com>
References: <20190318144237.42447-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190318144237.42447-1-andriy.shevchenko@linux.intel.com>
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

On 3/18/19 4:42 PM, Andy Shevchenko wrote:
> There is nothing in the driver which requires OF specific header
> to be included.
> 
> Remove it for good.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx-pci.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/spi/spi-pxa2xx-pci.c b/drivers/spi/spi-pxa2xx-pci.c
> index 33029ca0687a..d456c5251b5d 100644
> --- a/drivers/spi/spi-pxa2xx-pci.c
> +++ b/drivers/spi/spi-pxa2xx-pci.c
> @@ -5,7 +5,6 @@
>    */
>   #include <linux/clk-provider.h>
>   #include <linux/module.h>
> -#include <linux/of_device.h>
>   #include <linux/pci.h>
>   #include <linux/platform_device.h>
>   #include <linux/spi/pxa2xx_spi.h>

Yes, looks like not needed since 0202775bc3a2 ("spi/pxa2xx-pci: switch 
to use pcim_* interfaces").

Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
