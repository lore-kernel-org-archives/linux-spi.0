From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
Date: Wed, 26 Sep 2018 16:32:12 +0200
Message-ID: <20180926163212.17646e43@jawa>
References: <20180918093437.26799-1-lukma@denx.de>
        <20180918093437.26799-2-lukma@denx.de>
        <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/LGoFAwmaqALw0uZRX55V==p"; protocol="application/pgp-signature"
Cc: Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/LGoFAwmaqALw0uZRX55V==p
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Rob,

> On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote:
> > This commit provides the description of new property:
> > "fsl,spi-slave-mode" which enables support for DSPI driver working
> > in slave mode.
> >=20
> > As the new compatible shall be used with SPI bus equipped with
> > master device a new "spidev" based node has been introduced to
> > avoid confusion.
> >=20
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > 18eeafe359d8..b30af19a2bc5 100644 ---
> > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@ -26,6
> > +26,7 @@ Optional SPI properties for slave nodes:
> >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > the clock signal and deactivating chip select, at the end of a
> > transfer.
> >  - bus-num : the slave chip chipselect signal number.
> > +- fsl,spi-slave-mode: if present, controller runs in slave mode. =20
>=20
> There's a standard property for this.

I've just realised that there is "spi-slave" property in the
Documentation/devicetree/bindings/spi/spi-bus.txt

I will convert the code to use it.

>=20
> > =20
> >  Example:
> > =20
> > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> >  		fsl,spi-cs-sck-delay =3D <100>;
> >  		fsl,spi-sck-cs-delay =3D <50>;
> >  	};
> > +
> > +	spidev3@1 {
> > +		compatible =3D "fsl,vf610-dspi";
> > +		spi-max-frequency =3D <30000000>;
> > +		reg =3D <1>;
> > +		fsl,spi-slave-mode; =20
>=20
> This doesn't look right for how slave mode is described.

You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?

Or is there any other issue with this code?

Thanks for your review,

>=20
> > +	};
> >  };
> > =20
> > =20
> > --=20
> > 2.11.0
> >  =20
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/LGoFAwmaqALw0uZRX55V==p
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlurmGwACgkQAR8vZIA0
zr04yggAxcFTFmT/2Ptx9RsItXvDRTGISWqky1pCWdlAhttHe6XELQTXBaRQfKox
MBP3NP7pIQlAPwHNtJqZWafcEBCAfkg1NL154CbDjoDCtuvSCMsGOUqksg7jNQEz
RT9lfEYfopqskhGapo6u1Oi2R+7RF2CcrEr00+VsrqtzXW1vtNaiT3AqwOyq+RFy
8tNghCmdumKKG9md1mS5cCSqsnqUhQjKNW7GQxiVoEye4pY1fJsak4+WHrSH9VCG
gPj6S1khWGA8u4qKI5IpXs4r252zRMXy4NPWS+LG1Kms1oCLtcWInGUr98kzrCqp
MXzpEfCqjQMiCcpBDTcOHDjv+woAKA==
=gVjF
-----END PGP SIGNATURE-----

--Sig_/LGoFAwmaqALw0uZRX55V==p--
