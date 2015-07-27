From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: img-spfi: fix spfi_setup by removing
 gpio_request_one
Date: Mon, 27 Jul 2015 17:40:15 +0100
Message-ID: <20150727164015.GB11162@sirena.org.uk>
References: <1437999076-693-1-git-send-email-sifan.naeem@imgtec.com>
 <1437999076-693-2-git-send-email-sifan.naeem@imgtec.com>
 <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6f5g2FH9GM0hR1Og"
Cc: Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	"Stable kernel (v4.1)" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Andrew Bresticker <abrestic-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAL1qeaHLn6-2QJkPjNCm3V-pVqBk09P2BP-Sp+gn1G4ZWpvkEw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6f5g2FH9GM0hR1Og
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 27, 2015 at 09:34:41AM -0700, Andrew Bresticker wrote:
> On Mon, Jul 27, 2015 at 5:11 AM, Sifan Naeem <sifan.naeem-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org> wrote:

> > spfi_setup may be called many times bye the spi framework, but
> > gpio_request_one can only be called once without freeing, repeatedly
> > calling gpio_request_one will cause an error to be thrown, which causes
> > the request to spi_setup to be marked as failed.

> > We can simply use gpio_direction_output to set the direction of the
> > gpio instead of gpio_request_one to put the gpio in to initial state,
> > after which the spi framework can control the chipselect line via gpio
> > using gpio_set_value.

> I don't think we want to leave the CS GPIOs un-requested.  Instead, we
> could either request them all at probe() time (and then set direction
> in setup()) or have a per-spi_device flag that indicates whether or
> not the GPIO has been requested.

Not requesting the GPIOs at all would just be a straight up bug.

--6f5g2FH9GM0hR1Og
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVtl7vAAoJECTWi3JdVIfQ6CYH/1CqNx0E+o9wYmYyMX1i6uyV
2rNurXmVZA42r6vkMxE4MkyN3QK9EtHYG1C0UJ2j/XUc1UECa/7S7APK04kK5jxx
MkfdAp0q0kMiZNgvG2Oc62P6bX0sJR0ZHhHY27QMj3W8PTQioj3LH55+ECo+C8QA
7ZmGfl1gdrl3vn0WkeTw8vRfKDOwjrKgZSNhWQjcWoPakdxMBKHH/gfywBAh296t
hN91xx3tzgWczV8HusXzEvzmOBzYoWoBSFWNsjM1gC3MkarV0Nk7EdA72kXvj/EG
Uq0QoG5zduxOJJ2d5v2paFpjkPPJuYYcH5Mu2A/gfThZ3bsSzp7VnZupyRA5IuE=
=iTir
-----END PGP SIGNATURE-----

--6f5g2FH9GM0hR1Og--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
