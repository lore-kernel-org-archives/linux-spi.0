From: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH v4] spi: add OpenCores tiny SPI driver
Date: Thu, 3 Feb 2011 12:03:53 +0100
Message-ID: <20110203110353.GC6508@pengutronix.de>
References: <1295925450-28550-1-git-send-email-thomas@wytron.com.tw>
 <1296729466-2936-1-git-send-email-thomas@wytron.com.tw>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0IvGJv3f9h+YhkrH"
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Grant Likely <grant.likely@secretlab.ca>,
	nios2-dev@sopc.et.ntust.edu.tw,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: Thomas Chou <thomas@wytron.com.tw>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1296729466-2936-1-git-send-email-thomas@wytron.com.tw>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--0IvGJv3f9h+YhkrH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2011 at 06:37:46PM +0800, Thomas Chou wrote:

> This patch adds support of OpenCores tiny SPI driver.

A few comments to probe().

> +	/* find and map our resources */
> +	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (res =3D=3D NULL) {
> +		dev_err(&pdev->dev, "Cannot get IORESOURCE_MEM\n");
> +		err =3D -ENOENT;
> +		goto err_no_iores;
> +	}
> +	hw->base =3D ioremap(res->start, (res->end - res->start) + 1);

No request_mem_region?
Maybe ioremap_nocache?
Please use the resource_size()-macro.

> +err_register:
> +	if (hw->irq >=3D 0)
> +		free_irq(hw->irq, hw);
> +err_no_irq:
> +	iounmap(hw->base);
> +err_no_iomap:
> +err_no_iores:
> +	spi_master_put(master);
> +err_no_mem:
> +err_no_dev:
> +	return err;

It may pay off to use managed devices (devm_*), so this part will become
very simple.

Regards,

   Wolfram

--=20
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--0IvGJv3f9h+YhkrH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk1Ki5kACgkQD27XaX1/VRsjWACgkGCZiZmnBP199dPrM7XlWFoT
OCcAoMPnjZqLyfKrpqzZONhCnyb4e6M4
=/8Wg
-----END PGP SIGNATURE-----

--0IvGJv3f9h+YhkrH--
