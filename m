From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 15 Jan 2019 19:27:16 +0000
Message-ID: <20190115192716.GH5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <20190115151009.GC5522@sirena.org.uk>
 <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="J/zg8ciPNcraoWb6"
Cc: Martin Sperl <kernel@martin.sperl.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <313fc9d6-a142-91c2-8868-188bc70c019f@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--J/zg8ciPNcraoWb6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 15, 2019 at 04:09:14PM +0000, Jon Hunter wrote:
> On 15/01/2019 15:10, Mark Brown wrote:
> > On Tue, Jan 15, 2019 at 02:26:02PM +0000, Jon Hunter wrote:

> > Right, I think with the current code we just shouldn't be checking for
> > busy in teardown, since there's now a fairly big delay between idle and
> > actually turning the hardware off the name is just super misleading and
> > the logic confused.  I don't have time to test right now but does
> > something like the below which changes it to a flag for the hardware
> > being powered up work:

> I tried your change but the same problem still persists.

OK, I feared as much with the stats not showing any activity.  I do
think it needs a cleanup still but probably won't help here.

--J/zg8ciPNcraoWb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+NBQACgkQJNaLcl1U
h9AjPwf/aq7uDvdaZWuPtnn04wHdQBQ6qt2pWHW9rQkd3gzm2K6t7I/K5bskpW6+
2D2brkBj9WluGaMbnUW1bzCc8Pfgeesifrb0vy0rjP8m+lMcFboCjjOYB0tloefp
17opY7PqAnk8476IFv7Am3g+InAoOhr3DdXDx2ETPRBCHDhTEd4wiHEVLG5+qkke
XGmjBKS1JHkhRT9TVvkiploszqO04E8Ff26T8hAgePEog8R7N0WoetrPsrwq1YAk
rn3YQcSLARLHkeLorTqM5C+49FKbj5JRtgNp6cNeo5WwZbSge0Kr470cCj4iTAS2
4mvqCuNjma2OumepNnm/EJuaMOgMtw==
=YvPD
-----END PGP SIGNATURE-----

--J/zg8ciPNcraoWb6--
