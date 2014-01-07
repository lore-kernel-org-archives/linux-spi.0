From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH -next] spi: dw-pci: remove free for resources allocated
 with devm_*
Date: Tue, 7 Jan 2014 15:47:34 +0000
Message-ID: <20140107154734.GV31886@sirena.org.uk>
References: <CAPgLHd9tVkshm+T-emPowGZT6_tNZHnBSMvhLeeQw3Ti-SytvA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oi/2mUCIIJC5Dd6Z"
Cc: baruch-NswTu9S1W3P6gbPvEgmw2w@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAPgLHd9tVkshm+T-emPowGZT6_tNZHnBSMvhLeeQw3Ti-SytvA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oi/2mUCIIJC5Dd6Z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2014 at 09:36:24PM +0800, Wei Yongjun wrote:
> From: Wei Yongjun <yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org>
>=20
> It's not necessary to free resources allocated with devm_*
> and free them may lead to double free.

Applied, thanks.

--oi/2mUCIIJC5Dd6Z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSzCGTAAoJELSic+t+oim9wisQAIwHBJp94ROKIGVLUb6J0PLN
njXWPlpifztZkAkBNqSY6kVT3hB4D7+NiDYMpANvOTmmnnnV66aFNyyqzKDlWLbL
6ctDVlqzNTHnAXcp+gx/0Qhe1rOKtq+OAmQpm+zeyOp5dyAr21Kv7G2vzvhvxLaH
EpSay1IrvVvGgvNs+biidjIZcg15GMJ5mMhCgs105MxCqg0LZZ3I+5wh/x5fhhXR
Sn1bzhgA7cdXOriKWwlgm0HtVWd+XSjMHCfJFPYw8N/18wLwQGnJtCFNVueOJi0v
lkLcShWGpWwxniEot17c4CQjOK4i/KaTayivHCbYQEQqwlbCSAVlWz0JeDg/426t
Wayy+Y1v717Z3SAWFD+FPqQ7SuIab8xIzcq+mNW6XULz1qDlnXo5sykPdFh2oera
+90N6lvx8xIeTd5Dzy8uzfM+igYU8YSHc/Z5fZsfftGNk0G8lL2EGYvD3Zhg0qO1
N+cYHJd9Wzmsue9qf3gdFRxa6MLobHwwR71ULaZLX5/HyTygHa9RRekk2vo/xs6k
y1/nX9E22DhC98sDz5V9lQpbUbXNwV8nM2tdVhv5zmdbcQ7/GwHNigpuIRS4ofq1
6yL9BDc5G3c7BCFeJfGhzuD8q74VC50wLhz/S7Ph27b5DiNwI8c/DRXegXPA7miP
y1HsUpmQ5v/Xzdei/52f
=0Gih
-----END PGP SIGNATURE-----

--oi/2mUCIIJC5Dd6Z--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
