From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: dw: Fix dynamic speed change
Date: Wed, 5 Nov 2014 13:24:42 +0000
Message-ID: <20141105132442.GT3729@sirena.org.uk>
References: <1415140617-2028-1-git-send-email-tthayer@opensource.altera.com>
 <20141105105452.GS3729@sirena.org.uk>
 <545A1308.4080106@vsis.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IpljlC28XhFjURzf"
Cc: tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, tthayer-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org,
	andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Vlastimil =?utf-8?B?xaBldGth?= <setka-3PjVBYxTQDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <545A1308.4080106-3PjVBYxTQDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--IpljlC28XhFjURzf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 05, 2014 at 01:07:36PM +0100, Vlastimil =C5=A0etka wrote:
> 5.11.2014 11:54, Mark Brown:
> >On Tue, Nov 04, 2014 at 04:36:56PM -0600, tthayer-yzvPICuk2ABMcg4IHK0kFoH6Mc4MB0Vx@public.gmane.org =
wrote:

> >>When speed_hz is not declared in a SPI transfer, the transfer speed is
> >>not updated for the next read/write on /dev/spidevX.Y. The element

> >Why is the behaviour of spidev relevant here, if there is a problem with
> >spidev why is it being addressed in a specific driver?

> You can do a transfer at SPI using SPI_IOC_MESSAGE ioctl. In this case you
> can declare speed_hz per transfer, and everything is OK in spi-dw.

You can declare a speed per transfer for *any* client, this is totally
generic behaviour.  What is the specific relevance of spidev here?

> If you do not declare speed_hz (default is 0) when using SPI_IOC_MESSAGE,=
 or
> when you do just read/write on /dev/spidevX.Y, the spi_transfer->speed_hz=
 is
> filled by spi->max_speed_hz (which is the value previously set by
> SPI_IOC_WR_MAX_SPEED_HZ). This triggers a problem in spi-dw.

Again, this is something that any client could do...

> The reason is buggy condition which encloses chip->clk_div recalculation:

>      if (transfer->speed_hz) {
>          speed =3D chip->speed_hz;
>          if (transfer->speed_hz !=3D speed) {

> because transfer->speed_hz is filled by spi->max_speed_hz, which is equal=
 to
> chip->speed_hz -- because SPI_IOC_WR_MAX_SPEED_HZ do this (in dw_spi_setu=
p):

To repeat again: please talk about driver problems in terms of the
driver not in terms of a particular driver.  Glancing at the code here
it looks like spidev is buggy here, it's just blindly allowing userspace
to overwrite the maximum speed configured for the device which seems
like a bad idea, drivers should have no reason to expect that something
called max_speed is actually variable.  It looks like spidev is abusing
this as a default speed.

>     chip->speed_hz =3D spi->max_speed_hz =3D new_spi_speed

So the driver is overriding its idea of the current speed without
actually updatng the hardware.  Why is the fix here not to just delete
the assignment here, it seems fairly obviously buggy?

--IpljlC28XhFjURzf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWiUaAAoJECTWi3JdVIfQ/Z0H/0vl/eaCsoe8oLWr0OSTDBoo
1pl1RYR24WmyHtBlYVEY6uBDnAHGAJzPDM0g+m/e1rlOusQ2SWnVmTiQuAqSRNf4
fQzjdfqNju1N3YxqJpsQJiV4aa5/MOZuLR9n4O2qPAXjDxf9iWnpP0bsc8+SYWt0
qmzpuKlxEeAsAla7FVB46FEqutC9/Fffa2whCRl2NOy9AmxspKS4379eexKZ9MVP
Uug7K/31ED/aA4Z+4OPrcD9V1XsUc/epPjPzhl8/Dh0GOZJEv7jGR+AbvpYTO4/e
yR1wLrBFw4QOtRhXdB65haGr14lKF0PFs1UEJlEM+e3t+I9fK6UUJPlnCGcpZ7Q=
=F6yA
-----END PGP SIGNATURE-----

--IpljlC28XhFjURzf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
