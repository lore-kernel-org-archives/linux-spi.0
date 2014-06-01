From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pxa2xx: fix runtime PM enabling order
Date: Sun, 1 Jun 2014 11:42:02 +0100
Message-ID: <20140601104202.GV5099@sirena.org.uk>
References: <1401466689-24335-1-git-send-email-ao2@ao2.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nKvJs6ze6az+4fwY"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Eric Miao <eric.y.miao-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Antonio Ospite <ao2-qKGr9MkilAE@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1401466689-24335-1-git-send-email-ao2-qKGr9MkilAE@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nKvJs6ze6az+4fwY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 30, 2014 at 06:18:09PM +0200, Antonio Ospite wrote:
> In commit 7dd62787334ac6e0e2a0ef3f20bb1936ac431b04 (spi/pxa2xx: Convert
> to core runtime PM) master->auto_runtime_pm was set to true.

Applied, thanks.

> I must admit I copied from 268d76430d1b68c340687357ffd18b4b12d02269 without
> understanding much of what is going on, but fact is that the patch makes my
> board boot again.

> Can anyone confirm that this is indeed the correct fix?

We need to either have the clocks and whatever enabled until runtime PM
is enabled or have runtime PM enabled before the controller and hence
clients can be registered.

--nKvJs6ze6az+4fwY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTiwN2AAoJELSic+t+oim94ykP/1RvW6FYXkGC3ktj0N96/NIj
2m0S/fv2fkaix4KLOC8d4w746wYHSXRZFl4l/DfXrZhTCKCxXvZEkGswbnRPhMRn
FzTAiX8UUMITdCaYL7w8LuZrxtrfO0MvNKagpaN7wpDXOzC1zOY6gnhSXCG973Zr
jgsa4X+fkAVkkLUVFJcROqtwE5LCEDNm63ok1AHQItPL6NFAs6n0SrSafDgVRebP
7geMCZjLS/qbSj+byMqsEsSHzH4lkrSLRBxUZAGg2LMqf1k6tA9z03vir5mmn3WZ
bX2F/97pf6j8zD2cN6qFdf9umv8rtLRbMoOSDutCMUTaRL5xaDx1uhgo6zVI0Muw
7BjxyZByiYwaC/hnjAUlZZTp/D5FcZWGFwiAMS8dsYu4uTlwf1KEXaQFHbr4gJ10
i11rIhaSdi7dLroUdYSaxQ9a/zbISO6XEVFcQzuRhKqwSEwa0neqc1QsFVBttjoS
aE6LaSC66XPxnL+Z456Hksx0+wLF81VXTeznNQko1o5sdgegWYRj3ShjGxFSvFUx
41KRSXs8tuxghrKoU54vdT2kfKHb9+HScWODoyJe01bsaNwkFsKtYeaSBSgF6X1W
ktOaMKYJ61FHjSMWJ66E341kxUQbzf9HMFe+ECLq5+0O+pG8h5c7K/g4Kkllvqc3
7zHBDmfNrOg5Ac7mzkXX
=CawS
-----END PGP SIGNATURE-----

--nKvJs6ze6az+4fwY--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
