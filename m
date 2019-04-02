From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 0/4] spi: spi-fsl-spi: try to make cpu-mode transfers
 faster
Date: Tue, 2 Apr 2019 16:10:05 +0700
Message-ID: <20190402091005.GC2059@sirena.org.uk>
References: <20190327143040.16013-1-rasmus.villemoes@prevas.dk>
 <20190401073450.GG2059@sirena.org.uk>
 <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U58U7wle/RT11wuz"
Cc: "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        Rasmus Villemoes <Rasmus.Villemoes@prevas.se>
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <ce9e8ca8-6db7-1be8-5ea3-c098b1c1c813@prevas.dk>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--U58U7wle/RT11wuz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 08:43:51AM +0000, Rasmus Villemoes wrote:

> Thanks! There's one other option I can think of: don't do the interrupts
> at all, but just busy-wait for the completion of each word transfer (in
> a cpu_relax() loop). That could be guarded by something like
> 1000000*bits_per_word < hz (roughly, the word transfer takes less than 1
> us). At least on -rt, having the interrupt thread scheduled in and out
> again easily takes more than 1us of cpu time, and AFAIU we'd still be
> preemptible throughout - and/or one can throw in a cond_resched() every
> nnn words. But this might be a bit -rt specific, and the 1us threshold
> is rather arbitrary.

Yeah, that's definitely worth exploring as a mitigation but obviously
with things like flash I/O that gets a bit rude.  Hopefully what's there
at the minute turns out to be robust enough.

--U58U7wle/RT11wuz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjJu0ACgkQJNaLcl1U
h9AQpwf+OuW45aY1671qbCW3I/2+1Z2PuTbheg08DkMzK9IQ6qmkz9Web828TcQk
Wh+mr066jfLo2rf2NL3Ed2/zu4Y1GPn4wtqblsg1Jl2UsRGk+V4Eb27iaj6szvU2
GenjVXF7zia3xVVw5ISh5IKVnko+rRZnatuusPffejsXoRrtiG5gN3W9EJH6+oK3
b6BIPgQBqS0/de54NjVFthmd5X24fGwRfi2DkMwtN/W1k2Y8/bTQwTY+z5lepLRU
pM83mhetp3X1jZAt4KwjGlKmE4ATaU3Q8bDwOwTCyhyRMxDtUkts7pcyf1uez/rh
X3OwafCkR2xlVNqfRPt/mepvxntvLg==
=dmgT
-----END PGP SIGNATURE-----

--U58U7wle/RT11wuz--
