From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 15 Jan 2019 21:25:39 +0000
Message-ID: <20190115212539.GK5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
 <20190115192619.GG5522@sirena.org.uk>
 <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="+HmK7y6O+lKZIGkr"
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Martin Sperl <kernel@martin.sperl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5D3256B1-5DAE-4E3F-9099-5425F4BCA304@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--+HmK7y6O+lKZIGkr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 09:58:55PM +0100, Martin Sperl wrote:

> Maybe a bigger change to the reduce the complexity of
> the state machine would solve that problem and also
> reduce code complexity...=20

Yeah, that's where I was getting to with that test patch I posted.

> I may find some time over the weekend if no solution
> has been found until then.

Thanks for volunteering :)

> The way I would envision it it would have a =E2=80=9Cstate=E2=80=9D
> as a level (0=3Dshutdown, 1=3Dhw enabled, 2=3Din pump,=20
> 3=3Din transfer, 4=3Din hw-mode,...) and a complete
> to allow waking the shutdown thread (and by this
> avoiding the busy wait loop we have now).
> This would replace those idling, busy, and running flags.

That's a good idea, yes - a single enum much more reflects what we can
actually do in terms of transitions.

> Drawback: it is invasive, but let us see what it
> really looks like...

I think we need to either drop your change (which would be bad since it
is a big performance improvement, I'd punted it for later when I did the
original refactoring to push the work into the caller threads then never
got around to it) or have a invasive changes to make the new situation
clearer.  Right now things are just far too complex to reason about
which isn't helping anyone.

--+HmK7y6O+lKZIGkr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+T9IACgkQJNaLcl1U
h9ApOAf+MWM+IL1uhFKV6QS0+G2LKoICXpAb4txk4+PMZjEneaHHCPyywK4NC02y
gjnpm7BS+A4FuKfDvr2XRFBdd7fkj+08xBv9tGrmUpi4trayMablnZcwwZ293q47
rxGIy+BkUTmzBxhM0Rk6JgI91ZCoUN5gnPrP3LpkfGNS8tcECdPyCJsQDXKqcSwj
pNrVxHkArPPGFesoSQNxHDeuGvj0QNURq0kXCk4Dpiy9hvvucO6HImG38RNo5Yow
tWWx3K4otQ3+eqiGWxML49BqATXtEs+MvKdfM8beeJAJWmqwam/+MSjYCSLzfPfK
JB7+O0fGjQDtXFbkuA79qWMGmRENOQ==
=LWLb
-----END PGP SIGNATURE-----

--+HmK7y6O+lKZIGkr--
