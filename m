From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: omap2-mcspi: Support divide-by-n clock dividers
Date: Mon, 3 Feb 2014 18:26:11 +0000
Message-ID: <20140203182611.GJ22609@sirena.org.uk>
References: <1391354665-32146-1-git-send-email-stefan.sorensen@spectralink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E2AOuUyqcJWq6+RR"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Stefan =?iso-8859-1?Q?S=F8rensen?=
	<stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1391354665-32146-1-git-send-email-stefan.sorensen-usnHOLptxrsHrNJx0XZkJA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--E2AOuUyqcJWq6+RR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 02, 2014 at 04:24:25PM +0100, Stefan S=F8rensen wrote:
> Currently a divide-by-2^n clock is used, causing a very coarse
> clock selection, i.e. a 10MHz device will need to use a 6MHz
> clock. The McSPI can also use a divide-by-n clock, this patch
> adds support for selecting that when possible.

Applied, thanks.

--E2AOuUyqcJWq6+RR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS798/AAoJELSic+t+oim94OYQAIn9OT9clHZv3Yne2UyaNhOU
4KCtpFYR8RNp4lmqqQrxiZk88LoRxCuDFzsGkf+zRSgjyNf6U85lHqzsjtDGUn2M
4EhC+rRP4YPcpGfWwfbOe5ua2NpuyBg1CvhX8pt1sFW++d4xuIhfY39WCzm9nMlp
5fv58L6OiQYSwFo10XPDFFm8RC0Z1vc8urvztOQGsDjgJGZjHLlld9B/jr65gLvj
TJRHEehh5HchJ88L06AfBYGgCNyr5DNfpVsYZ3iolS0OpFhjaQ/UuemgHH96OkJr
9WRs5ZXpt5u6VvVNTPLwnluxnkq0UheyEJdbp+Va4Gs0+u3jYU8trcPc42qnRbpE
FDKPIQhOu49aCKol+R9wmOc7TjqVRAn8UPQs98pUtTz2Al3g5d+b1Q+GxJztu/rQ
VkTFsTV+N1B6n46c1wB12ktj7YOWFNmb6ano7QjOBITbaOHuYODzDFEolcaWfcjG
zgJgpwjOShO5apoRyQ73SChS7n6Tr9LFZoZT16cBa6OGGRMyWtUXnaGki6ewiboA
DpwQ6LAkk+RaBC9qy4QQUx89QhkLb3SYxvAXPQeurvoZ2b3P1hj261Pt134xskS7
pqqerqBnPtecGB+iAc+kPXFS3sCWs0raWddy6bGMCFT25kMk+Q73fhpPGkV5VTAa
Ol4czbSV4UmeXKVwlGQt
=YYXd
-----END PGP SIGNATURE-----

--E2AOuUyqcJWq6+RR--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
