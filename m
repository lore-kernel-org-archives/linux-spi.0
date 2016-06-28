From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Tue, 28 Jun 2016 19:38:25 +0100
Message-ID: <20160628183825.GS17217@sirena.org.uk>
References: <cover.1467053363.git.hramrach@gmail.com>
 <15ff382f699387e2d8f23779db851d0de7e9291e.1467053363.git.hramrach@gmail.com>
 <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com>
 <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk>
 <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tgGnixv3tJWXBxdL"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--tgGnixv3tJWXBxdL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 28, 2016 at 06:24:58PM +0200, Michal Suchanek wrote:

> No, no, no!

> This is NOT about loading an overlay. This is about talking on the bus
> without loading an overlay.

This is the solution you want to adopt because you've decided that it's
what you want.  You've said this quite a number of times now.

> > Repeating yourself over and over again is not going to help here, it's
> > just going to make people more annoyed.  Please stop this.

> Then please add something constructive to the debate rather than
> repeating that users have to add compatible for devices used with
> userspace driver. That's ridiculous from usability point of view and
> so will never happen. At best workarounds for kernel obtuseness will
> be used.

It would take a lot less effort for you to just describe your hardware
in DT than it would for you to continue repeating yourself, this is a
trivial task.  If the tooling around this is too hard to use then that
seems like a useful thing to work on, having simple ways for people to
describe modules they build for maker type systems (ideally integrated
with schematic capture software) would be great for example.

Both Greg and myself have provided you with feedback which you appear to
be ignoring entirely.  What you are demanding is not idiomatic for DT or
for the device model, this needs to be taken on board rather than just
shouting at us.  Putting a quick hack in that happens to work for your
very specific use case isn't going to give us a consistent, maintainable
and well designed system if it doesn't fit with anything else we're
doing.

--tgGnixv3tJWXBxdL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXcsQgAAoJECTWi3JdVIfQPeMIAIWEIixwqwnZDZqPdpm70CFF
ZfnTH4ZR4SU3iXqYe8dkW69Eu0pGSLH7P9uCmZlBJwkC0UO4OZhgzBIDCPfuC7Gh
KuK4iUuD/ijPvmL7RUKpsc9S+W64foERuIKWW0Kb/IvcNC3AjPmBtC/7jhTeYYug
mfoSJTA6CTJ/dzKG3SgCkTEqn457s7BsUw/+OeNIvos3k8QpqtIe2rpX0jaB2Sx+
gXqkocT8CjB7qiEaBoF1Zj6yAGhiC83om/4a8CPv9GrLAy2GkU6VUFb9yOtu4r0n
MVuZ3QTZ/A6W0M6eyJYwclW1BPxB7Ndnut+9ibEMI8s+4s7Zjb9Hg7Il+UDejx8=
=8k+Y
-----END PGP SIGNATURE-----

--tgGnixv3tJWXBxdL--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
