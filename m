From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: Re: Fwd: [PATCH 1/1] SPI : spi-pxa2xx : fix spi init
 of WM510205 codec via ACPI (resend)
Date: Fri, 28 Aug 2015 10:07:35 +0100
Message-ID: <1440752855.25096.3.camel@rf-debian.wolfsonmicro.main>
References: <CAKor6TeJp4ti6_QVCEpz0x7c2NwvUiS5wq_=_WDjM3B7T4=1Yg@mail.gmail.com>
 <20150824085140.GA5647@ck-lbox>
 <CAKor6TcRWgn-Z+Va0JKCBqxVA9HBSLMR_vh-z8MSBZebn9kDVg@mail.gmail.com>
 <20150825062157.GB27431@sirena.org.uk>
 <CAKor6Tf_8J4DVrVRShw2ked-zJzmP6G1P1i=vTcbzWX-J1H6dQ@mail.gmail.com>
 <CAKor6TfpWuhTG6dfARdHmXEb+bLpm5Q6Z-A0g60VPD2fCWHbOg@mail.gmail.com>
 <20150826100155.GA1513@lahna.fi.intel.com>
 <CAKor6TeH32hd0QUCPowzrjp54iJjGKiJ8jVT994y2O29dfk=QA@mail.gmail.com>
 <20150827115914.GF28428@lahna.fi.intel.com>
 <20150827145614.GC5313@sirena.org.uk>
 <20150828090042.GI28428@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Christian Hartmann <cornogle@googlemail.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Haojian Zhuang <haojian.zhuang@gmail.com>, linux-spi@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, jarkko.nikula@linux.intel.com,
 dan.carpenter@oracle.com, Charles
 Keepax <ckeepax@opensource.wolfsonmicro.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150828090042.GI28428@lahna.fi.intel.com>
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

On Fri, 2015-08-28 at 12:00 +0300, Mika Westerberg wrote:
> On Thu, Aug 27, 2015 at 03:56:14PM +0100, Mark Brown wrote:
> > On Thu, Aug 27, 2015 at 02:59:14PM +0300, Mika Westerberg wrote:
> > > On Thu, Aug 27, 2015 at 01:44:45PM +0200, Christian Hartmann wrote:
> > 
> > > > drivers/gpio/gpio-arizona.c
> > > > and drivers/extcon/extcon-arizona.c
> > 
> > > > I have already CONFIG_GPIO_ARIZONA=y, but it does not be used at all.
> > > > Is it save to ignore ?? Or should I use them as well ??
> > 
> > > If the SPI device interrupt is connected to arizona GPIO pin, then you
> > > probably need that.
> > 
> > I can't see how that would work, the interrupt output isn't a GPIO.
> 
> I mean that if the SPI device (codec) interrupt pin is connected to a GPIO
> pin of arizona instead of GPIO pin of the SoC itself.

It makes no sense to connect the codec interrupt pin back to one of its
own GPIOs. If you did that the GPIO could only generate another
interrupt to itself and you'd have a circular interrupt storm that went
nowhere.

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
