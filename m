From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: s3c64xx: added support for polling mode
Date: Tue, 23 Apr 2013 16:15:12 +0100
Message-ID: <20130423151511.GR5019@opensource.wolfsonmicro.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
 <1366614565-3743-2-git-send-email-ks.giri@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CPn8Wy5ME997YUMW"
Cc: spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	grant.likely@secretlab.ca, t.figa@samsung.com
To: Girish K S <girishks2000@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1366614565-3743-2-git-send-email-ks.giri@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--CPn8Wy5ME997YUMW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2013 at 12:39:23PM +0530, Girish K S wrote:
> From: Girish K S <girishks2000@gmail.com>
>=20
> The 64xx spi driver supports partial polling mode.
> Only the last chunk of the transfer length is transferred
> or recieved in polling mode.

This appears to have a very noticable negative impact on SPI performance
on my S3C6410 based system.  Not delved into it to test why but are you
sure it's not mistakenly selecting polling?

--CPn8Wy5ME997YUMW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJRdqU0AAoJELSic+t+oim9j0AP/2LSgiYibWqYsCJ2WrIZDmIT
P41YOwSxixxvigSChfLHivoP8nUrhbXGjQDL+2ZWBV1dX+JA0YTOqsVCxRY/LCMR
wa0PJJzL22AJ5cEd4LdEX5Ejwq2HJplTn1i6C0q2X0hy5zFxfR+wxXKwNCxy4t7w
uqKAwBwC52wQSm1Q67ASzYmPufxsAaNj90ikeFvxVT8ggwXhRN5dECnNZl11hUcy
w8E6DVEcNcVzj+gxJLxBpqzgki/iGemhp7FLGZ1/SdGV5QjGJyak3CxVbwb/dk/Y
rNhASRAFaV7bWE4xj6CyNDhmjc6l/cCcsKwKs41hXBfsTtM1pVauBuknFfu1j1vE
NinclKNCpiu3UrP/bU7HZWVzV+cIZVrqOFIgP+x/MP8WHJalLXi2U7hM3iZPnElH
o8SMGp1t/PqAtd/sw7WnAsG7mQ1mH8WQZitReyluMKwxs2khBNORFDIHpgnvPJML
Ek44rzsp6CEd1sqFRyhVW8VaOMPdofoYRG6sfP5yuDMj4/TgByaNnhmTLFr1rxnm
EGtTaDOwAX2QIzgsl+Az0MHPqu/GEWzOm8xE1HMccD8wcSwyMaMHUttbCh1Qzj7k
iHHgGyzocp45+DCGXkvERSovVrZ1q1Yr6hoqyr/bVB4+baNuSkTin+eYSXQyft0C
i7ikPoMuPzUUy64qtrKT
=EGxO
-----END PGP SIGNATURE-----

--CPn8Wy5ME997YUMW--
