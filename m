From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: SPI_MASTER_MUST_* with scatter-gather only option
 and avoiding realloc
Date: Fri, 22 May 2015 12:34:21 +0100
Message-ID: <20150522113421.GE21391@sirena.org.uk>
References: <20150512165053.GE3066@sirena.org.uk>
 <1431597524-7907-1-git-send-email-kernel@martin.sperl.org>
 <20150519124632.GN2761@sirena.org.uk>
 <CA52E701-A9BF-45F1-AE2A-CD3E680CEAFC@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cPi+lWm09sJ+d57q"
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CA52E701-A9BF-45F1-AE2A-CD3E680CEAFC-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--cPi+lWm09sJ+d57q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2015 at 04:17:33PM +0200, Martin Sperl wrote:
> > On 19.05.2015, at 14:46, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

Quite a few process issues here which are rather annoying so I'm just
going to ignore the technical content for now.

> > Like I say I'm not entirely convinced we need the extra flags over just
> > using can_dma().

> If you can tell me that:
> 	(master->flags & (SPI_MASTER_MUST_TX | SPI_MASTER_MUST_RX)) &&
> 	master->can_dma && master->can_dma(...)=20
> means that we do NOT need real memory allocated in the first place but
> we only expect a scatter list to be created=20
> and memory allocated in all other cases then that be it.

I replied to your last mail on this in the other thread.

> >> It also fixes the insufficient cleanup in case __spi_map_msg returns
> >> an error.

> > This should be a separate patch.

> The problem is that this came up while developing the patch, so
> I left it in the patch, assuming there would be some feedback
> that requires another version of the patch...

There is no barrier to creating a separate patch for unrelated
improvments you happen to notice while working on an issue, it is
something that is well supported by the tooling.  Not doing this
guarantees that a resubmission will be required, means that reviewers
have to review the same code multiple times (which takes their time) and
means that it takes longer for other people to get the benefit of the
change.

> > This is updating a specific driver to use the new API you're adding,
> > this should be in a separate patch.

> At one occasion I got scolded for separating things out into different
> patches (in that case api from implemetation), now the other way around,
> but we can do that...

One patch per change as covered in SubmittingPatches.  Prototypes for a
function with no implementation are not a separate change since they
can't be used without the implementation also being added.  Changing a
driver is a separate change to adding an API since people can use the
API change even if they don't use that driver.

Not doing this causes extra work for people, it makes review harder,
causes resubmissions, and if the randomly mixed changes do end up
getting applied somehow then it makes things like bisection and
backporting harder.

--cPi+lWm09sJ+d57q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXxQ8AAoJECTWi3JdVIfQmMYH/iTihKKzbNn7+OH1RYyND1am
XG/aJsGS5fqp769WImWjzzOsjeZinvqZt5lH2TSi8dU1ZWdVSFPpn4B2foy+M1Pa
8ZDME5+tUNR0bAI00mEp1t3W2i/uoMZRH5EE7XNcxiZ93pXlyTwiwUKypCu+mPJ7
5AzBN9AZ5cG6Ty7UDqIYK4zYQ/s/0sYhYoqplOAMjI90fRZM4XGjzwZboDtYT8Wf
y9JJOm5Gj7hK86GAfUHKCEa3tvJVv7hmCf5Cwzz50dg+j1TX1dik15S7NQ9zRdxB
AQuGOEA1/5A/96WBPj0QVwUZsnxfCs4U0ulS7gq9lmFCixSxDuCQVrY/YKolAOM=
=CrDQ
-----END PGP SIGNATURE-----

--cPi+lWm09sJ+d57q--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
