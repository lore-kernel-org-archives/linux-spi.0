From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/6] spi: add flow controll support
Date: Wed, 2 Mar 2016 19:55:30 +0900
Message-ID: <20160302105530.GK18327@sirena.org.uk>
References: <56D448E1.6090006@de.bosch.com>
 <1456843400-20696-1-git-send-email-linux@rempel-privat.de>
 <20160302024656.GR18327@sirena.org.uk>
 <56D68CD7.8000203@de.bosch.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s/cK5nSd5NvswZqS"
Cc: Oleksij Rempel <linux-YEK0n+YFykbzxQdaRaTXBw@public.gmane.org>, geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org,
	dirk.behme-V5te9oGctAVWk0Htik3J/w@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
To: "fixed-term.Oleksij.Rempel" <fixed-term.Oleksij.Rempel-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <56D68CD7.8000203-V5te9oGctAVWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--s/cK5nSd5NvswZqS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 02, 2016 at 07:48:55AM +0100, fixed-term.Oleksij.Rempel wrote:
> On 02.03.2016 03:46, Mark Brown wrote:
> > On Tue, Mar 01, 2016 at 03:43:15PM +0100, Oleksij Rempel wrote:

> > In the case above this looks like a normal interrupt from a device, I'm
> > not clear what is different here or why this is in the core?

> At least our HW use tree different signals for flow control. One of it
> is Request Signal.

That's still an interrupt, just on a different line to the main
interrupt.

> >> Flow control: ACK End of Data
> >> Master CS   |______________________/2------|
> >> Slave  FC   |________________________/3----|
> >> DATA        |__________________/1----------|

> > Why would anything care about this case and why is it part of the SPI
> > protocol rather than something that the device driver would do?

> This case covers real bugs and in our case we need to detect if master
> or slave stalls under one second. If communication problem is detected,
> some of recovery scenarios is initiated. Like i said, this protocol is
> used for automotive industry.

That doesn't answer the second part of my question.  This doesn't seem
to be something that's anything to do with SPI, it's just your device
signalling things out of band.

> Please see two attached screen shots of Master and Slave initiated
> transfers.

Those tell me nothing.

> > Atomic operations are very hard to use safely, you need to really spell
> > out what you think this is doing from a synchronization point of view
> > and why it's safe.

> I'm trying to detect if we are on Master or Slave initiated transfer,
> which was detected by spi_fc_rq. Normally there should be no other
> interrupts on FC line and active_rq should not be changed until this
> transfer was processed. The "if (!spi_fc_equal_cs(spi))" check is in
> case my assumption is wrong or there is some HW issue. Do you have other
> suggestions?

Among other things it really needs to be crystal clear how this update
gets propagated to all CPUs in the system with no race conditions.

> >> +	if (spi->mode | SPI_FC_REQUEST &&
> >> +			!spi->cs_enabled && fc_enabled) {
> >> +		atomic_set(&spi->active_rq, 1);
> >> +		if (spi->request_cb)
> >> +			spi->request_cb(spi);

> > This logic is all too complicated for me to follow.  Why are we oring
> > things with spi->mode?

> I'm trying to checking here if fallowing case is actually expected by
> slave device. Other suggestions?

In what way are we checking what?  The code is incomprehensible.

Again, you're ignoring my specific question about the or.

> > We can't support things only for DT, we need a way for things to be used
> > on other systemms.

> I have nothing against it, but i even do not have other HW to test if my
> assumptions are correct. Would you accept untested code? :)

In general the way we do DT code is that the DT parses into some data
structure and then we work with that data structure.  This means that
everyone's code path is tested.

--s/cK5nSd5NvswZqS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW1sahAAoJECTWi3JdVIfQ2j4H/2uah1T/wIjfZXbGj0jX0MQa
grKvBVnhcnYSAsWXM8gy2Mb6qej3EIR0W82PRs3r89MlQqVhQfOozBKba0ej6jzT
Ol+cfWKY2xeO3LXl6O/z7rNQiI1CuNMoBSBjwhiTp+tzQgu64XxIU+2fvvnNx42R
X1UWz3TQ7qUQ9TV7Jy5gAhu08XpaAkF+mN7sYK82jCg9CnXgW93yh326ezVUJBX3
WFml63pCa/heVsALO8eOIHDKkV8YJgv4lB0Eahd/tzOHY/GFqmN4XobxAyA5s4GG
m9gNtbjf7Y8gclgENvvxZUlsBNEbYFh6xIhGXcA3TTLNSjzMk4KFnJtZYw/Z35g=
=W9JD
-----END PGP SIGNATURE-----

--s/cK5nSd5NvswZqS--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
