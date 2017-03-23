From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Thu, 23 Mar 2017 13:02:57 +0100
Message-ID: <20170323120257.GC20546@h08.hostsharing.net>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <20170323110718.sncw32gspvls75u7@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170323110718.sncw32gspvls75u7-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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

On Thu, Mar 23, 2017 at 11:07:18AM +0000, Mark Brown wrote:
> On Thu, Mar 23, 2017 at 11:36:45AM +0100, Lukas Wunner wrote:
> > +Optional properties:
> > +- bcm2835,rt_prio: Realtime priority of the message pump to minimize latency
> > +                   on the bus (0..99).
> > +
> 
> This is going to depend on the software running on the board, I'd expect
> it to be something configured at runtime rather than fixed in DT.

On the Revolution Pi, the SPI master is hardwired to two KSZ8851 Ethernet
controllers which are connected to various fieldbus gateways in a
plug-and-play fashion.  Low latencies are needed to achieve a decent
cycle rate when reading/writing data to the fieldbus devices.

Hence for this use case, the RT priority is mandated by the hardware
platform, which is why I put it in the devicetree.  It is needed
regardless of which software is running.

We could accommodate to setting the RT priority on the command line but
we'd like to avoid always having to set it at runtime.  That is already
possible by invoking chrt(1) from user space after the SPI master driver
has loaded and wouldn't require a kernel patch.

Also, if you question setting the RT priority in the devicetree, why
was that functionality allowed for pl022 in the first place?

Thanks,

Lukas
