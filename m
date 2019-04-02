From: Mark Brown <broonie@kernel.org>
Subject: Re: [BUG] gpiolib: spi chip select legacy support breaks modern chip
 select and whitens the GTA04 LCD panel
Date: Tue, 2 Apr 2019 16:16:59 +0700
Message-ID: <20190402091659.GD2059@sirena.org.uk>
References: <7509BFB6-36E4-441A-9F16-7A4FEE7F7CF3@goldelico.com>
 <5488EF42-08DB-4273-95FF-49ED31E27472@goldelico.com>
 <CACRpkdb4URKcdZ-=3aG_np86Bp=1ahs+qztM-7yQkSP18ZkE6A@mail.gmail.com>
 <2286C331-4AFC-46A9-B8C4-8A8BA9CD33C2@goldelico.com>
 <CACRpkda4k_Vaoo1qEaZ3nv8bA4tcrPEN6oT-v+n9HRdA6=5Xvg@mail.gmail.com>
 <2D2D13C2-0D3E-47CD-946B-81DBBF3C43E6@goldelico.com>
 <20190402053143.GZ2059@sirena.org.uk>
 <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1C2QhcYtVTlNtC1j"
Cc: Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Wolfgang Ocker <weo@reccoware.de>,
        Jan Kotas <jank@cadence.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>, kernel@pyra-handheld.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <F8ACE730-B498-41E2-A486-923C760807F8@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--1C2QhcYtVTlNtC1j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 02, 2019 at 08:37:23AM +0200, H. Nikolaus Schaller wrote:

> I have learned from Linus that the problem with legacy spi-cs-high are mostly embedded
> powerpc systems deployed between 2008 and 2013 where the boot-loader can't be
> changed. And where the dts is not maintained on kernel.org.

> IMHO it is very unlikely that they are running distro kernels. Or is there an example
> of such a system?

I used to work on embedded systems which were built by essentially
bolting expansion cards onto standard reference systems, for some of
them we shipped distro kernels with the extra hardware supported by
adding modules.  No idea if there's practical examples for specific
PowerPC systems though.

The burden when you're breaking things is more on showing that there
isn't a problem anyway...

--1C2QhcYtVTlNtC1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyjKIoACgkQJNaLcl1U
h9AdRQf+OjsrMPq6RrsYN5iuLoUXODLhFhHcW82so4UOC3CnkPulq7UpmK1V0ht9
7BF22zT0HFiyGMyUdbcPTFwBioXe0tdQDtsIE35K0BwAX63OncFc7dM1RYIIag8w
bWFQfBYRQtBxxyrhnsjxkZwKbfrfIUAXvBmu805zjo4bHt431tjJKEAY7tZ+5qjI
aoJM0D6Ubhp4/AEaYp+zxeNp3ifwsB41CjjGnQu5WcAXKZhUUKaLYA4H5ONS9kiM
jg3h3CkHlYzoAM5gmKs1qjh25SAlSZhF1pge65QNWXTl6GNQLk12Ar5IFZDnDT9o
Y6/GOyy7mfbK2xHNwmWMiYEGEEMPMQ==
=+mPR
-----END PGP SIGNATURE-----

--1C2QhcYtVTlNtC1j--
