From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: davinci: Fix compilation warning.
Date: Mon, 5 Jun 2017 14:37:16 +0100
Message-ID: <20170605133716.srpxai3i6uyva4go@sirena.org.uk>
References: <b6b0d421633c6ea51cdaf3e582f8bebd2034251c.1496664791.git.arvind.yadav.cs@gmail.com>
 <CAMuHMdU-o1zw5ETY3d7tV4kQ7K5wf4KuPBhZL3akQwiKj3+cHQ@mail.gmail.com>
 <211a274a-e7c2-6f74-7ab0-e122240dc8f7@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="obrbwebrmd2ty7bv"
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
        Murali Karicheri <m-karicheri2@ti.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <211a274a-e7c2-6f74-7ab0-e122240dc8f7@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--obrbwebrmd2ty7bv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 05, 2017 at 06:59:15PM +0530, Arvind Yadav wrote:
> Hi,
>  yes, You are right. we are getting this warning.
> drivers/spi/spi-davinci.c: In function =E2=80=98davinci_spi_probe=E2=80=
=99:

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

--obrbwebrmd2ty7bv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk1XosACgkQJNaLcl1U
h9CXbwf/ZdK9YdtJDc6hQo3wP1+4V+b/K5PFC1h84Qzc20SYvjbPn2Sa6dApyl71
QuAbG717bnVeLOethCzrl06mbLXXKsDvjDbvHUFWCUU1zzumSYYHDGwGF/MyWI1t
rmam9WYd+UfPkVmmu5pgW0vRNUAv7qHSJZw/NQzA1f69ZV7o8HvsRqIgZjjRtsK1
oL87uw0dN96SciBHW3cIfAsykagHz5ytLQyqmdn4o7P1uhtcVhbTLOGyXOcptXCk
G4oPBNG+z5KUuLaV0kXgNtDR07JV3tmsIG6xcC7dAZa4bbaxKO7dRQJVSkdBeoWV
blpQOkYUSd5QX1S0+Cdb3b1cxrclJw==
=MgBO
-----END PGP SIGNATURE-----

--obrbwebrmd2ty7bv--
