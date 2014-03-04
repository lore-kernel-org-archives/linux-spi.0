From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi-topcliff-pch: Fix probing when DMA mode is used
Date: Tue, 4 Mar 2014 12:44:22 +0800
Message-ID: <20140304044422.GJ2411@sirena.org.uk>
References: <1393428679-18462-1-git-send-email-alexander.stein@systec-electronic.com>
 <1998640.ToDhBRKzdY@ws-stein>
 <20140228034331.GG9383@sirena.org.uk>
 <2382434.oQkeY8Zb6p@ws-stein>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hZw0Sfr4I7XguZav"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexander Stein <alexander.stein-93q1YBGzJSMe9JSWTWOYM3xStJ4P+DSV@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <2382434.oQkeY8Zb6p@ws-stein>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--hZw0Sfr4I7XguZav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 03, 2014 at 08:21:16AM +0100, Alexander Stein wrote:

Fix your mailer to word wrap within paragraphs so that your mail is
legible.

> Well, i think this is a rather rarely use case. You need either all
> drivers compiled in where the SPI device driver is loaded before SPI
> master or you need SPI master als module while the SPI device driver
> is already compiled in. Oh, and the SPI device driver must do a SPI
> transfer during probe. So the conditions are reptty strict when this
> problem might happen.

> PS: On EG20T (PCH) it seems this will never happen as the DMA channels
> are allocated wrongly (see other patch from me) andso DMA will never
> be used.

OK, so this doesn't sound terribly urgent then?  It's hard to see and
other bugs mean it wouldn't be triggered anyway?

--hZw0Sfr4I7XguZav
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFVoiAAoJELSic+t+oim9sWoP/2Dn9a4QtFG9YQdg0622Xi7S
gkFaOoPaxP2hOZBmdTGTXNOAM26l1ujbqsuk7O9HrsySDoX6SvCELAGlo8eNTOPd
epIOIw/3XJ3VK2IM+v456cSUcXVBtcsO0grTIaojpj+SkSkUxReJJSarpUUUMKpO
MKGcpzGsV0r7kCc9it4/0FMxd7c4vyLMUxsHGV6f7FGqiEaxDkC/ng3+7lsT5TnY
JTaFmhBJSscsrXzIb7fG0EmKbmyaLwIVY5PvP+f37hNYhXb5H5toc+fOUMzt+PK8
wdBySz07RRfXs99bn4rWSpMPD5RIJfTJYf1A9bUfABdhQjhCgLtNSvqPAM7Z1L5p
mQsxwJG2kTipgVrYgSUy4ceponX6tMmeMi24ROQTtXDFi4ikDfkVMXUtXsKkwjxO
u4tgKyAlH6ruMfd9ZGNrxmeu6EAzVCHsOFrY3S3w1mrxGgucG7mvpx+qgGLRjQvB
IhSW2/kL7g3AVQhqnw2AUnnnlJalCxvkZZoBbG+uXOrEbAJGOz8BpNUosUyrVOyt
ag2SeRCSNASo5kxIdCphIuXH1ppRz1E6mT71sEd5Eel6QF9hmv2kNu53vEUKpz08
YbplMLDO28TXOLE940gTXYnc87sc9utU+gEydYqoMJwgChlpDMbz1NNm/NB52sgb
vzD01ucfaRJNvnnvyVXs
=97/S
-----END PGP SIGNATURE-----

--hZw0Sfr4I7XguZav--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
