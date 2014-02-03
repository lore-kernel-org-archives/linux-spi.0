From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: rspi: fix build error when CONFIG_OF is not set
Date: Mon, 3 Feb 2014 15:17:21 +0000
Message-ID: <20140203151721.GA22609@sirena.org.uk>
References: <52EEF452.4060205@renesas.com>
 <alpine.DEB.2.02.1402030939520.25794@ayla.of.borg>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9989e9MCpLPr9Uiv"
Cc: "Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	SH-Linux <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Linux Kernel Development <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1402030939520.25794-97SZ98TBZzA1xEWliksxXw@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--9989e9MCpLPr9Uiv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 03, 2014 at 09:47:25AM +0100, Geert Uytterhoeven wrote:

> Thanks, obviously I missed that of_match_device() still uses the ID table
> parameter if CONFIG_OF=n :-(

> Below I have two alternative solutions:
>   1. Uses rspi_of_match() to nullify the ID table pointer, like is done in
>      the platform_driver structure,
>   2. Fixes it at the OF subsystem level, by nullifying the ID table pointer
>      inside of_match_device().

> If 2 is accepted, drivers don't have to care about this anymore.

I think if we can fix it at the subsystem level that's clearly nicer
since it means nothing else will run into the same issue.  Your patch
looks OK to me, I'd suggest submitting it.

--9989e9MCpLPr9Uiv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS77L+AAoJELSic+t+oim9zuoP/2cjnKAG84aAxFK/gcB7lzHd
iPdkAwcBIgGY8dDqxaMSVJVbRQflKHO2UXimmClAf1kmU4Xg386bWrNoPHuATdy3
5M07hQlzBnCeJkPWkizvr/0viJn3bW/HAv0eJPcVzWpHBpNSKq03U5C/WFtYS8VL
2nBAf/qYitKX73dT2AiD3DJETr2TgtAQkA1Zfvm0JC9pZa7Ayx/OpDvrLl3wH6zg
E4lmPVdhG14N/pYQ4EsnGLvQV3Y1wBwVvxei23yA5blgf5tu/vmHW5CS08lGNQJr
9RyFETv45blrQQyqg9fpxw98krahGAHEDrrrdfMi+jdMCq5L4/Mr0cAQx3kkMyNs
1C+CF/YLIakGD+WyAA2YJ+RcS0BjnP+JXjAaUR2YyasK9xs/8dW8RMto2p6mx2Ea
dfUA4nRT47KG9WDDvk9DDuzTqikuYXHQ+n+DbOM8HYq5pdVVssKIiGvl1ZMhDctW
CbH1LSZ/DllDa9YfCb+q+qxt8OAhBdHB5+eIj+wEwFKRWBw7ITA/NCCE6+a/pHvd
zmV46VkjEnCFXrvJNJjMcqYqOUtgPk6352H7t2EExoLExXXmNxncdNO8RB+yq5y1
Pv1ucKVSpYlAzIEroPsG5UjlU0hEHjTnWXeGX26vie75n0kaVjDRzf87pco0ZWIw
eE3CanuYUNvpzTKjp6yA
=GCNg
-----END PGP SIGNATURE-----

--9989e9MCpLPr9Uiv--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
