From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/2] spi: pxa2xx: Debug print DMA burst and threshold
Date: Mon, 4 Mar 2019 14:28:23 +0200
Message-ID: <fa772fa9-dd01-a7b0-2846-3349de005166@linux.intel.com>
References: <20190226114921.48205-1-andriy.shevchenko@linux.intel.com>
 <20190226114921.48205-2-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 linux-arm-kernel@lists.infradead.org, Mark Brown <broonie@kernel.org>,
 linux-spi@vger.kernel.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190226114921.48205-2-andriy.shevchenko@linux.intel.com>
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
> It's useful during debug to see what DMA burst and threshold sizes are.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/spi/spi-pxa2xx.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
> index 7a86654045fc..7cc4e85290b0 100644
> --- a/drivers/spi/spi-pxa2xx.c
> +++ b/drivers/spi/spi-pxa2xx.c
> @@ -1338,6 +1338,9 @@ static int setup(struct spi_device *spi)
>   			dev_warn(&spi->dev,
>   				 "in setup: DMA burst size reduced to match bits_per_word\n");
>   		}
> +		dev_dbg(&spi->dev,
> +			"in setup: DMA burst and threshold set to %u, %u\n",
> +			chip->dma_burst_size, chip->dma_threshold);

Printing chip->dma_threshold is not very informal here just after the 
pxa2xx_spi_set_dma_burst_and_threshold() call which sets it to
(8 - 1 ) << 10 | (8 - 1) << 6 = 7616.

-- 
Jarkko
