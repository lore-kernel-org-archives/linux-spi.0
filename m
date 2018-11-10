From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 0/7] Raspberry Pi spi0 improvements
Date: Sat, 10 Nov 2018 10:13:22 +0100
Message-ID: <60EACAB3-5D50-4D99-A6A7-0B12F6F5C4A7@martin.sperl.org>
References: <cover.1541659680.git.lukas@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1541659680.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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

Patches: 1-5:
Reviewed-By: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>

> On 08.11.2018, at 08:06, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> 
> Here's a first batch of improvements for the spi0 master on the
> Raspberry Pi.  The meat of the series is in its last two patches:
> 
> * Patch [6/7] allows DMA for transfer buffers starting at an offset not a
>  multiple of 4.  This overcomes a limitation affecting Ethernet drivers
>  such as ks8851 which call netdev_alloc_skb_ip_align() to allocate
>  deliberately unaligned receive buffers.
> 
> * Patch [7/7] speeds up PIO transfers by not polling the RX FIFO when it
>  is known to contain data, or the TX FIFO when it is known to have free
>  space.
> 
> The preceding patches fix rarely encountered bugs, remove obsolete code
> and add documentation.
> 
> The series has been tested extensively on the "Revolution Pi" family of
> open source PLCs (https://revolution.kunbus.com/), but further testing
> would be welcome to raise the confidence.
> 
> Thanks,
> 
> Lukas
> 
> 
> Lukas Wunner (7):
>  spi: bcm2835: Avoid finishing transfer prematurely in IRQ mode
>  spi: bcm2835: Fix book-keeping of DMA termination
>  spi: bcm2835: Fix race on DMA termination
>  spi: bcm2835: Drop unused code for native Chip Select
>  spi: bcm2835: Document struct bcm2835_spi
>  spi: bcm2835: Overcome sglist entry length limitation
>  spi: bcm2835: Speed up FIFO access if fill level is known
> 
> drivers/spi/spi-bcm2835.c | 478 ++++++++++++++++++++++++++------------
> 1 file changed, 334 insertions(+), 144 deletions(-)
> 
> -- 
> 2.19.1
> 
