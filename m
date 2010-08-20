From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Suggested Patch for 'amba-pl022.c' to solve
 the problem of running 'spidev_test' on Phytec LPC3250 board.
Date: Fri, 20 Aug 2010 11:16:54 -0700
Message-ID: <AANLkTimsoUUJihk8j48KkJ1YPdAttLHPuJ19i0W0BkpD@mail.gmail.com>
References: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Quentin YANG <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <AANLkTinQFQMXXBh7bq5ce_iwOzGvYCZxud6QWb-S71yQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> pl022_probe(struct amba_device *adev, struct amba_id *id)
> {
> =A0 =A0 =A0 ...................................
>
> =A0 =A0/* Allocate master with space for data */
> =A0 =A0master =3D spi_alloc_master(dev, sizeof(struct pl022));
> =A0 =A0if (master =3D=3D NULL) {
> =A0 =A0 =A0 =A0dev_err(&adev->dev, "probe - cannot alloc SPI master\n");
> =A0 =A0 =A0 =A0status =3D -ENOMEM;
> =A0 =A0 =A0 =A0goto err_no_master;
>
> =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Quentin Added 2010-AUG-19 */
> =A0 =A0 =A0 =A0master->mode_bits=3DMODEBITS;
> =A0 =A0.........................
>
> }
>
> Now I can successfully set 'SPI mode' to mode 3.
>

It looks like some additional setup is needed in pl022_setup() to setup the=
se
modes in hardware. Setting the mode_bits mask alone only tricks the
application into thinking SPI mode 3 has been set, but nothing will change
in hardware on the next setup if the passed mode isn't handled there too.

Some of the transfer setup config - data width, clock rate, SPI mode,
etc - are actually setup on a per transfer basis and may vary based on how
spidev (and in this case the spidev_test app) configures it. For these spec=
ific
setup items, we probably shouldn't use the static chip_info version of the
transfer config - maybe we can use the config passed in 'struct spi_transfe=
r'
instead.

This would also reduce the size of the struct pl022_config_chip controller
data structure since some of those fields would now be handled in the
spi_transfer structure.

I guess this change is bigger than anticipated :(

> [root@GsnCommsModule debug]# ./spidev_test -OH
> spi mode: 3
> bits per word: 8
> max speed: 500000 Hz (500 KHz)
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00 00 00 00 00
> 00 00
>
>
> Hope this patch can be added to amba-pl022.c in the next Linux kernel
> release.
>
>
> Regards,
>
> *Quentin YANG***
>
> *Firmware Engineer***
>
> *Tel: +61-2-88787724***
>
> *CHK GridSense Pty Ltd*
>
> Unit 3, 20-36 Nancarrow Ave
>
> Meadowbank, NSW, 2114, Australia
>
> Web Site: =A0http://www.gridsense.com
> -------------------------------------------------------------------------=
-----
> This SF.net email is sponsored by
>
> Make an app they can't live without
> Enter the BlackBerry Developer Challenge
> http://p.sf.net/sfu/RIM-dev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by =


Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev =
