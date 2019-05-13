From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 4/5] spi: bcm2835: support effective_speed_hz
Date: Mon, 13 May 2019 16:14:50 +0100
Message-ID: <20190513151449.GC5168@sirena.org.uk>
References: <20190223084952.14758-1-kernel@martin.sperl.org>
 <20190223084952.14758-5-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4628338548351382258=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190223084952.14758-5-kernel@martin.sperl.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============4628338548351382258==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 23, 2019 at 08:49:51AM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Setting spi_transfer->effective_speed_hz in transfer_one so that
> it can get used in cs_change_delay configured with delay as a muliple
> of SPI clock cycles.

This too.

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzZiekACgkQJNaLcl1U
h9BSTwf/TAxVYCmKUlukCF4emOMZMaTxRry36W4e1gJaSpAzWTMypCBKOwx32o0R
DRGb4z0ZX8smadkw66yG1vu4wB9ZtgxOR0bD4OQi7b0uAEiK0nt1fVosXTnpnhcB
Pi9Vv1vUlNchha8WZ8VXpF4mY1SgxHtn82b1OJ8FX9eXgS0RUuLgVTIZGXaqLaBb
oLoURMHmAPkkKGZ1cxfWuYbxC0w4ufc4qsieqbdwROPb82GQVdzZWkuY3ZRDiFzj
BOpO7pZbiIGmwoVVYMgnssB2v2zGQMoiqzMgWD3695PVfnRnqnjdsX1BibwsegD1
kCc+qEMQA5gKHAUZMNHqQxc6cVAedQ==
=tSRe
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--


--===============4628338548351382258==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4628338548351382258==--
