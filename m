From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
Date: Thu, 16 Nov 2017 13:12:36 +0100
Message-ID: <cf336886-a64f-9ff1-2a44-984ff64f8433@pengutronix.de>
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw@mail.gmail.com>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107@caviumnetworks.com>
 <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ@mail.gmail.com>
 <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9xI0x2jnMhx85a0x0J3oUGqPNlMb47T2a"
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>,
        David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
        Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9xI0x2jnMhx85a0x0J3oUGqPNlMb47T2a
Content-Type: multipart/mixed; boundary="J6ARjg9R1whsU6rlw3R9fBkLaLkawTuKX";
 protected-headers="v1"
From: Marc Kleine-Budde <mkl-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
To: Tim Harvey <tharvey-UMMOYl/HMS+akBO8gow8eQ@public.gmane.org>,
 David Daney <ddaney-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>,
 Jan Glauber <jan.glauber-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
 "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
 Wolfgang Grandegger <wg-5Yr1BZd7O62+XT7JhA+gdA@public.gmane.org>
Message-ID: <cf336886-a64f-9ff1-2a44-984ff64f8433-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: MCP251x SPI CAN controller on Cavium ThunderX
References: <CAJ+vNU3VK=NPKW+119t4MT7w5xs=FS2HWJTqbFb-HSeJhCvwWw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <2771c4a8-ed85-86c1-a08c-5b62d177b107-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
 <CAJ+vNU0rsabjK80zmq_QBhPQqru2A06n8+zgEPvWfHdyb-kbMQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
 <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
In-Reply-To: <CAJ+vNU0qkXafz8FWjM_TCYj56dv31=ZQ306Ab2qSsePGD6E6KQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>

--J6ARjg9R1whsU6rlw3R9fBkLaLkawTuKX
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

On 11/16/2017 12:18 AM, Tim Harvey wrote:
> David / Jan,
>=20
> For reference, the HM describes TXNUM/TOTNUM as:
>  TXNUM - Number of bytes to transmit
>  TOTNUM - Total number of bytes to shift (transmit and receive)
>=20
> Here are some experiments that show somewhat inconsistent results:
> - full duplex 3byte tx / 3byte rx to MCP251x
> mpi_dat0 =3D> 0x03 // READ
> mpi_dat1 =3D> 0x0e // CANSTAT
> mip_dat2 =3D> 0xa5 // dummy (but making it 0xa5 instead of 0x00 to prov=
e a point)
> mpi_tx =3D> 0x100303 // TXNUM=3D3 TOTNUM=3D3; we see 24 clock cycles
> // wait for completion
> mpi_dat0 <=3D 0xff
> mpi_dat1 <=3D 0xff

Do you see 0xff 0xff on the MISO wire for byte 1 and 2?

> mpi_dat2 <=3D0xa5 // this the dummy byte we sent out MOSI not what came=

> in on MISO which the scope shows as 0x80

Oh, the device reads what you have shifed out? This is not good.

> if I set TXNUM=3D3 TOTNUM=3D4:
> mpi_dat0 =3D> 0x03 // READ
> mpi_dat1 =3D> 0x0e // CANSTAT
> mip_dat2 =3D> 0xa5 // dummy
> mpi_tx =3D> 0x100304 // TXNUM=3D3 TOTNUM=3D4; we see 32 clock cycles

What's on MOSI for byte 4?

> // wait for completion
> mpi_dat0 <=3D 0xff
> mpi_dat1 <=3D 0xff
> mpi_dat2 <=3D 0x80 // response for CANSTAT reg 0x0e
> mpi_dat3 <=3D 0x87 // response for CANCTRL reg 0x0f (because we shifted=

> 32 clock cycles)

Looks correct.

> if I set TXNUM=3D2 TOTNUM=3D3:
> mpi_dat0 =3D> 0x03 // READ
> mpi_dat1 =3D> 0x0e // CANSTAT
> mpi_tx =3D> 0x100203 // TXNUM=3D2 TOTNUM=3D3; we see 24 clock cycles

What's on MOSI for byte 3?

> // wait for completion
> mpi_dat0 <=3D 0xff
> mpi_dat1 <=3D 0xff
> mpi_dat2 <=3D 0x80 // response for CANSTAT reg 0x0e
>=20
> if I set TXNUM=3D1 TOTNUM=3D1 to send a RESET command:
> mpi_dat0 =3D> 0xc0 // RESET
> mpi_tx =3D> 0x100101 // TXNUM=3D1 TOTNUM=3D1; we see 8 clock cycles
> // wait for completion
> mpi_dat0 <=3D 0xc0
>=20
> In all cases above what is seen on MISO in relation to CLK matches the
> expectations of the mcp251x but the CN80xx MPI_DAT registers don't
> return what I see on MISO. Am I missing a consistent pattern of
> MPI_DAT vs TXNUM/TOTNUM here that would allow us to work-around this?
> Is this a CN80xx chip errata? There is no known errata for the CN80XX
> MPI engine.
>=20
> I could re-write the mcp251x driver to not use full-duplex but I'm
> assuming most SPI drivers use full-duplex transactions.

ACK.

You don't want to use the mcp251x chip anyways for CAN, the SPI is quite
slow and the load of the CPU is relatively high. Don't expect to get
many messages over CAN and prepare for dropped frames. Better use a
USB-CAN dongle. Or a proper card with some sort of PCI interface.

Marc

--=20
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |


--J6ARjg9R1whsU6rlw3R9fBkLaLkawTuKX--

--9xI0x2jnMhx85a0x0J3oUGqPNlMb47T2a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE4bay/IylYqM/npjQHv7KIOw4HPYFAloNgLQACgkQHv7KIOw4
HPYX7Af/cvGR1xEdTrGpPfukvDSKJcwBY6kOvqU/yCIkP/qTQH5VPMRz0ENlIJFX
Nsu6ilk8B2wZjrXss0XVLLEZBX/GjFtu0z5ysJC6gxJcdk713/H1Vw30YZDWi2p3
vlfLwcJyz8Xpz5lr30vJPD9rzuwqKHYEvDSKpCF1Y6BIq+EZ9jc/BTZ4AaIJ7Mx6
5G/pSIJC16ParX+nLfGzZybHm07+FP1HfPIgzYlBaFCAXnK1P/EshpszZDcJzpp3
2ERFSBGFYDNjnY++LZs38mB3ANdOFz4Gm5OvMM7jEyj0DYANqb4DCrPASQM3yz1H
rmrajYQFUuq4W0sdaax4jOVD8jKBcg==
=0rNj
-----END PGP SIGNATURE-----

--9xI0x2jnMhx85a0x0J3oUGqPNlMb47T2a--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
