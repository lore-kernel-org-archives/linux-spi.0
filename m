From: =?ISO-8859-1?Q?Fl=E1vio_Alberto_Lopes_Soares?= <flavioalsoares-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Analog Digital Converter - ADS1256 extreme newbie questions
Date: Sun, 12 Sep 2010 11:39:29 -0300
Message-ID: <AANLkTikXq6Wm0kA_cHiAyZc+5kOJQBvP_2gOSbnihv5i@mail.gmail.com>
References: <AANLkTi=iQVwpd-PymaWSKapfntmf4aRrt51Jutsz=D_g@mail.gmail.com>
	<20100910171858.GA11284@angua.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100910171858.GA11284-MrY2KI0G/OVr83L8+7iqerDks+cytr/Z@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,
thank you for your help.

I misunderstood the "struct spi_device *spi" that functions in protocol
drivers receive as parameters, for example in the probe function, I thought
that spi_device struct represent the spi master controller but as I saw
in Documentation/DocBook/device-drivers/ch09.html it represents itself and
not the SPI controller.

But, comparing drivers/staging/iio/accel/kxsd9.c
and drivers/misc/eeprom/at25.c why kxsd9 driver doesn't uses the
platform_data struct ? There's some functional difference in these 2 drivers
in the way that they access the SPI subsystem ?
I'm thinking of use the kxsd9.c as a "master" to write my driver because the
apparent simplicity way of access the SPI subsystem, I like it.

Thanks for all help
Flavio Alberto Lopes Soares

2010/9/10 Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>

> On Fri, Sep 10, 2010 at 10:11:35AM -0300, Fl=E1vio Alberto Lopes Soares
> wrote:
> > Hello all,
> > I'm working 9 years as a Linux C/C++ programmer but I spent 99,9% of th=
is
> > time working in user space programming, now I need to write a driver to
> use
> > the ADS1256 Analog-Digital converter (
> > http://focus.ti.com/docs/prod/folders/print/ads1256.html ) in an ARM
> board
> > using S3C2440 processor, my lecture start point
> > was Documentation/spi/spi-sumary from 2.6.32.2 kernel tree version and
> > drivers/misc/eeprom/at25.c code (this is an eeprom driver but I want lo=
ok
> > the SPI general view), reading the text and the code I found some
> conceptual
> > doubts, my initial idea was create a character device driver and attach
> the
> > device read operation with a ADS1256 start lecture and pass the ADC
> channel
> > data to this device, this concept is correct ? There's some standard
> > interface to do this if my idea is wrong ?
> >
> > Looking in at25.c in at25_probe(struct spi_device *spi) function this
> > "struct spi_device *spi" parameter represents the S3C2440 SPI controller
> and
> > came from SPI core subsystem ? If yes how the SPI controller knows that
> this
> > is an eeprom device in the snippet bellow ?
> > ...
> > const struct spi_eeprom *chip;
> > ...
> > /* Chip description */
> > chip =3D spi->dev.platform_data;
> >
> > who provides this platform_data structure and who knows it must be a
> struct
> > spi_eeprom object ?
>
> Hi Fl=E1vio.
>
> The platform_data structure is provided by the code that registers the
> spi_device; usually this is some form of machine specific platform
> code in an arch/*/ subdirectory.  The driver knows that platform_data
> points to the drivers structure because the code that registered the
> device must be responsible to provide the right kind of platform_data
> pointer for the driver that will be bound to it.
>
> For an example, look at arch/arm/mach-omap2/board-3430sdp.c which has
> an spi_board_info structure which passes both the requested driver
> (.modalias =3D "ads7846") and the data structure required by the ads7846
> driver (.platform_data =3D "&tsc2046_config").
>
> The matching driver is drivers/input/touchscreen/ads7846.c
>
> You'll notice that board-3430sdp.c and ads7846.c both use the
> ads7846_platform_data structure.
>
> g.
>
---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
