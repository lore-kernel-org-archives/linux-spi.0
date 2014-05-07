From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: atmel: fix incorrect comparison
Date: Wed, 7 May 2014 20:50:30 +0100
Message-ID: <20140507195030.GM22111@sirena.org.uk>
References: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="35HXvU1qzCTR5mW7"
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1399391081-16095-1-git-send-email-alexandre.belloni@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--35HXvU1qzCTR5mW7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, May 06, 2014 at 05:44:41PM +0200, Alexandre Belloni wrote:
> Found using smatch:
> drivers/spi/spi-atmel.c:878 atmel_spi_pump_pio_data() warn: unsigned
> 'as->current_remaining_bytes' is never less than zero.

Applied, thanks.

--35HXvU1qzCTR5mW7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTao6DAAoJELSic+t+oim9qlwQAJl4blCLqm/Rqh1eEgs3luJi
ITt6gYd2koJzm8Ah+Df08VGtaGd6ZIg7q2jF5v7NkEGN7yXXsECE3pGfhWWl+EBX
cbpcU/9iKVpq0Jg8yWVw21Xnfb70Mu5a7lKrE6p4yub+RzJoJBjPeeScVL90fGok
/jSR+1sHzo3lsEnFPgtRu1UhhgQFn6j+Fd13Qz2faj7CKYrm7Zpa/O7fpNu03Lna
YDl2sdWYAuL0KhgM9bfB5JecIxJPZqrkvinDSLgr8Uc9CP7Z01QWKxjyOWFAPao3
vYQFSC22nIXq+f3xpLuTAvmplgHPc2QuFRBlMwkvKwhnEM72TjHwb5gCy+7JaI3R
Tl/vUHWsJgJoeZpUf9R8QdpTkQIqckPUidzGvXS/rTM7UaCGVMIbJCb7b37FTzHr
CnuzQt6Bg9dYWwy7pS3JAlKgR3QPQk2tDpcpykxiFFnve64ZLKUN8CBMFtOkAj49
szfj1FxUrFVW/bjFDOCbhnzxOuvYYubC7JLB77jXWike2fT2S696a8TD1ZV1y/8+
B0tRdTr6MsJEDW1zAs/FeyyEAHEKQScZsA73NQsSuq/dyIT2H80DQgC2PJ48hRnu
ciNG4S7D4VLf4LZHxWdyKbYlB5oMI8zJ3lcLZqO3NhGE2CenwNz7v5dOLsS5QA74
uWsSweO/T9xP11PtnvTC
=HOsK
-----END PGP SIGNATURE-----

--35HXvU1qzCTR5mW7--
