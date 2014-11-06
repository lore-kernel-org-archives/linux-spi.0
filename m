From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Thu, 6 Nov 2014 15:48:00 +0000
Message-ID: <20141106154800.GL8509@sirena.org.uk>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com>
 <20141105105452.GS3729@sirena.org.uk>
 <545A1308.4080106@vsis.cz>
 <20141105132442.GT3729@sirena.org.uk>
 <545A87D7.3010705@opensource.altera.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lrl7g2KojMNQ8tYq"
Cc: Vlastimil =?utf-8?B?xaBldGth?= <setka-3PjVBYxTQDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Thor Thayer <tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <545A87D7.3010705-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--lrl7g2KojMNQ8tYq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 05, 2014 at 02:25:59PM -0600, Thor Thayer wrote:

Please leave blank lines between paragraphs and quoted bits, it makes
things much easier to read than an unbroken wall of text covering many
screenfuls.

> On 11/05/2014 07:24 AM, Mark Brown wrote:

> >To repeat again: please talk about driver problems in terms of the
> >driver not in terms of a particular driver.  Glancing at the code here
> >it looks like spidev is buggy here, it's just blindly allowing userspace
> >to overwrite the maximum speed configured for the device which seems
> >like a bad idea, drivers should have no reason to expect that something
> >called max_speed is actually variable.  It looks like spidev is abusing
> >this as a default speed.

> spidev is calling the case condition SPI_IOC_WR_MAX_SPEED_HZ in
> spidev_ioctl() to overwrite the maximum speed. From the code and the name,
> it seems like overwriting the maximum speed was the intended use and not a
> side effect.

This means it was an API that was implemented thoughtlessly rather than
anything else; it should be fixed to cache and use the current speed
after one has been set.

> >>     chip->speed_hz = spi->max_speed_hz = new_spi_speed
> >So the driver is overriding its idea of the current speed without
> >actually updatng the hardware.  Why is the fix here not to just delete
> >the assignment here, it seems fairly obviously buggy?

> Yes, removing line 591 of the spi-dw.c (chip->speed_hz = spi->max_speed_hz;)
> will solve the problem and seems like a clean fix. In this case the
> chip->speed_hz will persist the last transfer speed setting.

> The chip->speed_hz parameter won't be updated as part of the spi-dw driver
> initialization. This may not matter since it will get updated on the first
> transfer in the (transfer->speed != speed) test shown above.

OK, great - can you submit that version please?

--lrl7g2KojMNQ8tYq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUW5grAAoJECTWi3JdVIfQ5gEIAIaYRovmWBqdxgK3XnhN5AzY
awOgkz3s2QpLv3icpF3++5ymGkyKNkemvEyxvTmJbkSRitd9YFIIESE7JJbIkFfA
l1vxiYkA6rTokoSIxhhCgQP5ZGdKg1wlDuTYnNdR3s2pbEAF6c28tdNIDWtjRmpl
ykzv7R0iuZQzmiLckgxchdVwCLnx1OlmDTfxMFqGK9cJacYbHamLoPT1h+80vHyf
8fcNZWytItgZTiF7Zh4f0+KA0tQCidqNK12jvkwKJNDQkvgOd4mde/NRC5JSibC/
LfGyF0g/qHRw9WczcQ6E8RSPzTg75e2SQVQFb/ra25jZOLAxbUzMtsjUoyFXEnk=
=n3ml
-----END PGP SIGNATURE-----

--lrl7g2KojMNQ8tYq--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
