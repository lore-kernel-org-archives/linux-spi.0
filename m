From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/1] spi: imx: fix issue when tx_buf or rx_buf is NULL
Date: Fri, 19 May 2017 17:56:11 +0100
Message-ID: <20170519165611.4rlftoysmfmjtix5@sirena.org.uk>
References: <1495101672-3384-1-git-send-email-jiada_wang@mentor.com>
 <94de6e6d-a2fa-6589-151b-660bbcb42773@gtsys.com.hk>
 <CAHp75VfmF-5kYdTiR0Jt3dyp-7OJDBZg_5LA3odf4M0jyiX+-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="inm655zvxcmpyje6"
Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        leonard.crestez@nxp.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAHp75VfmF-5kYdTiR0Jt3dyp-7OJDBZg_5LA3odf4M0jyiX+-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--inm655zvxcmpyje6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 19, 2017 at 04:15:01PM +0300, Andy Shevchenko wrote:
> On Fri, May 19, 2017 at 3:45 PM, Chris Ruehl <chris.ruehl@gtsys.com.hk> wrote:

> > But I think we missing something here. We return from a void function()
> > so the error keeps hidden. The root cause is calling this functions with a
> > NULL pointer. See if you can fix this by find the caller and check if the
> > parameter hand over are valid.

> AFAIU some SPI controllers can have half-duplex protocol, in which the
> second buffer might be absent.

Yes, it's not only perfectly valid but actually the common case for only
one direction of data to be meaningful in SPI so the majority of
controllers don't require data to be transferred in both directions, it
would just add bus overhead.

--inm655zvxcmpyje6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlkfI6oACgkQJNaLcl1U
h9AVjQf+KeaSNGlGR12FvYMAxEixqW4KhSYZKcU5Ip9CL3H3fkXeTmhzV7c4C7nO
MwQ8mD3K8QtCp886mvLs4thCOWw2BEtSPmIGRSHWDuLeb0wL88UH9MCFKssN82as
GPHYRgYLRmd3kOSmF/urdWuzJ7xZYV83l6rPUGqI2OQcgF72cyZnnow2Wq7nkFbE
KPB914AmMQQCiGvl5C0Aoa8GCYYPJ3dKVnew8qxYvbq4S+CFmkfLdfvwBk3Pdg3A
+zwMrLC3ATn+2voIhg3nKiVHLx6c+XPAlpGJb2RscqhizPwq4r4D8lr21IsO2Inl
BQVXkuVLVUwCpdPYIr82dvXBDxrtVg==
=2Le2
-----END PGP SIGNATURE-----

--inm655zvxcmpyje6--
