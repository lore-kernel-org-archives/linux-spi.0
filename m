From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/fsl-espi: fix rx_buf in
 fsl_espi_cmd_trans()/fsl_espi_rw_trans()
Date: Mon, 19 May 2014 17:22:00 +0100
Message-ID: <20140519162200.GD12304@sirena.org.uk>
References: <1400251581-26617-1-git-send-email-valentin.longchamp@keymile.com>
 <20140516190723.GT22111@sirena.org.uk>
 <537A2390.4070203@keymile.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1XZl5bH+IlhXYytK"
Cc: Linux SPI <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Mark Marshall <markmarshall14-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Valentin Longchamp <valentin.longchamp-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <537A2390.4070203-SkAbAL50j+5BDgjK7y7TUQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1XZl5bH+IlhXYytK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 19, 2014 at 05:30:24PM +0200, Valentin Longchamp wrote:

> Or are you talking about the initial memcpy call that fills up the local buffer
> in both rw_trans() and cmd_trans() ? And maybe your second point with the
> scatterlists is about replacing these memcpy calls ?

We shouldn't need this copy at all and therefore there should be no need
to make sure it is copying into an adequately sized buffer.  The only
thing I can think that the memcpy() is for is ensuring that the data is
sent from a physically contiguous buffer but scatter/gather should
handle that.

--1XZl5bH+IlhXYytK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTei+lAAoJELSic+t+oim9EEoP/iIiJF2qxr4J0zIjwg0YnZJl
3Lr9u9F+wOmsG8HXQC+oKAvRGGuqtO8bshtmmUpEv4JWuV9lhsc7xUPbq3ac4f3b
C7ZVg4WO8/H0xZ3+x3UwzGnq6N3lxEWeumbEDcmFj6REKArl3GK9B+ErDlGarSQx
e9TYMgWX8djxRW4bhpbKj+uB+E0q9KCP9HLiBy1RzpdCeAqbVJbRVl7nQVWi0pnf
bxdjA+AwJ4FZki3yCkMTNZvCCIfEsxNomMuGHNTHzzxfx0KmQaUAjN5X/MC7gA8V
QJun5h2wyAlSUvsnFkzSn55kxUOTbW8cPAHETWknY2JL3sWJriNUeT3p872wWRmw
UgflzQBz+ln3DH2zePQeyH+9agRbP086LkFHcf55XjSpaw9lFg5q4WpjcwWmaY6/
OwviI087NciXKc7QVHr/z7yzCMPZ1v233TV8CEvngkS3crT8sUUnfWsL7Kp36c3g
opbgjm0vsikeNZMNyAPfb2x98s99O9Co2QWafwKgS4Gd7tPIyPFz3PT4nYUNsYX6
TEk1nYRCblJQHfF1QLLO0F+3ByAKNZ4HapHASAm4iXOttP9x1K/g/dnWvXljTqiE
BKGuiGI4BFAj4ftIEwaXvO/+lPEhBB5HMgA/UEb3rxhLfY4anhM7V10GX9QjVZrq
kayKCOH41nvpOaICSZDx
=Exip
-----END PGP SIGNATURE-----

--1XZl5bH+IlhXYytK--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
