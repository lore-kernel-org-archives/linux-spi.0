From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/omap2-mcpsi: Always call
 spi_finalize_current_message()
Date: Fri, 24 Apr 2015 10:59:31 +0100
Message-ID: <20150424095931.GJ22845@sirena.org.uk>
References: <87h9s63bff.fsf@tcd.ie>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="EALzl22nLCS/hQF+"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Fionn Cleary <clearyf-/Zw1syy4LHg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87h9s63bff.fsf-/Zw1syy4LHg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--EALzl22nLCS/hQF+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 23, 2015 at 09:13:40PM +0200, Fionn Cleary wrote:
> The spi queue waits forever for spi_finalize_current_message() to be
> called, blocking the bus.  Ensure that all error paths from
> omap2_mcspi_transfer_one_message() call spi_finalize_current_message().

Applied, thanks.

--EALzl22nLCS/hQF+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVOhQCAAoJECTWi3JdVIfQg4kH/isnwb7VkJs3pXEdL3+MmrbQ
bxzd2xGyotMc2DhItlDZMHAKM0rokEzhN50Fnj0HkdrgSH5DjdN8BAmYqbLMq4iR
M4ekmCCYBWy/J9lKenPUrgNjxYtdu3LWhrPESVp1lgUIIaAulWTSZyiFfeh6jAfL
/095r0VxJdFgEK9wV942/gb6ubfLNKpNnf/gCKnFjAL7hFDkNohNNPE8n/4YfhZ3
2k60y2qFNGfAremNM3RSD0bG2VjYLUaUV+tbbF0AX4pY0w/v9oKqzKlUkMrJrb9v
WQN1qeIU+GHvEcH0veAU/z+2wrg9ra/b7JfILT/9HhG9EejkgLPV9EuTIyvxJng=
=z6kT
-----END PGP SIGNATURE-----

--EALzl22nLCS/hQF+--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
