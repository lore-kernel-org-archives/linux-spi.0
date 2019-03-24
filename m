From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 3/3] spi: bcm2835: add module parameter to configure
 minimum length for dma
Date: Sun, 24 Mar 2019 09:58:27 +0100
Message-ID: <238F2E81-BC34-4652-89CE-C00E04C12378@martin.sperl.org>
References: <20190224162311.23899-1-kernel@martin.sperl.org>
 <20190224162311.23899-3-kernel@martin.sperl.org>
 <20190322123610.ndwxoivsprc643f5@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190322123610.ndwxoivsprc643f5-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-spi.vger.kernel.org


> On 22.03.2019, at 13:36, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> 
> On Sun, Feb 24, 2019 at 04:23:11PM +0000, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
>> +/* define dma min number of bytes to use in dma mode with value validation */
>> +static int dma_min_bytes_limit_set(const char *val,
>> +				   const struct kernel_param *kp)
>> +{
>> +	unsigned int v;
>> +
>> +	if (kstrtouint(val, 10, &v))
>> +		return -EINVAL;
>> +	/* value needs to be a multiple of 4 */
>> +	if (v % 4) {
>> +		pr_err("dma_min_bytes_limit needs to be a multiple of 4\n");
>> +		return -EINVAL;
>> +	}
> 
> Transfers don't need to be a multiple of 4 to be eligible for DMA,
> so this check can be dropped.

I definitely did not want to write a custom module argument parser
but if i remember correctly there is one limitation on the transmission path
where you would hit some inefficiencies in the DMA code when you run
transfers that are not a multiple of 4 - especially for short transfers.

That is why it was implemented.

But I can leave this precaution out.

Martin
