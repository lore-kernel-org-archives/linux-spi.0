From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: imx: Revert "spi: imx: dynamic burst length adjust
 for PIO mode"
Date: Fri, 19 May 2017 17:30:21 +0100
Message-ID: <20170519163021.wydagxbq3huvhuy7@sirena.org.uk>
References: <1495113735-11891-1-git-send-email-fabio.estevam@nxp.com>
 <1495115958.26925.23.camel@nxp.com>
 <CAOMZO5Adj+sgxgoO9gN232EEH=NtjTHpKfB+EaUAbRXyaPD_Gg@mail.gmail.com>
 <591DBFD2.4090601@mentor.com>
 <CAOMZO5BZvp_iWoJCTkZL-buSu6pscv1U-6XLjjEm8PjVOjf9wQ@mail.gmail.com>
 <591ECF3B.4040001@mentor.com>
 <CAOMZO5BMuBjzsMcnEjC_RAHcwFg6OumOYtMiMOX9-f9NCVXH=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vcvnfgepjbia7equ"
Cc: Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org>,
        Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>,
        Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMZO5BMuBjzsMcnEjC_RAHcwFg6OumOYtMiMOX9-f9NCVXH=g@mail.gmail.com>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--vcvnfgepjbia7equ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 19, 2017 at 12:19:42PM -0300, Fabio Estevam wrote:
> On Fri, May 19, 2017 at 7:55 AM, Jiada Wang <jiada_wang-nmGgyN9QBj3QT0dZR+AlfA@public.gmane.org> wrote:

> > could you help to check if the following change address the spi-nor

> This fixes the SPI NOR detection, thanks:

> Tested-by: Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>

Jiada can you send that as a proper submission please (I need a
changelog and signoffs)?

--vcvnfgepjbia7equ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkfHZwACgkQJNaLcl1U
h9AV0Af9GfTn4UqcrhynTxpyERrXTIOCZQSeSBkm0tePI1/mpESPSTax2JjRg8Wb
qcLdNAH63R3i+m2RX+PYbMznfm/Yf8hW4vBAE4LmlDog+SMrnjGf0qn5nsIoMKa6
IW+BZjTxYY6LLVocRg5l8jCXQ/CCD8numovmbWUzuumvIFQshSjItpETBPZO+dYJ
Qh0uAgylftl2qJx0hK1ztP3mHBdgDSe9drvHG3e21N7t1j86b6oBHYRP8IurNnu2
Wn+p1PLjpwoxarKwJ3bNqMl21m7h8HR0DNyfxwWbyO5JYCFpdwVBBeCSiQHDcqAL
UkUFwIoqOmD9ve5Ax9v8va5QTFkj4w==
=8b03
-----END PGP SIGNATURE-----

--vcvnfgepjbia7equ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
