From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: pl022:  Add missing error check for devm_kzalloc
Date: Thu, 18 Sep 2014 11:14:36 -0700
Message-ID: <20140918181436.GF7960@sirena.org.uk>
References: <1411025267-773-1-git-send-email-kiran.padwal@smartplayin.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oMvEetrZIm2PFzDm"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kiran Padwal <kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1411025267-773-1-git-send-email-kiran.padwal-edOiRQu9Xnj5XLMNweQjbQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--oMvEetrZIm2PFzDm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 18, 2014 at 12:57:47PM +0530, Kiran Padwal wrote:
> Currently this driver is missing a check on the return value of devm_kzalloc,
> which would cause a NULL pointer dereference in a OOM situation.

Applied, thanks.

--oMvEetrZIm2PFzDm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUGyELAAoJECTWi3JdVIfQpqwH/32Q78L8lCwnvo45H8eiPt1Q
bJ5sU4Xn8FhtkT270GitYvl3mMV57eU8b1PuAHGRVTQordnJORwzPRlXjKmNNTz3
jvWsBUQSawdm2XirHEA9AS3S7jGqooryEEeA6cGB041pyeIQoL9f8FwXdT5XO0zL
W7zEh6/YROiX6dbHvdljkki8QjTMNAswyY8kdzM05SHQwh14T2t/XRT48x6Ltw9j
CodMLE+MiI3ekNjKlZm3Fcc+AQhsj5/OSi6dE2/oPT5XTJQi7dQxZnbetHCgeh6m
LtntYdcMHUZMJBGTASUq7wIrRQbe5VViRkgXl2G9aVkI0nxivwrTN++kY3IDs0c=
=zbTI
-----END PGP SIGNATURE-----

--oMvEetrZIm2PFzDm--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
