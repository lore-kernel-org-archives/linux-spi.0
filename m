From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 -next] spi: fix spi-sprd-adi build errors when
 SPI_SPRD_ADI=y and HWSPINLOCK=m
Date: Mon, 25 Sep 2017 12:22:56 -0700
Message-ID: <20170925192256.bmrm6gmb4idvomxb@sirena.org.uk>
References: <ed5b8ca2-b853-755d-2801-57cc0b626508@infradead.org>
 <20170922092621.uq2xsvxangeetewi@sirena.org.uk>
 <9dc8b064-8a6c-98d2-4ade-088cbfd56fb1@infradead.org>
 <20170925161221.v23dpeljin5kakhz@sirena.org.uk>
 <449abd0e-8d8b-86e9-2b7a-65c27ab3171b@infradead.org>
 <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="sat7szmj55wuxpcl"
Cc: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdXwv7s-uBM2J1Rf5fw+2=N_VcPxCYHartgUxb56yrR23A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--sat7szmj55wuxpcl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 25, 2017 at 09:20:31PM +0200, Geert Uytterhoeven wrote:

> The issue is builtin drivers that depend on a modular API.  The clean way
> is to separate API and implementation, so the API can be builtin, and the
> implementation can be modular.
> Hence the API should provide stubs that call into function pointers, to be
> registered by the module providing the implementation.

In this case the problem is even more basic in that the driver does
actually depend on having hwspinlocks for any production use.

--sat7szmj55wuxpcl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnJV48ACgkQJNaLcl1U
h9CmvAf/cqC65jnDhSzDVAsiwmYuZbiu8TfEbI52qnxHdAiQjj/IFM4lab1hPZVU
iGTVhjV6g5MvxxzlJcib755hp1aplqAVhti1mjItSiIe5AjphExjJ64yzn4jMdv7
J8OIJkFibQ3vbklEwl8V3/S3FrLwg1smkFxC89AzEwjwz5tb1bWcnhUvLkR+Myyu
XPT5pE5cqWjy72P9GpdJsmVyIL3UNAnFYOcK44V2s0oiHDtPT2sOnoMAGgeM3rCj
30gt0SFJ0beNsKw8xKGPF6HWt5ot3Tam3zfC4mtf1ns5/oxfAnJ7TfrwZQB5oHvS
MONa+N6rpt/TlgMcaqMDLz3aTHJDbw==
=YgXW
-----END PGP SIGNATURE-----

--sat7szmj55wuxpcl--
