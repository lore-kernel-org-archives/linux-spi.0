From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RFC] [PATCH v2 1/3] scatterlist: Add support to clone
 scatterlist
Date: Thu, 7 Jul 2016 10:02:41 +0200
Message-ID: <20160707080241.GE6247@sirena.org.uk>
References: <1467039249-7816-1-git-send-email-fcooper@ti.com>
 <1467039249-7816-2-git-send-email-fcooper@ti.com>
 <CAHp75VfR=TKfVN=03jvGy5oZRA_-ASb8Vb_A4+x3OrkpZT6PoQ@mail.gmail.com>
 <577D3B5C.7080805@ti.com>
 <CAHp75VcPLV-483ihn_RmHnDOc0iFMSdYj5_SrNevyqrrpeWatQ@mail.gmail.com>
 <577D5E78.2010307@ti.com>
 <871t368lu6.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BhxIwg67zh/LWMpM"
Cc: "Franklin S Cooper Jr." <fcooper-l0cyMroinI0@public.gmane.org>,
	Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	david.s.gordon-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Jens Axboe <axboe-b10kYP2dOMg@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Ming Lin <ming.l-Vzezgt5dB6uUEJcrhfAQsw@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>,
	Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <871t368lu6.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BhxIwg67zh/LWMpM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 07, 2016 at 12:04:33AM +0200, Robert Jarzmik wrote:

> For these "tricky" cases, at the time I created sg_split I had done a tester as
> well. It's very basic, doesn't cover all the corner cases, is a bit dumb, but
> you might have a look, and the brain cost you'll pay to adapt it to test what
> you want will hopefully pay off by the knowledge gained on scatterlist. It is
> appended at the end of the mail.

Might be worth getting this into the kernel source, under tools/testing
perhaps?

--BhxIwg67zh/LWMpM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXfgyXAAoJECTWi3JdVIfQDw4H/iA9JrBp288DcB26ETU2gTkz
4d21IMw+RhljLqQyFcCXQSMV7pPscSC24F8BZLtrWI9JBTgCbQZm+XdZ6XtfQlt2
yR/NHpSeuVkJULAPhfEOn/DWsd+VPqsXx07Ak37r2xg4jNJg0WlfWtbMVIIhRWDP
bc4IOiM8lqHenraRkiaICTyJAHT0kkf4IX9pUT38U4EeIVG5S4IslEKI87aMhKh5
xrqetjzMMXJg3rTxJgqooYw+stRoUbQx1axfsLo6eSOvjz21028ACbP/8H8B7wUy
697SImy9ubPpNQtngisd7TDuA6otMj00iFH0BYexLia7Avui+BJhJBvaidJVRhE=
=ZxWY
-----END PGP SIGNATURE-----

--BhxIwg67zh/LWMpM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
