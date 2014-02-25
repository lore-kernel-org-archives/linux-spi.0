From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFT] spi: qup: Get rid of using struct spi_qup_device
Date: Wed, 26 Feb 2014 08:55:14 +0900
Message-ID: <20140225235514.GI2927@sirena.org.uk>
References: <1393254456.12394.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nEsDIrWrg+hrB7l1"
Cc: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1393254456.12394.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--nEsDIrWrg+hrB7l1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 24, 2014 at 11:07:36PM +0800, Axel Lin wrote:
> Current code uses struct spi_qup_device to store spi->mode and spi->chip_select
> settings. We can get these settings in spi_qup_transfer_one and spi_qup_set_cs
> without using struct spi_qup_device. Refactor the code a bit to remove
> spi_qup_setup(), spi_qup_cleanup(), and struct spi_qup_device.

Applied, thanks.

--nEsDIrWrg+hrB7l1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTDS1fAAoJELSic+t+oim9FPwP/jKks8xTn0NwjSITG42zfelo
x0QYrJxJ8z06JNPurqa31GNUKtNv2RDNSzpJVmYhomqspci+PxyCpGXOBzADZGrf
BL6Dvxl3fl3gsuZKLsJJA/vMORz3E3CoS972VUdDAOdIW+mdkbC1eQdjXhw13oEO
Xjuor8VtNtwd/F2ox4zfeXCJ0nRz50g6PyFUl1EbRWSxUDhFoDQR+ePkWzj8uKH0
l1pdmPDo4I5Gm4dqbiVlpjcXqyngFPiikLDFQJ/d4/ZK8JBaX1PrEaL/RIpHsXl1
ZrRbj2Zv1jUr7r2MvxSrWX4ne7ueTqDRkkcY5OFiNR+SUnjcxIWZKMnHe0T4b9vU
aQaUwlQQlzJ+6Uwk3T3vANPt98V7OG1iX8wTkEpvgRzIcHOHYEwf5AhwM/IicC3M
LnXuzKC7tSyX7iMkArwaqLP1agpE+XaEiZMoOGiJ37KUJ8qJ1oKU3Lwv8ikwJOvt
J32cXocC2tvdis9KhkhbFhF0HsQxtLVZr7Ug5EgXuXGcmkjo+h2xTy7FeKbHuHUc
okDUaw8hcDDhvRdOz3M99cpl3a7bflovO10NUq7pgo1iMIhQLvYkuuKWQ9VtI67d
jPT0Itf7wwwxtRiRizO9iFzsGDPecXE/ElG5uvFzPQ8wlFjmDqfXW5bqmOun8jO4
aZMkcVPiNYvJI9rk0olM
=CMpH
-----END PGP SIGNATURE-----

--nEsDIrWrg+hrB7l1--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
