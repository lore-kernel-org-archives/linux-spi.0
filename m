From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: fsl-dspi: Add ~50ns delay between cs and sck
Date: Mon, 6 Apr 2015 18:12:52 +0100
Message-ID: <20150406171252.GT6023@sirena.org.uk>
References: <1428093571-20407-1-git-send-email-aaron.brice@datasoft.com>
 <1428093571-20407-4-git-send-email-aaron.brice@datasoft.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zRW3mUn8fSI0is1a"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	stefan-XLVq0VzYD2Y@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Aaron Brice <aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1428093571-20407-4-git-send-email-aaron.brice-vSOi0k5x9wFWk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--zRW3mUn8fSI0is1a
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 03, 2015 at 01:39:31PM -0700, Aaron Brice wrote:
> Add delay between chip select and clock signals, before clock starts and
> after clock stops.

Applied, thanks.

--zRW3mUn8fSI0is1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVIr6TAAoJECTWi3JdVIfQb5QH/iBE1F6zkEzo3/vQ4u6KfVZy
ZCdK+27nBz9DLMo9WSmFsuIaMDLILGkkkuSrzHZqT+mfu3taZIpIvVkyI3nNg5pE
oUTwAEnUPq+APHAqZ93dXE3WpoeGf5Rz65DGVKp4yozVDho8TrbxJBNfXkIbm1CG
FKr3onj7ap8DAvIZtYu7ZfoC6DVM/wRXigQ2iLPp9msT+VTVLjwOJ0/U87r32Z++
71Tf9F/UDPMlHAeHA8e+n8WOdq8mT+2au2vWWwJk2fOe2bRffHZefhaCGq02Hsaw
NZiwGGebunn3hZ/EE6hXpXQymKiHFmFMJS3/4bFlmsgDK5ZCPlXKwo3yWYKNthc=
=TH/p
-----END PGP SIGNATURE-----

--zRW3mUn8fSI0is1a--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
