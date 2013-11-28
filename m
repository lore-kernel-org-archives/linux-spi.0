From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Fix long standing chip select issue for non-default
 CS-polarity setups
Date: Thu, 28 Nov 2013 12:31:01 +0000
Message-ID: <20131128123101.GA11292@sirena.org.uk>
References: <EE805C3B-7650-45CF-ACA7-5A83758B7F77@martin.sperl.org>
 <20131127184001.GG14725@sirena.org.uk>
 <36A84195-DC42-499A-8663-5AE0CCDD720F@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Cc: bootc-1Slo4GeK4H1eoWH0uzbU5w@public.gmane.org, swarren-3lzwWm7+WeqjrCrn2yxA+g@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <36A84195-DC42-499A-8663-5AE0CCDD720F-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 27, 2013 at 08:00:00PM +0100, Martin Sperl wrote:

> Still I believe "compiling" the flags once in the setup code and then=20
> just using them should avoid wasting some cpu cycles in this driver.

Yeah, that's fine - part of what I'm doing when I review patches is
reviewing the changelog against the code to help make sure that the
change is doing what it's supposed to (this is one way to spot
unintended side effects) so the problem was that the two didn't tie
together more than anything else.

> > That's just never going to be a sane thing to change on the fly though.
> > Changes to things that don't affect /CS are more interesting here.

> I believe we need to state the above fact explicitly that this has
> the potential for a race condition (maybe other flags as well) in case=20
> no bus-lock is held and thought should be given to that during the
> design.

For the API it's basically just saying that it should take effect at the
start of the next operation (ie, any in flight operations will be fine).
There may be some setups in which changing /CS makes sense, for example
with higher level coordination going on or a design requirement that the
bus isn't shared I guess.  But documentation updates are welcome!

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSlzeCAAoJELSic+t+oim91DkP/1EdvPtojPdEFs7jcE0XVPyl
Q1atZPkVbAcNOwwY0jAnorWCtWiwbKt4p6UDj/gz1rreWYgagc+HZxZn+TrDny8r
/Gi9pXXM4e6poB+hfTgDTgOrPK4+3Qqjv021p0k/xO2VAWQq1HXUuhwh6bZFXvCr
4nOTUog/5a52/i6DiXUR3P7PHjwjMIjWFeAdUeGm1BLWEiMbD0wbyzWb5HLpgN68
V3ELOmvx+bybCrKsIX76E0FVWa6/99fp6OQbgRf68t3iCs0j23R1amQ1gxj0jqo6
rDglxS2ghSc9UhmattdDsOHbwNUsKdM+QCuy1x7w/Aim4f0FRrAc6FpdSH6SXxtC
Co9f/diZVDhwbPgj6Oycno+A2LOqz0JvnC8czdF4X0QfV4fBg/S+Q8munUos0Sfn
Ft9NhbPB6R5q6JPC23h/9Lc3lBxl/pNAsXRmIgDavNVjo6/EbT9it05DzwGNxS0X
3fYTcGlsfxfaMDHK3e3QLWCNY68cy3pdQ0/Ike852mmwXJMdNaVyjYTThJ4sTT+L
8T8NCt0xDLeCtSIaIoF7PJI7tT4pPGTb2bYKlYUcLgzzH2oRW18LiqzVv8zZEKGq
byvFqc3EXKUdR+5c1gap0gXXBPzl3QhUqhtVzhoGXI8RDonncP9XnMPxtmoQXviq
ahBpF0uyUT+M/N0Qowtm
=R7sa
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
