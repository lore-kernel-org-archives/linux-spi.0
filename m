From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Thu, 27 Aug 2015 14:59:14 +0300
Message-ID: <20150827115914.GF28428@lahna.fi.intel.com>
References: <CAKor6Teq=Aoa6WYkTEVpjBPsWziL-o5FzQHxJWOMeaTrMzXpMg@mail.gmail.com>
 <20150821074310.GM30005@lahna.fi.intel.com>
 <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 Daniel Mack <daniel@zonque.org>,
 Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, dan.carpenter@oracle.com
To: Christian Hartmann <cornogle@googlemail.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
List-Id: linux-spi.vger.kernel.org

On Thu, Aug 27, 2015 at 01:44:45PM +0200, Christian Hartmann wrote:
> Hey,
> 
> 2015-08-26 12:01 GMT+02:00 Mika Westerberg <mika.westerberg@linux.intel.com>:
> > The master should already have IRQ. This is about assigning IRQ for the
> > SPI childe device.
> ok, *saved*
> >
> > You probably want to do same to SPI core that was done for I2C:
> >
> > 845c877009cf014b9 ("i2c / ACPI: Assign IRQ for devices that have GpioInt automatically")
> I looked at this log and have added or better set spi->irq now in
> arizon-spi.c arizona_spi_probe()
> and its that what I have already via local patches added:
> (ACPI) using irq_gpio GPIO = 146
> The question for me is, this looks like an GPIO number, not like an IRQ number.
> Also it seems better to look again into pxa2xx.c or spi.c (not done
> yet) and get the irq there.

If you are calling acpi_dev_gpio_irq_get() for the SPI device it should
return you valid Linux IRQ number (or fail with an error). But it
requires that your device has GpioInt resource somewhere in _CRS.

> >
> > Then it will automatically assign first found GpioInt to the SPI device
> > in question.
> 
> I again saw also the following files, which are not used under this
> device or they need some attention
> 
> drivers/gpio/gpio-arizona.c
> and drivers/extcon/extcon-arizona.c
> 
> I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
> Is it save to ignore ?? Or should I use them as well ??

If the SPI device interrupt is connected to arizona GPIO pin, then you
probably need that.
