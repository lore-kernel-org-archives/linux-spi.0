From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Fri, 1 Jul 2016 17:00:15 +0200
Message-ID: <20160701150015.GQ6247@sirena.org.uk>
References: <20160628155107.GP17217@sirena.org.uk>
 <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk>
 <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk>
 <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
 <20160629180211.GF6247@sirena.org.uk>
 <CAOMqctR-f+dNBiWk8LEqkeYMhpvACjMi8aH3GpHY==RjfANf8Q@mail.gmail.com>
 <20160701082548.GE6247@sirena.org.uk>
 <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lYtTbTuCUQxZgETo"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-spi <linux-spi@vger.kernel.org>
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctRp+ua1DM82W35Df17TvhoF2suxALBaYqECWtTRrTWXCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--lYtTbTuCUQxZgETo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 01, 2016 at 10:58:34AM +0200, Michal Suchanek wrote:
> On 1 July 2016 at 10:25, Mark Brown <broonie@kernel.org> wrote:

> > It's been repeatedly suggested to you that the tooling for this stuff
> > could use some work.  Please go and put some effort into that rather
> > than continuing this thread which is accomplishing nothing.

> You completely miss the point. No tooling will make people reconfigure
> the kernel when the configuration in fact stays the same.

> Sure the tooling does need work. And it would help getting the cases
> when the tooling is NOT needed out of the way.

I understand the problem perfectly, no amount of repeating yourself is
going to change the problems that the bodge you are trying to force in
creates for other users and the maintainability of the system.

--lYtTbTuCUQxZgETo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdoV8AAoJECTWi3JdVIfQo64H/0BaU4+0VjG/2c08BTwcX6BP
wCIAyv55GVe3dmmP/NsYO0TquKZYeK3yzhkWI5QVPItopDRQ745QK9e2cgWgbSb+
O56omy/dKl0WsQwpa1r09QiZMGq+gHuFpKpAu10FYE6Dw3o+zeJSUh33LoHYOTOX
m6BmTkyXfkQ3FLB+Rr8WDWVmCB2shPmjAm00VwxTB+PUVd26ggq9h/mISb8bHRom
XRGcmkM+rsctZheoItnzjc9wPlk+ULuRsS1JZjoShKJcLPl4r9lDo3zeJ3vJwQ8I
zkh65hm7jL7lHPrF2cdFKq34aQ9LM7q0zlhbas/mxSyQGn0+uU4HQZv6yiV1Zvk=
=Dew9
-----END PGP SIGNATURE-----

--lYtTbTuCUQxZgETo--
