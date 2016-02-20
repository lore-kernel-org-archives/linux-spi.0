From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: spi-pxa2xx-pci: Add ID and driver type for
 WildcatPoint PCH
Date: Sun, 21 Feb 2016 02:43:39 +0900
Message-ID: <20160220174339.GC18327@sirena.org.uk>
References: <CAC=cSJ91R6sT6FwCNv9pHaqnvOFwiigw0fdMhz1XX0NOMn6pTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1GFpsN+DA+8qGtn4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
To: Leif Liddy <leif.liddy-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAC=cSJ91R6sT6FwCNv9pHaqnvOFwiigw0fdMhz1XX0NOMn6pTw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--1GFpsN+DA+8qGtn4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 19, 2016 at 10:55:10PM +0100, Leif Liddy wrote:

> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=108331

Please don't include noise like this in upstream submissions.

> + [PORT_LPT] = {
> + .type = LPSS_LPT_SSP,
> + .port_id = 0,
> + .num_chipselect = 1,
> + .max_clk_rate = 50000000,
> + .tx_param = &lpt_tx_param,
> + .rx_param = &lpt_rx_param,
> + },
>  };

It looks like your patch has been corrupted so I can't apply, please fix
this and resend.  Pasting things into the gmail web UI is known not to
work, try using git send-email.

--1GFpsN+DA+8qGtn4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWyKXKAAoJECTWi3JdVIfQF4cH/0jx1/tiZwXZ9NbQGRO5Obvc
o3cpEKp8uY3EQmgQcNn0BuETmbq4JfY+sH2i59AF4mFpW7d9fNQlqp1P2DRO3vbz
2FFx+MKBq3g9mAJC/yrCmQ1QjiXTTT3VqNrdE5brjR+W1+yjBCIMEkwbcfJ9lqYg
TC6FF6bl3/HfDM7JsS6VxDjAPnUp8qOutcrx3HDvIMyYaSowxJLcdFuFeZoI6NYZ
U/EXXsRa670XiX41EMdQdoUGAPZKE1l782LlOf6tD/fO0pMo7NB2DvLzmuxUQVr4
ezQGYEcrHZgA2XkEEz3xB3oXDxJCG00hZmogLwvHRoQY6L1G8cOtJJEtJHxQyYg=
=2lok
-----END PGP SIGNATURE-----

--1GFpsN+DA+8qGtn4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
