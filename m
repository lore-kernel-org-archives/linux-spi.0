From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2] spi: deal with a compile warning
Date: Wed, 2 Jul 2014 20:50:30 +0100
Message-ID: <20140702195030.GR410@sirena.org.uk>
References: <1403753203-13473-1-git-send-email-B45475@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wc6dtGz1CZgs+5WP"
Cc: linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org
To: Zhao Qiang <B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1403753203-13473-1-git-send-email-B45475-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wc6dtGz1CZgs+5WP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 26, 2014 at 11:26:43AM +0800, Zhao Qiang wrote:
> ret is unused when CONFIG_FSL_SOC defined,
> so return ret instead of -ENOMEM when the
> kzalloc fails to avoid it.

Applied, thanks.

--wc6dtGz1CZgs+5WP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTtGKDAAoJELSic+t+oim9issP/R58ta/q9aDpEMjXxVAMQbHR
NQ5Z9su/lm5iekuJwANYAZjCU6fXvNgLZrz7+EH5QpU5M3loAeAEoL1qGh977Sgj
uBWFapVBFBKgQEl6yq+WZpUep2rjaTqFdAxccJdgnFlnSVzFlZlr0oP/3awnFsNH
9N/BLLm0T8igGb0TbLpRkb6xc9N4v01Usq6YLvkoI95UyUOqRy8BrGMVhNyO2Irb
jOL8kWV0APX2i/eAmaw8oC4nS8CqjJjcNy9FsJ9TX0G2NwBo4slmOmlAwt0Md0nO
HR/cFvjG2BLYjaImVGt3nSl3ex7sVRnxoPwmQuHVe6wiELRqlwsgSpikdSSK1ZD/
S6ndzf73bILS05tIsQfj3d1HxRfXta6VUYmgPJL+Y+u61xi3jZ6ANuRN6pn0/tjh
JDM05KOaIwT7jKK9j2lIVnPeIzcWYAx72xJ93tmaraDRE7ZBwcRgFsAyXgAOPxjr
G/QmgZQqyjJ8vgpv013fVd4tY6hYqgDoCwatGwk6ETnkKnGk4S+g/L/qbXh+uL+I
EdhqQ4aWMbOIIeE3wds57ISBgV2w1KSBowRivrpwVlXc32hcwOFpImVLoj+uXmwq
XbKMiZBMT8wzZHWTSBp6XZVa7DpPzwNGItlGVqVcRPpz6Th1iwmAQ1j7SV0NY55V
eEiXZ3SqlbZFmGIlr/V4
=LWdR
-----END PGP SIGNATURE-----

--wc6dtGz1CZgs+5WP--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
