From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] devicetree - document using aliases to set spi bus
 number.
Date: Tue, 24 May 2016 19:32:56 +0100
Message-ID: <20160524183256.GP8206@sirena.org.uk>
References: <1464107960-10775-1-git-send-email-christer@weinigel.se>
 <20160524172045.GN8206@sirena.org.uk>
 <57449784.4070108@weinigel.se>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pnwJnpr18esoRWH7"
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org
To: Christer Weinigel <christer@weinigel.se>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57449784.4070108@weinigel.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--pnwJnpr18esoRWH7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 24, 2016 at 08:03:48PM +0200, Christer Weinigel wrote:
> On 05/24/2016 07:20 PM, Mark Brown wrote:

> > I'm not sure this is something we want to support at all, I can't=20
> > immediately see anything that does this deliberately in the SPI
> > code and obviously the "bus number" is something of a Linux
> > specific concept which would need some explanation if we were going
> > to document it.  It's something I'm struggling a bit to see a
> > robust use case for that isn't better served by parsing sysfs,
> > what's the goal here?

> If this isn't something that should be in the Documentation/devicetree
>  because it's not generig enough, where should Linux-specific
> interpretations such as this be documented?

I'm not clear that we want to document this at all since I am not clear
that there is a sensible use case for doing it.  I did ask for one but
you've not articulated one in this reply.  I am much less gung ho than
Grant on this one, even as a Linux specific interface it seems very
legacy.

--pnwJnpr18esoRWH7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXRJ5XAAoJECTWi3JdVIfQViEH/jq75HJURavz51slvrEitUEm
9tn06t0Yq2w1ztUw6HcJ/ei45WWM+nic/GEO4VCz25ipeCMjilOAqLWCFCwruZjk
SKXbX/cxM5S8sKj7g/Y0VVOhMyoVQ5YJV0pR0vC9YVwu702Hb4pKJbS1bOHTSrvO
O/6UL613GAkkt170Rwb5D68bSbThuPF0kQvSQXiay5p6TBW7LKJJuET0oYMOohZ0
41+Rx/g/4Vnik6dWqHcpG0hv58B0X9MpaLJgnpLqOgJPzF1V2tQU/hFKaaFJS8IE
aQJe/FWJmLgpNSd0F2IlhNW6vCvZ1DZVLeAawR3gxjPeBB290WtpI2Em4AjspAs=
=sGiQ
-----END PGP SIGNATURE-----

--pnwJnpr18esoRWH7--
