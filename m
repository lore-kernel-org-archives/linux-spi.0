From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/3] spi: of: allow instantiating slaves without a driver
Date: Sun, 26 Jun 2016 13:45:50 +0100
Message-ID: <20160626124550.GO28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <ebe2a48124441819adab773b28cd12425ba5bda4.1466696079.git.hramrach@gmail.com>
 <20160626011500.GF28202@sirena.org.uk>
 <CAOMqctSA0G+fBKNgAizqWvEUfJLr9Fh0SsN0Pn-cQv=zeu7iFg@mail.gmail.com>
 <20160626112133.GJ28202@sirena.org.uk>
 <CAOMqctQernycZkc0Wia9EierT1PhfcYAPWc=89LgTC-DBgkg5A@mail.gmail.com>
 <20160626115815.GN28202@sirena.org.uk>
 <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="u+fRANu8FDjhiqn/"
Cc: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>,
	Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>,
	Kees Cook <keescook-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
	Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	Tejun Heo <tj-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Paul E. McKenney" <paulmck-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>,
	Davidlohr Bueso <dave-h16yJtLeMjHk1uMJSBkQmQ@public.gmane.org>,
	Andrey Ryabinin <aryabinin-5HdwGun5lf+gSpxsJD1C4w@public.gmane.org>,
	Nikolay Aleksandrov <nikolay-qUQiAmfTcIp+XZJcv9eMoEEOCMrvLtNR@public.gmane.org>,
	Dmitry Vyukov <dvyukov-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
	Adrien Schildknecht <adrien+dev-Yk6CzqVXkG6lnMjI0IkVqw@public.gmane.org>,
	Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Michal Suchanek <hramrach-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOMqctTf16DDs1j+pL47xBJt2BVdCdHPFUEwaZ6ak_vFtrKBOQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--u+fRANu8FDjhiqn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 26, 2016 at 02:39:20PM +0200, Michal Suchanek wrote:
> On 26 June 2016 at 13:58, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:

> > No, there's a lot more to having overlays to board-neutral connectors...

> If you are fine with using only the SPI pins then this is all it takes.

No, there's other things like figuring out which controller to bind to
that need to be taken into consideration.

--u+fRANu8FDjhiqn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXb859AAoJECTWi3JdVIfQIFgH/1VNHgOdYpVLAu8CGHv9YUBk
bOB96yTwYX8a5DoDs+TPHXAznP+d36Mr5Mvi/FtFHgrhlw1u6z0hw9akkzBSMp7c
cQvAhyg+hc6GtAjC3xOlhaT/3DWu8LhSTkElJyiPrN4W+u9ckbj5PQ65TmkYHZET
Er4UWYI5ih6CaCY2R0OFC+b59LcMpHp0LxSWWklK77fpuWICcWPDiAP2WjQxgxEW
z2jNuAmsrCzp5LO+iHNGC99LNxiiIXI78HzDJn6iyiCHiNNNyrW7/p/RbejIyURw
vQwR/Mrak4s5+zB0/471wtxQnRlOFcSBMzdkaQHxwe0VxgidvooQrJszctq+oug=
=GfiJ
-----END PGP SIGNATURE-----

--u+fRANu8FDjhiqn/--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
