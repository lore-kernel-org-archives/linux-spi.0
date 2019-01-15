From: Mark Brown <broonie@kernel.org>
Subject: Re: Regression: spi: core: avoid waking pump thread from spi_sync
 instead run teardown delayed
Date: Tue, 15 Jan 2019 19:26:19 +0000
Message-ID: <20190115192619.GG5522@sirena.org.uk>
References: <f86eaebb-0359-13be-f4a2-4f2b8832252e@nvidia.com>
 <7C4A5EFC-8235-40C8-96E1-E6020529DF72@martin.sperl.org>
 <aabd916e-005e-6cda-25d7-8ab875afa7a0@nvidia.com>
 <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="HB4mHL4PVvkpZAgW"
Cc: Jon Hunter <jonathanh@nvidia.com>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <AAA7943B-B1F1-4389-AAC3-8621EC6E38B8@martin.sperl.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--HB4mHL4PVvkpZAgW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 15, 2019 at 06:39:27PM +0100, kernel@martin.sperl.org wrote:

> Is it possible that the specific flash is not using the =E2=80=9Cnormal=
=E2=80=9D=20
> spi_pump_message, but spi_controller_mem_ops operations?=20

Right, that's my best guess at the minute as well.

> Maybe we are missing the teardown in that driver or something is
> changing flags there.

> grepping a bit:

> I see spi_mem_access_start calling spi_flush_queue, which is calling
> pump_message, which - if there is no transfer - will trigger a delayed
> tear-down, while it maybe should not be doing that.

If nothing else it's inefficient.

> Maybe spi_mem_access_end needs a call to spi_flush_queue as well?

Hrm, or needs to schedule the queue at any rate (though this will only
have an impact in the fairly unusual case where there's something
sharing the bus with a flash).

> Unfortunately this is theoretical work and quite a lot of guesswork
> without an actual device available for testing...

Indeed.

--HB4mHL4PVvkpZAgW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlw+M9oACgkQJNaLcl1U
h9Ax0Af/aOKsziyOkq8/ZbakEdsATprCNt/E+Y0zLxAMfn9nXuaZ4a/WZJLA9hu8
TC0pZTNicwIrkIdU+ItoqssWN7NiDCR41cJEw2gDk35A9nVuwR7cJG0Vi7YbaZLH
zbRRc6TUO68wEwx0lfm8njejzbtYjoos/WywKKRAs1GblvCP57MN0mjjV96/gGAz
0JXQjAFdq58kfHGPClmmgLKMCW5DYkOeMO8RudSCpVRL06uOHGfretNDGeMkLGiv
7g2dlxm/8yByb3vK21AS5UfFKj0M2I7Au6k6mTGMwxkm/GBYEtp9PqmrJ0Ru4gPl
cE8Hgb0jb7c7hOzdxLPeFniKm8vFow==
=0mz9
-----END PGP SIGNATURE-----

--HB4mHL4PVvkpZAgW--
