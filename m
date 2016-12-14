From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/2] spi: add check_finished() callback
Date: Wed, 14 Dec 2016 15:21:56 +0000
Message-ID: <20161214152156.uehjhqoxpng47pnh@sirena.org.uk>
References: <20161211200350.13590-1-hauke@hauke-m.de>
 <20161211200350.13590-2-hauke@hauke-m.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="i6zad4m4rotuy54i"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hauke.mehrtens-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
        thomas.langer-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, daniel.schwierzeck-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
        john-Pj+rj9U5foFAfugRpC6u6w@public.gmane.org, nbd-Vt+b4OUoWG0@public.gmane.org
To: Hauke Mehrtens <hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161211200350.13590-2-hauke-5/S+JYg5SzeELgA04lAiVw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--i6zad4m4rotuy54i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Dec 11, 2016 at 09:03:49PM +0100, Hauke Mehrtens wrote:

> This callback checks if the transfer really finished. This allows a
> driver to directly call the completion list in the irq handler and it
> does not have to bushy wait till the hardware is really finished in the
> IRQ handler. This is needed for the Lantiq driver.

This is really hard to understand and does not seem like a good
interface, it's going to be confusing for anyone who doesn't have
hardware which is broken in whatever way your hardware is broken and it
sounds like it's misnamed for your hardware since my guess is that you
actually want to wait for something in the function rather than just
check to see if the transfer completed.

Why not just have your interrupt handler schedule something on a
workqueue to check whatever it is needs checking here?

--i6zad4m4rotuy54i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhRY5MACgkQJNaLcl1U
h9C7Sgf+NQbi/gp5Kwx77M1uFPuXhaRLy9AMfjGXf0DpMQ4/FRDIv1VP8X3KLt+4
HBW5QKWvWLRc94UHB680Y0YPRgwRUW1kHGaKbps+0zvTZI8SqeP45zyQ/yoEW2p4
kqVn1s2pynYqGGCNsqXFHmNzuW+Z60AIjBCZonRQ+dAcEG4u7BeIcacBJRr3oxuG
01jH2oU2UnaFRkaymUC/P8iwuwPOBoRMr/Cg0LUwFh3Qh3GvxL1uoRnj0l1hI9AV
dA4Vj+eXA5B0AIng7YPb9HnVG90uot/zdYNEI9SLg2hEq/7RWREz2n5msmBYoZK2
MWqrId7Cb/UKLiD5FVJOXto67VXxpg==
=uAh+
-----END PGP SIGNATURE-----

--i6zad4m4rotuy54i--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
