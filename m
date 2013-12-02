From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 05/11] spi: spi-sh-msiof: rx_need_dummy_tx variant
Date: Mon, 2 Dec 2013 17:49:01 +0000
Message-ID: <20131202174901.GN27568@sirena.org.uk>
References: <20131202031557.162e78d407d82effdee627ac@ops.dti.ne.jp>
 <1385921962-19843-1-git-send-email-takasi-y@ops.dti.ne.jp>
 <1385921962-19843-5-git-send-email-takasi-y@ops.dti.ne.jp>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="22aa2PWZKnsI44rM"
Cc: linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Simon Horman <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385921962-19843-5-git-send-email-takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--22aa2PWZKnsI44rM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 03:19:16AM +0900, takasi-y-nDL5PR/MsHhHfZP73Gtkiw@public.gmane.org wrote:

>  	if (tx_buf)
>  		tx_fifo(p, tx_buf, words, fifo_shift);
> +	else if (rx_buf && p->info->rx_need_dummy_tx)
> +		tx_fifo(p, rx_buf, words, fifo_shift);

This is going to transmit the contents of the RX buffer.  This means
that if there's any data in there it'll get sent but the expected
behaviour would be to send all zeros.  It's possible some devices may
misbehave if this were to happen.  It would be better to allocate some
zeros with kzalloc() and send that.

Really we should have core support for this, it's not the only
controller with such limitations.

--22aa2PWZKnsI44rM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnMgKAAoJELSic+t+oim9vNoQAJyA8h9DxiHLzalwfj7VixhF
9tDhyIE3bwe/i29UXCu++XqPQQQjRiPFFf4CXHaLebggPZmg1Suw71EDoPJlqNKC
x6jnJW2/+kNpGrQ2mKRbqWQeFMFzYGUweFhw/rJaHpbmC5UlgxoSsfIS/baF+1Su
2lTL99Q3jIAwFrU5MRad1pNdKxUWVX5EBlrlEpPbHr2DZTP9JrBsPH4RGuz0jyPZ
ay/ycbXhnPzHQja8KtO3LOZusQL78C44HQWZpCJa2qqW03efPEIOiXjBDlX5CFLo
Gu9vIUl2uKq1fVZ1lbLz0Kv7YVTp03yj4M1iOEY50L1IPT1m3BWyFTrral+LtWPT
0FdFtjdMblNSMtpoGU3nYkEukpmG82tUOk2KR0l7GP7LicMAFPF7E4Avm3quGink
CST4h2nDv8fBFWRRaBprIfpnmsFEz3Us7DXzg8V/ulFTi/40ecUBYLcoqoYIRkXn
Dz3hSoMxUKmQROIlBCJvn7qoz+3SVlPEmj1/6pLaGs4gaAbpc1rzYmff2BksQ2A3
QFe4RobQXgz26LTbQC4TNLXwiOv+acWqoaRDDq7HUd6jXuPDc11ONVDJPQqCrSoe
fketkyIUpz8xiJeixT02HAjP6yrebsuhWKURERsNgNx6jMDq4+L2CppbthN1f6Hz
agnctdBwVqxTi2PSildL
=4VaB
-----END PGP SIGNATURE-----

--22aa2PWZKnsI44rM--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
