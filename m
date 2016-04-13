From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: spi-ti-qspi: Handle truncated frames properly
Date: Wed, 13 Apr 2016 07:55:08 +0100
Message-ID: <20160413065508.GL14664@sirena.org.uk>
References: <1459885528.26669.5.camel@codethink.co.uk>
 <1459885728.26669.7.camel@codethink.co.uk>
 <20160412015809.GS3351@sirena.org.uk>
 <1460459364.32355.6.camel@codethink.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Mit9XoPEfICDqq/V"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	CT kernel <linux-kernel-81qHHgoATdFT9dQujB1mzip2UmYkHbXO@public.gmane.org>
To: Ben Hutchings <ben.hutchings-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1460459364.32355.6.camel-4yDnlxn2s6sWdaTGBSpHTA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--Mit9XoPEfICDqq/V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 12, 2016 at 12:09:24PM +0100, Ben Hutchings wrote:
> On Tue, 2016-04-12 at 02:58 +0100, Mark Brown wrote:
> > On Tue, Apr 05, 2016 at 08:48:48PM +0100, Ben Hutchings wrote:

> > > We clamp frame_length to a maximum of 4096, but do not limit the
> > > number of words written or read properly.  This causes 4K reads (which
> > > some m25p80-like flash chips support) to return garbage for the last
> > > few bytes.

> > > Recalculate the length of each transfer, taking the frame length into
> > > account.  Use this length in qspi_{read,write}_msg(), and to increment
> > > spi_message::actual_length.

> > I'm having a hard time understanding what's actually wrong here or how
> > this change is intended to fix it,

> "4K reads...return garbage"  That's wrong, no?

It doesn't say what the driver is doing wrong which causes the garbage.

--Mit9XoPEfICDqq/V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXDe1LAAoJECTWi3JdVIfQgD4H/AiCvDexn21flfE3UZC2mZgn
M44YvTscD8cwQQIGnSEu7yidH35noGebep/jyRMonHEuFg8m8TmtHoZp6BP83yUc
k1/aoABtFgeTiFZ1C7dbUEOlUy6Sje2X425BSlCqHIKYO9Kd/dEHdk0ym43eWKru
6RfQhm7XaXz0mbKkJcpiMnsmDPYDm0iybAlmu6pjjQTia0qGsh1O/LuWQWHqIyrB
foJ+ymp+BGTjX4IZtzPlBJ4xcAXNnOAEnMSeJ03UKWAA3NXuPhVAyysPSXnHNEE2
K1Ts4bmxCCiR6dL3O5tNbvb20lm0VVgsFRSi2VEuKSq6OeiBsQtPey+LiF1ZMmk=
=Quei
-----END PGP SIGNATURE-----

--Mit9XoPEfICDqq/V--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
