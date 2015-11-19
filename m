From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: RfC: Handle SPI controller limitations like maximum message
 length
Date: Thu, 19 Nov 2015 17:15:38 +0000
Message-ID: <20151119171538.GO31303@sirena.org.uk>
References: <564CEB61.2000601@gmail.com>
 <20151118215755.GL31303@sirena.org.uk>
 <564D0098.4030107@gmail.com>
 <20151119114057.GN31303@sirena.org.uk>
 <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="0Wg1ddIY7KV0vpwL"
Cc: Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F224F5F3-FAD5-47FE-9419-39E53BCBB8C6-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--0Wg1ddIY7KV0vpwL
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2015 at 04:00:45PM +0100, Martin Sperl wrote:

Please fix your mail client to word wrap within paragraphs at something
substantially less than 80 columns.  Doing this makes your messages much
easier to read and reply to.

> On the bcm2835 there are also some =E2=80=9Climitations=E2=80=9D (when tr=
ansfers are not aligned
> to word, transfers>65535 can=E2=80=99t DMA) which we work around right no=
w inefficiently.

Alignment is a general issue which all clients should be trying to
ensure as a matter of course - never mind individual blocks of hardware,
some common CPU architectures suffer noticable penalties from unaligned
accesses so it's just generally good practice to try to avoid them.

You shouldn't be doing anything about transfer size limitations in your
driver, if you have this restriction you should be adding code to the
core and just flagging the limit in your driver.

> I am in the progress of writing a (minimal) spi-core extension, that woul=
d allow=20
> a spi_master to have a prepare_message function that would call some =E2=
=80=9Cmessage
> translation functions=E2=80=9D.

> The ones I have currently come up with are:
> int spi_split_transfer_alignment(struct spi_message *msg, int alignment);
> int spi_split_transfer_maxsize(struct spi_message *msg, size_t max_size);

Please don't do things this way, please make this more data driven -
have the drivers declare their capabilities so the core can just do
these things based on those flags rather than requiring active code in
drivers.  This keeps the code central which in turn helps keep things
maintainable.

> I guess this is a more transparent approach that does not require the
> individual device drivers to query the spi_master about limitations
> and replicate code in several drivers - also there is no maintenance cost=
 on
> individual device drivers to track when there is a new limitation introdu=
ced.

You've got this back to front - drivers are responsible for initialising
the master when they instantiate it.  There's nothing stopping them
using the data if they have variants to handle but they shouldn't be
speculatively looking at it on the off chance there's some limit.

--0Wg1ddIY7KV0vpwL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWTgO5AAoJECTWi3JdVIfQDxMH/3inzKLd6Hou90K3+YPRleu1
sOuEnw8HF/bGZoYeoyV+moUuj3N1FX8Suj06B/X77SpxHPkUDznjMMQha6J2Ao+/
BYZZPn7KPI+iSQY7WGHXDDXyYBBEIRfP/8ayRNDBaa29inWGFrbQRaq49EmdlxeC
tTIbW7fR5x+sMxustZwkQ3nzjWHPHBq0xIyxOugO1UrHrdo00CvwXOj7NcHudwB6
4w05PBESq5xd53iTauF7KNCAdlqChg52sj4MUSSu5TWg/5kzWdw5bkeD64QDbek1
epPMUbYnrRvq3KFS9206NOHH3h9YHkS+Y92gGW8MJJUQlXHoG69uVJAe0Q+vewk=
=tcju
-----END PGP SIGNATURE-----

--0Wg1ddIY7KV0vpwL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
