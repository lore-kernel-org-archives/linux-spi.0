From: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Subject: Re: [PATCH 4/7] spi: bcm2835: Drop unused code for native Chip Select
Date: Sat, 10 Nov 2018 10:07:38 +0100
Message-ID: <933F8F8F-2646-4FAC-9F68-6E106F6696F5@martin.sperl.org>
References: <cover.1541659680.git.lukas@wunner.de>
 <a24869503ed4e867b11c66c8615a4d5cddb3b2b5.1541659680.git.lukas@wunner.de>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Noralf Tronnes <noralf-L59+Z2yzLopAfugRpC6u6w@public.gmane.org>, Mathias Duckeck <m.duckeck-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>,
 linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <a24869503ed4e867b11c66c8615a4d5cddb3b2b5.1541659680.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
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


> On 08.11.2018, at 08:06, Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org> wrote:
> 
> Commit a30a555d7435 ("spi: bcm2835: transform native-cs to gpio-cs on
> first spi_setup") disabled the use of hardware-controlled native Chip
> Select in favour of software-controlled GPIO Chip Select but left code
> to support the former untouched.  Remove it to simplify the driver and
> ease the addition of new features and further optimizations.

I believe downstream is still using native CS instead of GPIO by default.
(Not sure if this really still applies), so they would still be using
this code-fragment.

IIRC the code was als kept for DT-backwards compatibility when the GPIO
function is set to ALT0 - but I may be wrong there...

Martin
