From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v5 1/2] spi: pxa2xx: Introduce DMA burst size support
Date: Wed, 20 Mar 2019 09:19:01 +0200
Message-ID: <0166e3e0-bfe3-610b-9d93-b77e1f9b3e90@linux.intel.com>
References: <20190319154843.74684-1-andriy.shevchenko@linux.intel.com>
 <20190319154843.74684-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190319154843.74684-2-andriy.shevchenko@linux.intel.com>
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

On 3/19/19 5:48 PM, Andy Shevchenko wrote:
> Some masters may have different DMA burst size than hard coded default.
> In such case respect the value given by DMA burst size provided via
> platform data.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx-dma.c   | 4 +++-
>   drivers/spi/spi-pxa2xx-pci.c   | 4 ++++
>   drivers/spi/spi-pxa2xx.c       | 1 +
>   include/linux/spi/pxa2xx_spi.h | 1 +
>   4 files changed, 9 insertions(+), 1 deletion(-)
> 
Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Reviewed-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
