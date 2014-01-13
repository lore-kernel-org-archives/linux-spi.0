From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 3/8] spi: rspi: Add support for more than one interrupt
Date: Mon, 13 Jan 2014 12:16:41 +0000
Message-ID: <20140113121641.GP29039@sirena.org.uk>
References: <1389522464-1569-1-git-send-email-geert@linux-m68k.org>
 <1389522464-1569-4-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BfIB/hDtUWEgpOfz"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389522464-1569-4-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--BfIB/hDtUWEgpOfz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jan 12, 2014 at 11:27:39AM +0100, Geert Uytterhoeven wrote:

> +	for (i = 0; i < MAX_NUM_IRQ; i++) {
> +		irq = platform_get_irq(pdev, i);
> +		if (irq < 0) {
> +			if (rspi->num_irqs)
> +				break;
> +			dev_err(&pdev->dev, "platform_get_irq error\n");
> +			ret = -ENODEV;
> +			goto error1;
> +		}
> +		ret = devm_request_irq(&pdev->dev, irq, rspi_irq, 0,
> +				       dev_name(&pdev->dev), rspi);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "request_irq %d error\n", irq);
> +			goto error1;
> +		}
> +		rspi->irqs[i] = irq;
> +		rspi->num_irqs++;
>  	}

This should really have some way of identifying which interrupt is which
either through defines in the header or by using _get_irq_byname() (the
latter is a bit neater) - even if the driver can get away with treating
all interrupts interchangably now it would seem very surprising if they
were totally interchangible so the driver might get support for treating
them separately in the future (or some new IP revision might add another
interrupt type for that matter).

Some blank lines (for example between get and request) would be good
too.

--BfIB/hDtUWEgpOfz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS09kmAAoJELSic+t+oim9oX0P+wSvUdqbyLpv67D7PNMY2iPE
9g4PdxskijM7QfhgJ6kxYqlqZj/RQHyMvh1b0vW3Pa0zjEWN2bIxg76MUjHaExAY
Op6XA5Nf7XUwTz0q+PUMb6VWJ4KVvXLYswUMz4ExA9zbYOTaIrp+yZfgsdd4bfvn
IP0pVOuE1nBCdn/Wx/cEzLvObKd86sm65kQ2QdBnuFaloSSg2ptUf+f2LrSq5cOM
kM1L+s/OEAqcFVmfiaDGMa5toD7g4/uQAg+07pYjMwYfBj1TlkvDJhXhPA1Aip+B
8/xrjBiubPMt/29XYUjLkFdeFBCBsYPoB1pbF1y9j+qbM+TMcMUeXmaXi0O+HELJ
oIqD3JobhmZZ8ss/w2NqG63I1nsLOv2EMuSdvPOw5w+Lid9gNyXIe54TJ7QFRLSq
6O2tynqpdTiVFOWOmmTzmXR+XF6D3t0U9l8mRdZliXLrd+1GGIa8PvA3rYN/G4Eh
OjVCDUpq9Yy1NoENtdw14xzBwGKqrApIhRE3huykUl8XO0TGTqzdU+UG8K+d9uUo
97v0ibeByqYl0qTfLTkKhssrPu+sw2kuOG6fcHfDPGgAkHHMsnqiQ/ESwmjRaJCv
A+UokgBUsrFqgzi6FEb8GWqS2C+TUZAsKJGSvJcqIuTM14ADeCWixvBWsB0cckCi
O7iB8RZ6n7BxNRZct5Ub
=lEGM
-----END PGP SIGNATURE-----

--BfIB/hDtUWEgpOfz--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
