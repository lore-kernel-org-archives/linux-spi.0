From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spidev: fix possible arithmetic overflow for
 multi-transfer message
Date: Mon, 23 Mar 2015 14:01:49 -0700
Message-ID: <20150323210149.GR14954@sirena.org.uk>
References: <1427133027-8134-1-git-send-email-abbotti@mev.co.uk>
 <20150323185042.GL14954@sirena.org.uk>
 <5510698B.3040000@mev.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XAEV7zm15O60d1Zf"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ian Abbott <abbotti-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <5510698B.3040000-GUHe90Wt2aFaa/9Udqfwiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--XAEV7zm15O60d1Zf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 23, 2015 at 07:29:15PM +0000, Ian Abbott wrote:
> On 23/03/15 18:50, Mark Brown wrote:

> >This doesn't apply against Linus' tree as far as I can tell - if you
> >think this needs to go to stable please send a version that applies
> >against that.

> Sorry about that.  It applies to linux-next and might apply against 4.1,
> depending on the timing.

v4.1 is linux-next at this point...

> Can you strip the Cc line or do you want me to repost the patch?

I've applied it, but like I say it won't go to stable.

--XAEV7zm15O60d1Zf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVEH81AAoJECTWi3JdVIfQZWYH/iF1DvxHCZXeHYfC55l6mGfr
2MZOrJQCMnwIS2nrc/Qij8ceUDXwUsmLlXWRp+NIRXSoG/rXpm6TWtYhKxk6eMZk
4XISRmCSN9Gc1emP+jxiXd8upYIggAMVrwVrde/9rvDJBwDEnQqT3EI8q1kgvPMq
IBcxLES42bmXAltyEu7O/FVWcsymiZKt3qF7NQNcupl+3nq6SZUI//poMQxC7Z3s
JWiCEfS/zKehw2+6uQjzJd8Cn4DequX3Eg0K6ylEP7YEmyCoxxBgeW9amvbF8zl4
T68lKOCWb0LYZPNPd0ra0JJNEtHaoXv2wS2D3tw4dZnVKESI3bbc7xDe91OktJg=
=/z4e
-----END PGP SIGNATURE-----

--XAEV7zm15O60d1Zf--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
