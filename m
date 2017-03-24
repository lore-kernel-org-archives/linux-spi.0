From: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: bcm2835: Allow platform to set realtime priority
Date: Fri, 24 Mar 2017 17:10:12 +0100
Message-ID: <20170324161012.GA5886@h08.hostsharing.net>
References: <c1ca8a5522272d06f5c3fb67d8442f148b2d6cfb.1490264661.git.lukas@wunner.de>
 <1503363fcfb92adfa765d1c1c3e69fc673e72dde.1490264661.git.lukas@wunner.de>
 <a5439023-c268-996a-dfa2-1325c201cb25@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <a5439023-c268-996a-dfa2-1325c201cb25-eS4NqCHxEME@public.gmane.org>
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

On Thu, Mar 23, 2017 at 05:33:07PM +0100, Stefan Wahren wrote:
> Am 23.03.2017 um 11:36 schrieb Lukas Wunner:
> > Revolution Pi (a set of IoT products based on the Raspberry Pi and
> > geared towards industrial usage) uses the bcm2835's SPI master to
> > interface with an IEC 61158 fieldbus, which requires its kworker thread
> > to run at a realtime priority.  To this end, allow the platform to
> > specify the desired priority.
> 
> just out of curiosity are there any plans to upstream the Revolution Pi
> dts file?

Generally we do try to upstream as much as possible, but in the case of
the devicetree we're not sure what the benefits would be for the community
and for us, so we don't have an opinion on this yet.

We use a few of the Foundation's overlays with parameters tailored to the
Revolution Pi, plus a custom overlay.  All of that is public:

https://github.com/RevolutionPi/imagebakery/blob/master/templates/config.txt#L62
https://github.com/RevolutionPi/kernelbakery/blob/master/debian/kunbus.dts

Thanks for your interest,

Lukas
