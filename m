From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 08/10] spi: expose master transfer size limitation.
Date: Mon, 7 Dec 2015 20:18:04 +0000
Message-ID: <20151207201804.GP5727@sirena.org.uk>
References: <cover.1448988089.git.hramrach@gmail.com>
 <8c34c7790244489c2ce0072c72bd9bc7c4cdb965.1448988089.git.hramrach@gmail.com>
 <20151201231233.GA1929@sirena.org.uk>
 <5FC39638-EEE0-4CFA-B464-0B4743CB6AB6@sperl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QAdlk5ze2izLk3Ap"
Cc: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Heiner Kallweit <hkallweit1-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
	Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Han Xu <han.xu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Boris Brezillon <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>,
	Stephen Warren <swarren-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>,
	"Andrew F. Davis" <afd-l0cyMroinI0@public.gmane.org>, Marek Vasut <marex-ynQEQJNshbs@public.gmane.org>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Mika Westerberg <mika.westerberg-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Gabor Juhos <juhosg-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>,
	Bean Huo =?utf-8?B?6ZyN5paM5paM?= <beanhuo-AL4WhLSQfzjQT0dZR+AlfA@public.gmane.org>,
	Furquan Shaikh <furquan-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Martin Sperl <martin-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5FC39638-EEE0-4CFA-B464-0B4743CB6AB6-d5rIkyn9cnPYtjvyW6yDsg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--QAdlk5ze2izLk3Ap
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 04, 2015 at 03:30:50PM +0100, Martin Sperl wrote:
> > On 02.12.2015, at 00:12, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > Can we change this to return SIZE_MAX instead (ie, the maximum value for
> > a size_t)?  That way callers don't need to worry if there is a limit, if
> > they want to handle it they can just unconditionally assume that a limit
> > will be provided.

> As I just came across: spi_master.max_dma_len, so I wonder how this=20
> value would differ from the proposed spi_master.max_transfer_size
> on specific HW?

> For all practical purposes I would assume both are identical.

Yeah, we should probably just remove the DMA specific one in time though
it may be useful for some devices with built in DMA engines if they're
oddly limited I'm not sure how practical their DMA would be if it
differed from the overall transfer length.

--QAdlk5ze2izLk3Ap
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWZel7AAoJECTWi3JdVIfQjjQH/iy91T7A4JvYs/YwGF+FG0Uj
B8qw/GNfCdVEH3FFCXPO6knkp5FVlHWGRhdnZzt2lWb2FfrZoN5OefDALP+g/PRK
gFzHqoBMCE8lcuPMMRQsJuShGG94N1I+q4RuriA//0DXYXnJuyWms2k/yo0EWtlV
9zK5M6gg4tkTnMJBz1z5+2vzoD5xPK4VzHQSmoPk60E2SZ+987f+fhuCtqwu7t1e
589uV8Ko3XE12QK+ulBlbwQorItX6S6QtyNZC7k9UBnq35QVnROPaQ1VY2ElwIPy
DM5sqtNCGFjVEXVqq1lkuQMkXcx1fqxPLXdzsp6pp+oGzlo05XdbKkomQk6e8GA=
=lDk6
-----END PGP SIGNATURE-----

--QAdlk5ze2izLk3Ap--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
