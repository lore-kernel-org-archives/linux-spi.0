From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 1/2] spi: orion: Change spi-orion to use transfer_one()
 semantics for SPI transfers
Date: Wed, 14 Jan 2015 17:22:06 +0000
Message-ID: <20150114172206.GA4160@sirena.org.uk>
References: <1421032440-15335-1-git-send-email-ken.wilson@opengear.com>
 <1421032440-15335-2-git-send-email-ken.wilson@opengear.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8p/3hdGJBHAENZPK"
Cc: thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org,
	ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org,
	ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, gerg-JBU5SbJe1FlAfugRpC6u6w@public.gmane.org,
	devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ken Wilson <ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1421032440-15335-2-git-send-email-ken.wilson-xg7Pnmy8KxlWk0Htik3J/w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--8p/3hdGJBHAENZPK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 12, 2015 at 01:13:59PM +1000, Ken Wilson wrote:
> This commit changes spi-orion to provide setup, set_cs, and transfer_one
> functions instead of transfer_one_message. This allows chip select support
> for both native and GPIO chip selects to be added.

Applied, thanks.

--8p/3hdGJBHAENZPK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUtqW+AAoJECTWi3JdVIfQyKcH/1rOfEb5pMLI95Y+6L6Tb+x/
qneOjSR10GZMk9ScRs9TMrnCESTVqiv1SU5nTbQsB56zvvLBoZ5X2WnXx2kEMC4O
hHdAjjz46e4WBrmRTgt52Zbn/sbucKDtLAbiY2FSkLFEIclkVhlkuQgAmBkPi9jZ
xk699s91Qp0FwefqN9pSLNJMLIuILUMynzf9VC+5XKbXaGErFOhlgjiZ34YCD8Du
CU9GOwf91TR6XuML4eNGs5QKdKFmmEyJ5l9PH9lk4Cbg026hMpkbp8KQVx2jakTR
4U45Qd6n5oHqq3jT5znuXYklm8xLXBuJlctOZAWJUoKVEWw5HtxZB/kLQT7nj7w=
=7J8p
-----END PGP SIGNATURE-----

--8p/3hdGJBHAENZPK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
