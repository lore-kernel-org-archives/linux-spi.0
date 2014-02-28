From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Fri, 28 Feb 2014 12:43:31 +0900
Message-ID: <20140228034331.GG9383@sirena.org.uk>
References: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com>
 <20140227043719.GH9383@sirena.org.uk>
 <1998640.ToDhBRKzdY@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6bKodGeYF53agbop"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1998640.ToDhBRKzdY@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6bKodGeYF53agbop
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 27, 2014 at 09:13:21AM +0100, Alexander Stein wrote:
> On Thursday 27 February 2014 13:37:19, Mark Brown wrote:
> > On Wed, Feb 26, 2014 at 04:31:19PM +0100, Alexander Stein wrote:
> > > If during registering SPI master due to SPI device probing a SPI transfer
> > > is issued the DMA buffers are not allocated yet.

> > Applied, thanks.

> Thinking about this patch over night, this also should go to stable, no?

Possibly, though I'd have thought that someone would have noticed by now
if there were any affected systems using stable?

--6bKodGeYF53agbop
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTEAXfAAoJELSic+t+oim9YdgP/1nD/XZVgLUYzxqERuiRMOpR
Cz5nKNshFmVzHas8/NLRliG/4zGlGp1RgQkJnBS9VkqMyn+3PuoTvX+co78rV+8b
974yCDV1QbpbYvQ/sFQGb7CyJCdVP+KUQa4rlLmHrQy9c37HKWZfoGoo3yQye1du
chJV4caHsvCSS2smz6rXvC7Cyvu5o0FZDzhrD3ePSCpF+l8wDoxJJydw82rDT2xh
zgtMRlk0RhIAkRVGvoH8MXjGI3D9eLeWPGpzZaLmIMIYSr5zyxZV8gSsuuVlul+4
C5l0Q6zCu5ysHAk3uI4FVgrY0/B9VjY0aC8lTgOQnX3FceaLHarGtqfkqpV2/5qn
/vlyK4pyNy1e33Q6MSN5kLTC+9Pi6UjEntDCZTCoEO2WSsB8q9p+VqCEFULhgtiP
06npwieFBvPWueKPukb9FpcfyTukLt/eQ/+mfSxzyPLIaAIrjZIM5iAOivLnuT8Y
TqWOCI6JsUbm2BgAQ9ly/A6Cn/m7gwHdEv1aIi0LkZC5Ny8VP8+Tor7hg0AMOK04
RmqyvZDvyGA4IAsN2RxVVt6JDqI/TN0Rcqojf1Cf0aIVe2m8MzHT2S6dtSgryvd4
I2TYVTfUcGg0P16zkqkC6KsD+UnZG06/7lBrjJRQle32ZzWoi3TCjtfDzdD5A9vP
ALnUbVjx2emSB2ddxJ4T
=ZuOB
-----END PGP SIGNATURE-----

--6bKodGeYF53agbop--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
