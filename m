From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 3/3] drivers core: allow id match override when
 manually binding driver
Date: Wed, 29 Jun 2016 19:02:11 +0100
Message-ID: <20160629180211.GF6247@sirena.org.uk>
References: <20160627190949.GB5111@kroah.com>
 <CAOMqctQj0ftbOH9dvMPczBPeSFTvDuTKCXgYprYvtcQDYML8Kw@mail.gmail.com>
 <20160627221259.GA10054@kroah.com>
 <CAOMqctTQAY0NzTpEqyLyScu8UrSXcF82oLVMM+e2F2WQ225B7A@mail.gmail.com>
 <20160628155107.GP17217@sirena.org.uk>
 <CAOMqctQbFmWv04idz7G+dPOCg7n-E0AQdhGAyohUDBniKvrP_g@mail.gmail.com>
 <20160628183825.GS17217@sirena.org.uk>
 <CAOMqctTNmcg32PFVOZaA99GpFba9GOGOuOqmi3ujzxcHRFZsOA@mail.gmail.com>
 <20160628205736.GE17217@sirena.org.uk>
 <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yRA+Bmk8aPhU85Qt"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctS2xGCgfXschxudcAEYq-mcfPDmFS_pTzCuXa0bFBE0NA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--yRA+Bmk8aPhU85Qt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 29, 2016 at 05:32:48AM +0200, Michal Suchanek wrote:

> The other is to get a generic expansion board and jumper wires. Of
> course, you will not use all pins of your expansion connector this
> way. On the other hand using the remaining pins becomes challenging
> because of the jumper wires you just added. You can use some of the
> remaining pins as GPIO or add more jumper wires and use some of the
> remaining functions of the connector for another expansion board.

I'm more than familiar with flying wire systems.  They just aren't a big
deal here, this is a very technical audience making systems that aren't
going to have their software meaningfully distributed.  Users making
flying wire systems really ought to be capable of making the trivial DT
changes required for them, and if they just hack something not great up
locally that's not really a problem so long as it works for them.

--yRA+Bmk8aPhU85Qt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdA0fAAoJECTWi3JdVIfQYNIH/j53eWICwj1ipXC1eaXgYivy
8RlQtRVTnCH58CnvXTbaDNNagm3qIMlhxZRazXd0HwDke3RvUnZ7yfO5J7kW8iKr
zcu/oETTeeCHGJOsJXcvfKdScRsqK5qRv1DDkXqJluSvuIjOUEIXLW1m9MGZkjL1
io8JKisTLDXa6jjrZpbnnXhU1sZ5KgBFTYo2gKNgr4wV037FLVitF7Fn0C4V566F
BrPb9XUa/gn/Z/hnh6tl/yvMFkzTNXmkSQwNiOhspbYua1SVVagfXRTdV839wZ17
s2wbP0+T5g6bN+cnvTt/7LGiTGfDlQr0K8YA+pHE4u2BzhxXd6JtS6P2WQEMDQI=
=hzMJ
-----END PGP SIGNATURE-----

--yRA+Bmk8aPhU85Qt--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
