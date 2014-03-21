From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-lib: Fix memory leak of pinfo
Date: Fri, 21 Mar 2014 18:12:15 +0000
Message-ID: <20140321181215.GN552@sirena.org.uk>
References: <1395307217.9142.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BtmVPk+Smchi6n7w"
Cc: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>, Andreas Larsson <andreas-FkzTOoA/JUlBDgjK7y7TUQ@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395307217.9142.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BtmVPk+Smchi6n7w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 20, 2014 at 05:20:17PM +0800, Axel Lin wrote:
> of_mpc8xxx_spi_probe() allocates memory for pinfo but the memory is not freed
> anywhere. of_mpc8xxx_spi_probe() is called in .probe() and pinfo should be
> freed in .remove(), so convert kzalloc to devm_kzalloc to fix the memory leak.

Applied, thanks.

--BtmVPk+Smchi6n7w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLID7AAoJELSic+t+oim9wlwP/26QTx4mMuOlS0KgCKboAsmM
mr+gh/w6yxkAw85eN4M9mthIvBfSufNVa3W9rbbKf14ikWewNRCBbIE9mg8SGoan
AfyWXvPuYSjqvs46h6i+px1DBe7gFrS1hb4E3Io5jCmJx623qn4h6T53WaQA02Su
ixc76xric7oiFa75JbYqLNdUKtzP4FjOxR3/T748vjmQpZJnZAlzexyE5xnP6gY0
c31CAxwQcz5itmWLa81fg0MPUsEuuv4t0kQGCQd71uqEgoEwTV5OY61UXZ6HpYoq
02TRiE2IJBFiBhEErhiDa5ineY98LpUEpa9x9rBz+Ipwec6A52tNFjPrlHh8hyQG
/Jyn26ZQC+U9iBhgfa0BKJThOa+Nr5S7e7T5IO6C1t1Nnog5rMbJE1rGcvnvFqq2
EWOqsk8dNkJA+PkWH1eW5lkRzz5pRq48jqSdfJk0kBHPGw0azxZOhuSfZFDW49nA
ZGbgezSqoTVxIwhykML/gL+UDzAdyAvbLO/iZqm6FCgZvz2SD5nT7MfY+ZkAbZDj
boP0+1RlGx4FOebrEP2WjL2lGnMYnlrWdVcycOOCgYVCOA1pSN+lae6vlCb9RSqs
kppoaVJRacaO6ZE7T2NaIBYvEgBhhnRO/puRFp3yaVK/l0FGICNFrWB5kIBkmLAo
yVH4H3qYqQXxrK6ckMb0
=q4M/
-----END PGP SIGNATURE-----

--BtmVPk+Smchi6n7w--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
