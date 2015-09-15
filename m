From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: mediatek: fix wrong error return value on probe
Date: Tue, 15 Sep 2015 13:34:07 +0100
Message-ID: <20150915123407.GC11268@sirena.org.uk>
References: <1441320656-8666-1-git-send-email-javier@osg.samsung.com>
 <20150914183925.GG12027@sirena.org.uk>
 <55F805B7.7020706@osg.samsung.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5QAgd0e35j3NYeGe"
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <55F805B7.7020706-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5QAgd0e35j3NYeGe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Sep 15, 2015 at 01:49:11PM +0200, Javier Martinez Canillas wrote:
> On 09/14/2015 08:39 PM, Mark Brown wrote:
> > On Fri, Sep 04, 2015 at 12:50:56AM +0200, Javier Martinez Canillas wrote:
> >> Commit adcbcfea15d62 ("spi: mediatek: fix spi clock usage error")
> >> added a new sel_clk but introduced bugs in the error paths since
> >> the wrong struct clk pointers are passed to PTR_ERR().

> > This doesn't apply against current code, please check and resend.

> Which branch should I use as a baseline then? The patch applies cleanly
> on both today's linux-next (next-20150915) and your for-linus branch:

> https://git.kernel.org/cgit/linux/kernel/git/broonie/spi.git/log/?h=for-linus

On the relevant fix brach (so mediatek in this case) or my -linus
branch - I don't think there's any development fixes queued for this
driver yet.

--5QAgd0e35j3NYeGe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV+BA+AAoJECTWi3JdVIfQ2P4H/jM4x85pB+WDFUY/3S8SfmJw
gW75oF1AsMMcYs/25CvoACZ/3AXuJSHujdZZlKD6UXfvKh4Zltjo/jL/pxp9KShI
9OInYwvYI9DZawzhdy5718b7v0dHc7Ax34Ky+EP2s+eUFhIxBgtZWeTP33SbL+37
dw0kNwex+k/Bw3NapfaCry80yLI4gvvwcgdcEGMP09O5Pf64T4YFlXTn73XIzP7Q
jXtFHSqnMImcoQX6Alana0TbQ91TvczOQPC6UbQLNS8IT/JyM7dIidAUQrr4gWhj
JDRPfdzt/2VhqQnfvqHAGjCq1yrKsYLz8KWF6lQbpAB+fTPfol7I17fJq3RJvkM=
=9bqq
-----END PGP SIGNATURE-----

--5QAgd0e35j3NYeGe--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
