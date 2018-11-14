From: Florian Fainelli <f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/7] Raspberry Pi spi0 improvements
Date: Tue, 13 Nov 2018 21:12:01 -0800
Message-ID: <7ba12f83-a78f-4827-b962-4b08cad341fa@gmail.com>
References: <cover.1541659680.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <cover.1541659680.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
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



On 11/7/2018 11:06 PM, Lukas Wunner wrote:
> Here's a first batch of improvements for the spi0 master on the
> Raspberry Pi.  The meat of the series is in its last two patches:
> 
> * Patch [6/7] allows DMA for transfer buffers starting at an offset not a
>   multiple of 4.  This overcomes a limitation affecting Ethernet drivers
>   such as ks8851 which call netdev_alloc_skb_ip_align() to allocate
>   deliberately unaligned receive buffers.
> 
> * Patch [7/7] speeds up PIO transfers by not polling the RX FIFO when it
>   is known to contain data, or the TX FIFO when it is known to have free
>   space.
> 
> The preceding patches fix rarely encountered bugs, remove obsolete code
> and add documentation.
> 
> The series has been tested extensively on the "Revolution Pi" family of
> open source PLCs (https://revolution.kunbus.com/), but further testing
> would be welcome to raise the confidence.

Do you have some performance numbers that you could share before/after,
e.g: transfer latencies, number of interrupts and pure throughput?
Thanks for doing this work!
-- 
Florian
