From: Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] SPI: DUAL and QUAD support
Date: Mon, 29 Jul 2013 17:35:11 +0200
Message-ID: <20130729173511.65caa07d@parrot.com>
References: <20130729064234.GS9858@sirena.org.uk>
	<1375095194-7093-1-git-send-email-wangyuhang2014@gmail.com>
	<20130729145626.6c227aa0@parrot.com>
	<CAHSAbzOPfpbPHohG7-EzftiPr5T2m19qgrKg7KS2jSKD-B=goA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Cc: "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
	"pekon-l0cyMroinI0@public.gmane.org" <pekon-l0cyMroinI0@public.gmane.org>, "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"sourav.poddar-l0cyMroinI0@public.gmane.org" <sourav.poddar-l0cyMroinI0@public.gmane.org>,
	"tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <tpiepho-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAHSAbzOPfpbPHohG7-EzftiPr5T2m19qgrKg7KS2jSKD-B=goA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Le Mon, 29 Jul 2013 15:25:51 +0100,
yuhang wang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> a =E9crit :

> Hi,
> =

> 2013/7/29 Matthieu CASTET <matthieu.castet-ITF29qwbsa/QT0dZR+AlfA@public.gmane.org>:
> > Le Mon, 29 Jul 2013 11:53:14 +0100,
> > wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> a =E9crit :
> >
> >> Hi,
> >>
> >> modify two things.
> >> 1:
> >> >> @@ -1316,6 +1324,12 @@ int spi_setup(struct spi_device *spi)
> >> >>         /* help drivers fail *cleanly* when they need options
> >> >>          * that aren't supported with their current master
> >> >>          */
> >> >> +       if (((spi->mode >> 8) & 0x03) =3D=3D 0x03 ||
> >> >> +               ((spi->mode >> 10) & 0x03) =3D=3D 0x03) {
> >> >> +               dev_err(&spi->dev,
> >> >> +               "setup: can not select dual and quad at the same
> >> >> time\n")
> >> >> +               return -EINVAL;
> >> >> +       }
> >> >> +               return -EINVAL;
> >> >> +       }
> >>
> >> >This code won't work if the constants you added for mode flags
> >> >change value.  More importantly, anyone searching the code for
> >> >SPI_TX_DUAL, etc. won't find this code.
> >>
> >> so use the certain macro to replace.
> >>
> >> 2:
> >> >You need to make sure that existing userspace binaries can run
> >> >unmodified, changing the types will change the layout of the ioctl
> >> >arguments.  This may mean that you need to add new ioctls if you
> >> >need to change types.
> >>
> >> I recovered the SPI_IOC_RD_LSB_FIRST ioctl.
> >> Add new ioctl to fit u16 mode.
> >> In addition,may SPI_IOC_RD_LSB_FIRST should be del in a better way.
> >>
> >> Signed-off-by: wangyuhang <wangyuhang2014-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> >> ---
> >
> >>  /* IOCTL commands */
> >> @@ -54,6 +61,8 @@
> >>   * @tx_buf: Holds pointer to userspace buffer with transmit data,
> >> or null.
> >>   *     If no data is provided, zeroes are shifted out.
> >>   * @rx_buf: Holds pointer to userspace buffer for receive data, or
> >> null.
> >> + * @tx_nbits: number of bits used for writting.
> >> + * @rx_nbits: number of bits used for reading.
> >>   * @len: Length of tx and rx buffers, in bytes.
> >>   * @speed_hz: Temporary override of the device's bitrate.
> >>   * @bits_per_word: Temporary override of the device's wordsize.
> >> @@ -85,6 +94,8 @@
> >>  struct spi_ioc_transfer {
> >>         __u64           tx_buf;
> >>         __u64           rx_buf;
> >> +       __u8            tx_nbits;
> >> +       __u8            rx_nbits;
> >>
> >>         __u32           len;
> >>         __u32           speed_hz;
> > You still break old userspace ABI.
> >
> > You need to create a new structure, if you need to add fields.
> >
> I dont think adding the members will cause the program in userspace
> any errors. User do not have to set these members.
Did you try to run on your patch kernel a program build without the
patch ?


if I build my program with :

> >>  struct spi_ioc_transfer {
> >>         __u64           tx_buf;
> >>         __u64           rx_buf;
> >>
> >>         __u32           len;
> >>         __u32           speed_hz;

Now I run it on a new kernel.
The kernel won't parse correctly my structure : len will go in
tx_nbits, rx_nbits and len.

Keep in mind that it is binary interface, not source interface. You
should not have to rebuild your binary.

Matthieu

---------------------------------------------------------------------------=
---
See everything from the browser to the database with AppDynamics
Get end-to-end visibility with application monitoring from AppDynamics
Isolate bottlenecks and diagnose root cause in seconds.
Start your free trial of AppDynamics Pro today!
http://pubads.g.doubleclick.net/gampad/clk?id=3D48808831&iu=3D/4140/ostg.cl=
ktrk
