From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Thu, 5 Dec 2019 00:27:40 +0100
Message-ID: <CACRpkdaxXKMqL4Y8yFu+U7WhpXgq6Yr+hx4rYd3aDzc+-dLDFw@mail.gmail.com>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk>
 <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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

On Wed, Dec 4, 2019 at 3:46 PM Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:

> I looked it over and most are devices like board files and RTC
> clocks that enforce SPI_CS_HIGH. They seem to be native
> chip selects so it will work as expected but I will look it over so
> I haven't broken any of them.

I looked all over:

drivers/mfd/ezx-pcap.c
Enforces SPI_CS_HIGH if platform data PCAP_CS_AH is
set. Nothing (no board file) in the kernel sets it.
No action.

drivers/mfd/mc13xxx-spi.c
drivers/mfd/motorola-cpcap.c
Hardcodes both SPI_MODE_0 and SPI_CS_HIGH.
Should be patched to |= SPI_MODE_0 and
^= SPI_CS_HIGH. I sent patches.

drivers/rtc/rts-ds1302.c
drivers/rtc/rts-ds1305.c
drivers/rtc/rtc-pcf2123.c
These just have some text comments on the importance of using
an active high chip select. That then gets defined in the boardfile or
the device tree which is fine. Any GPIO lines used for this can be
flagged as active high or low appropriately.

drivers/rtc/rtc-ds1343.c:
Hardcodes SPI_CS_HIGH, has no in-tree users (bo board files
refer to it), does not support device tree. So there is no way
to break it. Sent a patch anyways.

drivers/rtc/rtc-rx6110.c
Prints a warning if not flagged SPI_CS_HIGH, wil print
that warning if used with a GPIO chip select from device
tree. No regression, also no in-tree users.

drivers/staging/fb_uc1611.c
drivers/staging/fb_watterott.c
A staging driver hardcoding SPI_CS_HIGH, sent a patch
for this too so we don't gain any bad examples.

Yours,
Linus Walleij
