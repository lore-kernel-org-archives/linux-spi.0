From: Henry Gomersall <henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
Subject: spidev: That spidev in the DT issue again...
Date: Fri, 2 Feb 2018 15:47:34 +0000
Message-ID: <ef61ff15-ec38-42f0-8ef3-9235b50dfda1@smartacoustics.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="CYjZW4wLfLlvs0PpieBRarIaUhMQueAJV"
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--CYjZW4wLfLlvs0PpieBRarIaUhMQueAJV
Content-Type: multipart/mixed; boundary="Lr5a6h2Mxs9J0Q1kKrlUCza4Ip29uXCfc";
 protected-headers="v1"
From: Henry Gomersall <henry.gomersall-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
To: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <ef61ff15-ec38-42f0-8ef3-9235b50dfda1-rFU6cQq7QtIud/4VRtRfoNBc4/FLrbF6@public.gmane.org>
Subject: spidev: That spidev in the DT issue again...

--Lr5a6h2Mxs9J0Q1kKrlUCza4Ip29uXCfc
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable

Hi All,

Following on from Kyle's email on 2017-11-29 in questioning the
"correct" way to deal with the device type being set as spidev, I'm
still not clear on the solution.

Before I dig deeper into understanding it, is there a reason why we
can't have an "spi-generic" device as a catch-all for a DT defined
userspace SPI bus?

The clear use case for more flexibility in the system is around FPGA
based SoCs (in my case a Zynq). In such a scenario the use of userspace
is a natural complement to runtime configurable hardware blocks. It
would really ease access to (at least somewhat) correct use of the
driver if it could be recognised that the kernel might not actually need
to know what's on the end of an SPI bus.

Best wishes,

Henry


--Lr5a6h2Mxs9J0Q1kKrlUCza4Ip29uXCfc--

--CYjZW4wLfLlvs0PpieBRarIaUhMQueAJV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJadIgWAAoJEGf0MT1zztWmzUsP/i7JQMZCtI0eGPXUYRiAjRnt
bRRvMIidSo1fd2XXIwkTCnY+pYBgh5NYqfgOPJ8L06bH7pX/HxbAN3r1n8FUi60W
dG1JY49qgzvhwNCk1C7AO556PjnyUJa8Xag/fNJdN3vao917On5H1q2Ho918nElC
rieq6lhR66eHexSJYc9/hxJSBABNA8y+BNLn8S0grgI6CLS0zsq4z8vMQN8J/s0X
8TPQn8AJ+Wzs5HsxtGeTBWiVp7kgWSQkpF3kEeO9VxqTJ4purQJ2yzOEBPGTEGF5
EbVLW8SCPDWGTed+fBVEnXBGq6CP41uZYH8Afb9dt0A5VDRa/zglioDRM3vDMBkQ
Zx8BR9NRfihdGHLHm020bdmpN/O7GnaIx5q7fanJQ7SVA9qdxDwH/heZKkCGtgRF
+7q3bB7hj6NrQuokXRtw/qJrvljit2e9wMXmJ0mofHnW4DRL4Whmex+TBLM1b8UL
IA6BnXwE9/tVTC+LcFD8WnDHPDoAdo3877gzA1XBMNlp5qEXF97xg0bQDIaKocv4
Zg+EhYOTUyrB7qIBMVy0JwdHVs9NScx+M9ie8CaUdWE2d5TVGrvvn7s6zS2GzUIg
f03aeh3JEqb8R+p3uPgJSPaYgt13RTV+Jhb8eVIsOtM5q7HS0ELFpz6fErbrJG3+
Bd6JqVtX5Qg7IXrOUlWw
=XfoH
-----END PGP SIGNATURE-----

--CYjZW4wLfLlvs0PpieBRarIaUhMQueAJV--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
