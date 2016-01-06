From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC] spi: dw: support setting tmode dynamically
Date: Wed, 6 Jan 2016 12:13:45 +0000
Message-ID: <20160106121345.GV6588@sirena.org.uk>
References: <20151223192338.128e95a4@xhacker>
 <20151223121512.GV16023@sirena.org.uk>
 <20151223202952.28be5bab@xhacker>
 <20160105161231.GG6588@sirena.org.uk>
 <CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FQ9/qgh0YgB02Feu"
Cc: Jisheng Zhang <jszhang@marvell.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Khoa Dang Pham <kpham@apm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAFLsZf0LvrQ60GdLzp_5nPLVxSxVaPadgzT_7aL4SQzgvswQbA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--FQ9/qgh0YgB02Feu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 06, 2016 at 08:45:38AM +0700, Khoa Dang Pham wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> According to the "DesignWare DW_apb_ssi Databook" (version 3.21b) provided
> by Synopsys, the EEPROM read is:

> "When TMOD =3D 2=E2=80=98b11, the transmit data is used to transmit an op=
code and/or
> an address to the EEPROM
> device. Typically this takes three data frames (8-bit opcode followed by
> 8-bit upper address and 8-bit lower
> address). During the transmission of the opcode and address, no data is
> captured by the receive logic (as
> long as the DW_apb_ssi master is transmitting data on its txd line, data =
on
> the rxd line is ignored). The

This is just a normal data transfer, if the driver is functioning
correctly this should not be required and requiring it would mean that
we'd need to go round adding workarounds for this to lots of client
drivers.  It seems like you are trying to work around some other bug in
the driver, quite possibly incorrect handling of chip select as was
suggested elsewhere.  If that is the case a common solution is to manage
the chip select as a GPIO rather than with the built in handling in the
block if the block can't cope.

--FQ9/qgh0YgB02Feu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWjQT4AAoJECTWi3JdVIfQseAH/RT/vje8QSfjrmrRIzfapofh
50oF5tIpa8yJPYu6XEM7SdWS5y3ok5x7MvmTyKMU8591Wd0LhgO/CO3wiA4HjnvH
f918FC1VUOe4QI3QUbKncWLiicdpif/AISUIBrEyPz1caOr0FM1QQoDP+PJAZQ5L
8T14xu84EZ3Qnb4VFs+E2nfdRp448FC7GAYsL8/Q1ccESrGOfEWNKy5hLHTW284P
qzDjxSj1tGYxKrNmX/8K3Jr62Ph/AH9e4tJB24QCPI7+4Zc53WrL6ufRLDRqEIb7
BMY5u4Ib7W3zpVbU1kI6Vym3pjU1vX33uES/LVYMOhnbXAif9Z50/Pfl9G1rocI=
=A/aF
-----END PGP SIGNATURE-----

--FQ9/qgh0YgB02Feu--
