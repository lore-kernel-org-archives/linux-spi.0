From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] Fix an error that can cause fsl espi task blocked for
 more than 120 seconds
Date: Thu, 21 May 2015 22:19:00 +0100
Message-ID: <20150521211900.GO21577@sirena.org.uk>
References: <1430523462-12306-1-git-send-email-Jane.Wan@gainspeed.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4KXkm8CArhzjwJ+m"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org, b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	insop.song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org
To: Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430523462-12306-1-git-send-email-Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--4KXkm8CArhzjwJ+m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 01, 2015 at 04:37:42PM -0700, Jane Wan wrote:

> Incorrect condition is used in spin_event_timeout().  When the TX is
> done, the SPIE_NF bit in ESPI_SPIE register is set to 1 to indicate
> the Tx FIFO is not full.  If the bit is 0, it indicates the Tx FIFO is
> full.

Applied, thanks.  Please submit patches in the format covered in
SubmittingPatches - use subject lines matching the style for the
subsysetem and keep commit message lines below 80 columns.

--4KXkm8CArhzjwJ+m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVXkvEAAoJECTWi3JdVIfQs3MH/3frYVIGOMEzKBhyoZW7wn5e
QWsIsEBW0twsK2Ld9LyLIV7Fdm67YbwVev/sHsweWY1heLFe8OpLuKItP6xWk1oG
ZSMRdXJzEsd/cY9PTAUAA3gZveefgADQEDbfgpUp7q9HZxHZVMvsgaG1Cy8BgzNE
f8dxyaVZP3C1qsMtxBoTBJc2RipDvPSSH7rf1EtP9dupHiJl99EIdvdbXNEZT0l9
m5zaf+PW93TykbA396A+u0lndmfSQsLzy3FkRgoROjZHeTRgjbmPXcfU5HrhNuTc
Fa58Q9xuJJxpJcir0hCno19xPZjRbrwMUUWn5E29uIxVamQ4WpC29CJTkGbmL64=
=mK0J
-----END PGP SIGNATURE-----

--4KXkm8CArhzjwJ+m--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
