From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Wed, 4 Dec 2019 15:46:56 +0100
Message-ID: <CACRpkdbqNw+h6MphF7kLAwym-F3G+ZebMDB2BMt0bzA6DfM0OA@mail.gmail.com>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
 <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
 <20191203163521.GM1998@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
 linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20191203163521.GM1998-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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

On Tue, Dec 3, 2019 at 5:35 PM Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Dec 02, 2019 at 02:11:51PM +0000, Phil Elwell wrote:

> > Applications using spidev to implement user-space drivers need to be able to
> > set SPI mode, CS polarity etc. at run time. I agree that there
>
> I'm nervous of spidev user doing stuff like that with the chip
> selects, with DT even spidev devices should be registered
> normally, you will get a complaint if you register a raw spidev.
> There's no free pass for "oh, spidev can do anything we don't
> care" here - the DT should describe the hardware, if some of the
> hardware happens to be implemented by spidev then fine.

I agree with this. In 99 cases out of 100 it turns out that the
userspace driver is a substandard version of a driver that should
actually be in a place such as drivers/iio and what we end up
supporting is offended userspace driver authors who are acting
against the interests of the kernel community.

I have come to accept the usecase of userspace GPIO for things
like industrial automation one-offs, random hackerspace projects,
and prototypes all highly custom, and with such high friction with
kernel internals and pain to carry forward should be expected.

With devices on SPI and I2C I get really sceptic. What are those
hardware devices, and what makes them so fantastic that they
cannot use a kernel driver like everyone else?

> That said we do have other in kernel users that do change modes
> at runtime, though I'm not convinced many of them have GPIO chip
> selects.  Linus?

I looked it over and most are devices like board files and RTC
clocks that enforce SPI_CS_HIGH. They seem to be native
chip selects so it will work as expected but I will look it over so
I haven't broken any of them.

and I can find one more outlier:

drivers/mmc/host/mmc_spi.c, function mmc_spi_initsequence()

This very clearly want the inverse polarity of whatever was the default,
but the code assumes that SPI_CS_HIGH implies that this is the
actual physical level and forces it high, then low. I will send
a patch for this: what they want to achieve is the inverse of
whatever was configured.

The driver drivers/net/wireless/ti/wlcore/spi.c does exactly
this already.

I am a bit sorry about the semantics of "HIGH" here when the right
word should rather be "asserted": it's named like this for historical
reasons.

An alternative would be to let SPI use gpiod_set_raw_value()
to steamroll all the inversion semantics in the GPIO library,
and SPI_CS_HIGH would literally mean to drive the physical
line high.

This may seem like an intuitively correct solution but
it has implications for everything using device tree to define
SPI clients: spi-cs-high in a device tree means that the
CS is active high, which gpiolib currently detects and
handles by way of disabling internal inversion (the default
for SPI devices is active low). Previously the SPI core would
set SPI_CS_HIGH and we would then just double-assign
that in the SPI core and then again in some drivers, it doesn't
seem much better to me.

So I will look these over, but if people (and especially the SPI
maintainer) prefer the semantic that SPI_CS_HIGH does not
mean "asserted" but takes direct control of the physical
level of the CS line, I can do that instead.

I could also additionally patch the whole kernel to rename
SPI_CS_HIGH into SPI_CS_ASSERTED if this makes things
better. (Would be a two-step patch rocket adding the additional
define and switching everyone over before deleting the
SPI_CS_HIGH.)

Yours,
Linus Walleij
