From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi: fsl-dspi: Fix getting correct address for master
Date: Wed, 5 Mar 2014 11:49:34 +0800
Message-ID: <20140305034934.GA13126@sirena.org.uk>
References: <1392353352.19487.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wRyyN4gAPkNkeCwp"
Cc: Chao Fu <B44548-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Alison Wang <b18965-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1392353352.19487.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--wRyyN4gAPkNkeCwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 14, 2014 at 12:49:12PM +0800, Axel Lin wrote:
> Current code set platform drvdata to dspi. However, the code in dspi_suspend()
> and dspi_resume() assumes the drvdata is the address of master.
> Fix it by setting platform drvdata to master.

Applied, thanks.

--wRyyN4gAPkNkeCwp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTFp7LAAoJELSic+t+oim9aUsP/A9U48WoGtXnry4CO9Ce8Jet
5iUe6zYHD8l3vG5S8QJt6+MTfvNtSz6u9A3rZBWYOKLcYqtuGMNIogwZgTC7GNow
+QmoEKm30CR7NBpyy11YDA7cORq2X711WwViYJzGyHV4LZW3VMENxl9HR7YDYMCa
f7VOv/RECXT2rYSOGWMncxIxAOKCpKouNTbwp3qc9iO2WK0jPRT5UsWDYkVy0vdv
z49g+R/81y7yr35KQdm1M9NQlkf4HT1UbuJZfoLpYwl1R2zsV4od/BzAKfqFDGwO
kEeFdmDD4XWWkcNb8xudp3YseEgt3LaZ/eXBODZVA8d8DXALvGseaSnaNEAJhjnB
tYhx48KS7sXUIIidZ+EC6Y3UFHz1kzBunulLaECP4c+yQ3ohhl5yKzx/KJcS7rVD
HYlYt+RPa4zxIjIW1loxzhrSQIWAYZ1P6VPHkR9j2NAXpa/qv0Iovdt95Re2crao
OvGkWGq8UvHwVvQ50ezl98oLyxeXXPSxb2EsVJYCiyB41mZ8/yZ71L5vA7IEioUx
15J6oEFrq/phhFePV8RGWp+P4wVXYQnjFi74dzqVHwKYh/IqEEyiX3EGa5/zeqbZ
v+FEznb7OpOzLIgOWXE0WrpGHuaE13csJSZ/n8jpY26ZMiKilIgs4ymjSBkW5DdF
8eyi0MVnc4C4qtFqI3zJ
=Eu0d
-----END PGP SIGNATURE-----

--wRyyN4gAPkNkeCwp--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
