From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 4/8] spi: sirf: fix 'cmd_transfer' function typos
Date: Thu, 4 Sep 2014 23:36:09 +0100
Message-ID: <20140904223609.GS29327@sirena.org.uk>
References: <1409648468-5436-1-git-send-email-Barry.Song@csr.com>
 <1409648468-5436-5-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wEheX93Nbmc2Tc0S"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	workgroup.linux-kQvG35nSl+M@public.gmane.org, Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>,
	Barry Song <Baohua.Song-kQvG35nSl+M@public.gmane.org>
To: Barry Song <Barry.Song-kQvG35nSl+M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1409648468-5436-5-git-send-email-Barry.Song-kQvG35nSl+M@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wEheX93Nbmc2Tc0S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 02, 2014 at 05:01:04PM +0800, Barry Song wrote:
> From: Qipan Li <Qipan.Li-kQvG35nSl+M@public.gmane.org>
>=20
> unify 'cmd_transfer' like 'pio_transfer' and 'dma_transfer' as void
> function, and also change left_rx_word according to transfer result.

Applied, thanks.

--wEheX93Nbmc2Tc0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUCOlWAAoJELSic+t+oim9JBUP/0UOf0btiAW3E7C0lVTH8Kcj
oBBPYUbFqefwD1MWeKaIHWF1B4U/8rvoiXowCr4bS5x181Kp443Eyk0ZM2LjTG0h
8ZN67eMmM3cg3XhSIBCBm5bRJgQe7bvG0YhomhVYpXaqFCg2bSQsFu510AZAcAUH
YowanJW8A+UctSC8MqHe51d3QWJYQB/oI/IXDSGQS2BsOkomGEeiCkZLNPMFjYfm
wQRgsyJhTxLIZwmz8ezN5h5MVWr7KefynBAyI6nCjiA2PaCYCBSGNUeyUW7L5HKV
gIKN8JInGe9x71Bhg/s/wVpOSr52MeQ52ZBbR3Xa8dhtXDqISKS92My5Ur10ShhH
k3A8xgE8MhToGOcysb3LlZToZcSfambUR2y9vgml2c/EivEXL8Z5Ux82MvetHiEp
SgFtAMe3sBTFOcDwsfCsg3bvLgwwR6zxRLYEzo6zXtsqvXCTeSqGnfPPM/Uy4aWx
EcMbAhqfZqzXmT+Pys4yIywbtrBxI1F83yxtB11QhPfZKXWJBwJrteO+07gxJf5g
9gR3w+z/U4MS0kM+g+kiQk6aSt4uFFY4eeQXJyr9SuZNbWiKDgO30ttrDZvofGd+
WgLP/r6sXJ78eX4DT2xSAdmDYMKFAfTWf3+0vbLy5+h82y+CSrcjUTxb62YYrL1B
nVhbIAOndt9a9QxHudZ8
=2nTO
-----END PGP SIGNATURE-----

--wEheX93Nbmc2Tc0S--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
