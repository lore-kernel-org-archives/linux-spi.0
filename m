From: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Tue, 15 Apr 2008 09:07:23 +0200
Message-ID: <20080415070723.GA18303@www.tglx.de>
References: <20080414194549.GA1363@www.tglx.de>
	<200804141623.36838.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200804141623.36838.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

* David Brownell | 2008-04-14 16:23:36 [-0700]:

>On Monday 14 April 2008, Sebastian Siewior wrote:
>> Without this it is possible to unload the SPI-driver while an
>> spidev user open()ed the spidev device.
>
>Does that misbehave in any way?  That sort of unloading of
Yes. Unload, read() -> Ooops.

>adapter code is possible with USB and I2C and hasn't been
>perceived as much of a problem.  I'm not sure I see a strong
>reason for SPI to act very different.
True. usb returns with -ENODEV after read/whatever. We could add
something like this to spi/spidev. This might also fit better into
hot-plugging.

>Also, the issue wouldn't be unique to "spidev"; any SPI device
>will be removed along with its adapter.  Like USB and I2C...
>
>
>> +=A0=A0=A0=A0=A0=A0=A0master->owner =3D THIS_MODULE;
>> =A0=A0=A0=A0=A0=A0=A0=A0ret =3D spi_register_master(master);
>
>If this is really needed, what I most dislike is the way it
>causes changes in all the adapter drivers.  So rather than
>changing the API like that, how about switching its current
>implementation a bit ... more like
>
>static inline int spi_register_master(struct spi_master *master)
>{
>	return __spi_register_master(master, THIS_MODULE);
>}
>
>That's pretty much what i2c_add_driver() does.
This looks definitely better.

>- Dave
Sebatian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference =

Don't miss this year's exciting event. There's still time to save $100. =

Use priority code J8TL2D2. =

http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/java=
one
