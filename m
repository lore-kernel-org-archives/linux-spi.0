From: Phil Elwell <phil-FnsA7b+Nu9XbIbC87yuRow@public.gmane.org>
Subject: Re: Side effect of SPI GPIO descriptor usage
Date: Mon, 2 Dec 2019 14:11:51 +0000
Message-ID: <1e0b7cd6-cf9e-2b68-f875-8015c8ffc326@raspberrypi.org>
References: <db6a1e17-49a3-e3ed-7713-56b7763713d6@raspberrypi.org>
 <20191202134344.GE1998@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20191202134344.GE1998-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
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

Hi Mark,

On 02/12/2019 13:43, Mark Brown wrote:
> On Mon, Dec 02, 2019 at 12:10:11PM +0000, Phil Elwell wrote:
> 
>> A relatively recent patch [1] to the spi-bcm2835 driver modified it to use
>> GPIO descriptors for chip select handling. A side effect of this change is
>> to set the SPI_MODE_CS_HIGH flag for devices connected to the controller,
>> which seems strange since it happens for devices that require the usual
>> active-low chip select.
> 
> I take it you mean SPI_CS_HIGH rather than SPI_MODE_CS_HIGH?

Sorry, yes - SPI_CS_HIGH.

> I
> can't see anything in that change which sets the flag, can you be
> more specific?

bcm2835_spi_probe in spi-bcm2835.c sets ctrl->use_gpio_descriptors to 
true, and of_spi_parse_dt in spi.c includes the following:

/*
  * For descriptors associated with the device, polarity inversion is
  * handled in the gpiolib, so all gpio chip selects are "active high"
  * in the logical sense, the gpiolib will invert the line if need be.
  */
if ((ctlr->use_gpio_descriptors) && ctlr->cs_gpiods &&
     ctlr->cs_gpiods[spi->chip_select])
	spi->mode |= SPI_CS_HIGH;

>  The change no longer acts on SPI_CS_HIGH when
> requesting the GPIO but I can't see anything which *sets* the
> flag.  It does not visbily modify mode at all, nor did the
> original code.
> 
>> This change came to light when a user reported that the SPI-Py library
>> (a client of the spidev driver) wasn't working on 5.4, which was traced to
>> it overwriting the SPI mode flags when it was only trying to set the
>> CPHA and CPOL flags. This had the affect of inverting the chip select
>> line, with the obvious consequences. That corruption of the flags is clearly
>> an error, but what if the application and library were genuinely trying to
>> specify that the attached device required an active-high chip select? Would
>> it now require that they _clear_ the CS_HIGH flag?
> 
> I can't follow what you're saying here at all, sorry.  Can you
> please be more specific?  You appear to be saying that the issue
> is that the application modified the mode in some way and this
> was acted on apparently not in the expected way.

That's correct. Although the trampling of the mode flags was erroneous,
actually the resulting flags were correct - SPI_CS_HIGH was not set,
yet the chip select line was clearly being driven in an active-high
fashion.

> In general it's a bad idea to modify mode at runtime, and it's a
> bad idea to mix multiple means of configuring the polarity of the
> chip select (eg, mixing DT configuration with other means).

Applications using spidev to implement user-space drivers need to be 
able to set SPI mode, CS polarity etc. at run time. I agree that there
are many ways to set the polarity of a chip select, and it may be that
too many are being used with GPIO CSs declared by DT, but I don't think 
that completely explains the connection between use_gpio_descriptors
and the automatic setting of SPI_CS_HIGH.

Phil
