From: Mark Brown <broonie@kernel.org>
Subject: Re: [GIT PULL] spi updates for v5.2
Date: Wed, 8 May 2019 15:11:36 +0900
Message-ID: <20190508061136.GI14916@sirena.org.uk>
References: <20190506143301.GU14916@sirena.org.uk>
 <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="BX5bBAwwbKvz0cyO"
Cc: linux-spi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAADWXX_k_D7=SPd=bi-=3EtBjeG6fe0EaTb4U4ZZgoOoRSub-Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--BX5bBAwwbKvz0cyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 07, 2019 at 08:08:50AM -0700, Linus Torvalds wrote:
> On Mon, May 6, 2019 at 7:33 AM Mark Brown <broonie@kernel.org> wrote:

> > spi: Updates for v5.2

> Hmm. Please be more careful. Commit 1dfbf334f123 ("spi: ep93xx:
> Convert to use CS GPIO descriptors") caused a new warning because it
> removed a "for ()" loop, but left the now unused variable 'i' around.

> I fixed it up in the merge, because I hate warnings that may hide real
> problems. But I also expect maintainers to check their warnings,
> exactly because the normal build is supposed to have none. So a new
> warning does stand out.

Sorry, I've actually got a fix for that queued but obviously didn't
manage to make sure it made it all the way through the process to the
pull request.

--BX5bBAwwbKvz0cyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzScxgACgkQJNaLcl1U
h9CnJwf/eKpzIkTbhVcC7J2Bb3sJsMXD6vuBkkbnkgLlu4ajKp9FJx+eTtd4eETY
NobQp2PD84TpU62FmkQxvxvCMNezwtGN+IcttLV0o7I6MvJKbFU6vJwKTBztXawA
pcd43PWu9rI9KearSLkkGdVGAQAbY6CurPPJNeG3/JElOHkUgoEt04PW2DE6OoyX
lSHkynrdR+R+EmYtDXj9ZJO2Hd8ebDodBd/XB2Ay+VQubqzFY7rHiHI/q+zRDD6V
LLRkDphcmwVOnurHYGeYNoi56XYidEmvTN9dkjP+Jzu5l5K03kXf1Q2xo7LQPhZk
s96tTYvAn0pM7gu2JM7zy8m1BR9pOg==
=VZ8j
-----END PGP SIGNATURE-----

--BX5bBAwwbKvz0cyO--
