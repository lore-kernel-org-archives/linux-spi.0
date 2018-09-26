From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH 1/3] dt-bindings: spi: Provide bindings for fsl dspi
 working in slave mode
Date: Wed, 26 Sep 2018 23:33:59 +0200
Message-ID: <20180926233359.2ca0d344@jawa>
References: <20180918093437.26799-1-lukma@denx.de>
        <20180918093437.26799-2-lukma@denx.de>
        <5baa1aee.1c69fb81.cc7c6.340b@mx.google.com>
        <20180926163212.17646e43@jawa>
        <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/YPc5BhSZ8A/Cni0/zVR7toh"; protocol="application/pgp-signature"
Cc: Rob Herring <robh@kernel.org>, Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-spi <linux-spi@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdWWYvhGX+SmG+WuLJZAX6PdCSd0hzNqiNB1r_A+B6tbSA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Geert,

> Hi Lukasz,
>=20
> On Wed, Sep 26, 2018 at 4:33 PM Lukasz Majewski <lukma@denx.de> wrote:
> > > On Tue, Sep 18, 2018 at 11:34:35AM +0200, Lukasz Majewski wrote: =20
> > > > This commit provides the description of new property:
> > > > "fsl,spi-slave-mode" which enables support for DSPI driver
> > > > working in slave mode.
> > > >
> > > > As the new compatible shall be used with SPI bus equipped with
> > > > master device a new "spidev" based node has been introduced to
> > > > avoid confusion.
> > > >
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > > ---
> > > >  Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt | 8
> > > > ++++++++ 1 file changed, 8 insertions(+)
> > > >
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt
> > > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt index
> > > > 18eeafe359d8..b30af19a2bc5 100644 ---
> > > > a/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt +++
> > > > b/Documentation/devicetree/bindings/spi/spi-fsl-dspi.txt @@
> > > > -26,6 +26,7 @@ Optional SPI properties for slave nodes:
> > > >  - fsl,spi-sck-cs-delay: a delay in nanoseconds between stopping
> > > > the clock signal and deactivating chip select, at the end of a
> > > > transfer.
> > > >  - bus-num : the slave chip chipselect signal number.
> > > > +- fsl,spi-slave-mode: if present, controller runs in slave
> > > > mode. =20
> > >
> > > There's a standard property for this. =20
> >
> > I've just realised that there is "spi-slave" property in the
> > Documentation/devicetree/bindings/spi/spi-bus.txt
> >
> > I will convert the code to use it.
> > =20
> > > =20
> > > >
> > > >  Example:
> > > >
> > > > @@ -56,6 +57,13 @@ dspi0@4002c000 {
> > > >             fsl,spi-cs-sck-delay =3D <100>;
> > > >             fsl,spi-sck-cs-delay =3D <50>;
> > > >     };
> > > > +
> > > > +   spidev3@1 {
> > > > +           compatible =3D "fsl,vf610-dspi";
> > > > +           spi-max-frequency =3D <30000000>;
> > > > +           reg =3D <1>;
> > > > +           fsl,spi-slave-mode; =20
> > >
> > > This doesn't look right for how slave mode is described. =20
> >
> > You mean that I shall replace fsl,spi-slave-mode; with "spi-slave" ?
> >
> > Or is there any other issue with this code? =20
>=20
> According to Documentation/devicetree/bindings/spi/spi-bus.txt:
>   1. "spi-slave" should be a property of the controller node, not of
> the slave node,
>   2. the slave node should be called "slave", without unit address,
> and without "reg" property.

Thanks for clarification.

>=20
> Gr{oetje,eeting}s,
>=20
>                         Geert
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAlur+0cACgkQAR8vZIA0
zr3bjwgAsuYJZZ2Q8RQJosawxvqIMAiG7KLKjE6cIc9gPTY5QcpULYUM4mAa84wc
1AZqKHUO5MyrFd/OcrGLA758mf5f0AmV/h4dS2qJO7veFFZVfovgX0qpPBMvSbK5
Vm/TnG04009T8Cha047ioaVpSnljM5x4ztAXW0Takl76NxhwrLUvVkEN6xZwXtFj
TspzdBAHWUpywoT2xx/COR7ZU0rt8vr98COmnHWLdQ7G6WCDoO0WiUKIKJe6a9Eq
leXTRJzS0IdDUpa5Cb0KhcwuFCNUV+fYKp7P1puFJA+ljf4gfC5+4ZSxf3Zdos/I
RD3y3o3n+0N/dDNVPUdu4Lrsgmg0zw==
=r8ku
-----END PGP SIGNATURE-----

--Sig_/YPc5BhSZ8A/Cni0/zVR7toh--
