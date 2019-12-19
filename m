From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH]    spi: spi-dw: Add lock protect dw_spi rx/tx to
 prevent concurrent calls
Date: Thu, 19 Dec 2019 16:41:25 +0000
Message-ID: <20191219164125.GG5047@sirena.org.uk>
References: <1576767380-12947-1-git-send-email-wuxu.wu@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MrRUTeZlqqNo1jQ9"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
To: "wuxu.wu" <wuxu.wu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1576767380-12947-1-git-send-email-wuxu.wu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--MrRUTeZlqqNo1jQ9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 10:56:20PM +0800, wuxu.wu wrote:

> 	[ 1025.321405]  default_idle_call+0x30/0x4c
> 	[ 1025.321415]  do_idle+0x22c/0x300
> 	[ 1025.321417]  cpu_startup_entry+0x28/0x30
> 	[ 1025.321426]  secondary_start_kernel+0x17c/0x1c8
> ---
>  drivers/spi/spi-dw.c | 17 ++++++++++++++---
>  drivers/spi/spi-dw.h |  1 +

You haven't provided a signoff so I can't do anything with this, see
submitting-patches.rst for details on what this is and why it is
essential.  That also has some other information on formatting
submissions.

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

--MrRUTeZlqqNo1jQ9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl37qDQACgkQJNaLcl1U
h9AJaAf/VcHw+FsWnYuqSH2qZ99vzwAVGSKy0z4tlu31qUpDCG9ck7/2ZIjbLjfC
9oJH30f+UFJ+8FbtWqkjqlQKlWfEsvJb1u6t3/MT2id0izMJhZmNEL2rejzJN9mJ
er+nAY71b7qSiGFeZIJ4WfDisQ5PN13Bb8Jc89xX81/AhXeeWQD+nzSim1oTkC51
nL6yv7348KLjmfxjWh/RDRpMGjnB36NqDElOS5JFleqrBj5VpYGgCaPAAYHiUByO
fRk//M+nrGRqaYxQ6ux4KQjsnMURsAiI1eC1FsZ+qR6WBXFIyiWy2DfF7YnnWGuO
XxFimsqORIFr+lhUPeBOxQjQ4XHnVw==
=Xr2v
-----END PGP SIGNATURE-----

--MrRUTeZlqqNo1jQ9--
