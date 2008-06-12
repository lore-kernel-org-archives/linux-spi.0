From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: [PATCH] gpio: gpio driver for max7301 SPI
	GPIO expander
Date: Thu, 12 Jun 2008 00:15:50 -0700
Message-ID: <200806120015.50953.david-b@pacbell.net>
References: <Pine.LNX.4.64.0806061625260.3338@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Guennadi Liakhovetski <g.liakhovetski-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.64.0806061625260.3338-0199iw4Nj15frtckUFj5Ag@public.gmane.org>
Content-Disposition: inline
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

Some comments about one routine; presumably more to follow:


On Friday 06 June 2008, Guennadi Liakhovetski wrote:
> +/**
> + * max7301_read - Read back register content
> + * @spi: The SPI device
> + * @reg: Register offset
> + *
> + * A read from the MAX7301 means one message with two transfers

That's not what you implement though ... what it needs is:

	- transfer #1:
		* select
		* write 16 bit command, discard rx data
		* deselect
	- transfer #2
		* select
		* write 16 bit command, saving rx data
		* deselect

That's from the data sheet.  Now, that *could* be implemented
with a single message ... or, as you do, with two messages.

You should at least correct the comment, if you don't want to
switch to a slightly faster single-message implementation.  :)


> + *
> + * Returns positive 8 bit value from device if successfull or a
> + * negative value on error

Actually it returns a 16 bit value... also, "successful" has one "l".
You seem to have forgotten to mask off the high byte ...


> + */
> +static int max7301_read(struct spi_device *spi, unsigned int reg)
> +{
> +=A0=A0=A0=A0=A0=A0=A0int ret;
> +=A0=A0=A0=A0=A0=A0=A0u16 word;
> +
> +=A0=A0=A0=A0=A0=A0=A0word =3D 0x8000 | (reg << 8);
> +=A0=A0=A0=A0=A0=A0=A0if ((ret =3D spi_write(spi, (const u8*)&word, siz

> eof(word))) !=3D 0) =

> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> +=A0=A0=A0=A0=A0=A0=A0/*
> +=A0=A0=A0=A0=A0=A0=A0 * FIXME: This read should write 0x0000 (=3DNOOP at=
 MAX7301 side)

Take out this FIXME, and just replace it with a note that this relies
on the fact that TX always shifts out zeroes if there's no data specified.

> +=A0=A0=A0=A0=A0=A0=A0 */
> +=A0=A0=A0=A0=A0=A0=A0if ((ret =3D spi_read(spi, (u8*)&word, sizeof(word)=
)))
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return ret;
> +=A0=A0=A0=A0=A0=A0=A0return word;
> +}
> +


Oh, and in the probe():

> +=A0=A0=A0=A0=A0=A0=A0spi->master->setup(spi);

should be

	ret =3D spi_setup(spi);
	if (ret < 0)
		return ret;

It's quite possible that something get misconfigured, so you end up trying
to talk through a spi_master controller that doesn't support 16-bit words.

- Dave


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
