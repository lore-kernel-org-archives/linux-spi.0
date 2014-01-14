From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH/RFC] spi: core: Fix logic mismatch in spi_master.set_cs()
Date: Tue, 14 Jan 2014 12:52:42 +0000
Message-ID: <20140114125242.GE15567@sirena.org.uk>
References: <1389699411-29135-1-git-send-email-geert@linux-m68k.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6Vw0j8UKbyX0bfpA"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Geert Uytterhoeven <geert+renesas-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1389699411-29135-1-git-send-email-geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--6Vw0j8UKbyX0bfpA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 14, 2014 at 12:36:51PM +0100, Geert Uytterhoeven wrote:

>  {
> -	if (spi->mode & SPI_CS_HIGH)
> -		enable = !enable;
> -
> -	if (spi->cs_gpio >= 0)
> +	if (spi->cs_gpio >= 0) {
> +		if (spi->mode & SPI_CS_HIGH)
> +			enable = !enable;
>  		gpio_set_value(spi->cs_gpio, !enable);
> -	else if (spi->master->set_cs)
> -		spi->master->set_cs(spi, !enable);
> +	} else if (spi->master->set_cs)
> +		spi->master->set_cs(spi, enable);
>  }

Coding style, braces on all branches of an if statement.

This also pushes the handling of CS_HIGH back out into the driver which
doesn't seem like it's helping anything.  Flipping the sense of enable
when calling set_cs() is probably OK though.

--6Vw0j8UKbyX0bfpA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS1TMXAAoJELSic+t+oim9NTYP/3IwaIOyPWY4GSq4BswuyZWI
o1qVhf72gNin4DQlnV67WRYRGIFL9Z+CTwXZaag+NWFw8tDmeZyfVUBjEpgxM6I+
9U2h1VmXvblCWMlw02kbTesyszFKqsllfOQCwlE0t6gZ8IklYlEmJnnK50bhRvqv
DCDtkgwmSCwiPEtEX/izUoDyMXYrCCSTlT6lt+ddvwmTJ7qo5438JW7U3b2v1N1J
hB/mX/2nJugEX9A2z4vOYMRZDit48l5DD0iNgZIM9A6HycqRA0aOdM7yAdb467IH
Ht6w0LXGA40KONRXaaMhn3C3Exts4XCviMZnE/HahW8UjpS/l2gOftjUqQkVv01S
un6+K7q5Ng8mi99wesCz3M6bYlFXGgS+NKQDHcCA9URYoI526cjZh70tKEgwZYLB
meaNKmicaoL+a2HPgUQORWKHCZtWKHLELUd/7art09k71RKZ7phaMqTP74qifAu1
c+Yn3rt+9TvZax7h5CkayDjtzBZ3syZvvtBcix+P9kBJ0Ksu+S8vCtVL1MqL344a
wUpDH/ZjsOXPzBOFhSiY/s+RnLGC+yGF17a+uhvU4rGW0S0KH5cRmHYWU7y/aai+
Gv9ibMX+YB4DQHDZydTyOq3k93qcrw7ePsrY1O5/SZcoqvxiwgSJOgeJvjm5pemU
VGXhNyBSnzf91PPNkN1h
=KfTb
-----END PGP SIGNATURE-----

--6Vw0j8UKbyX0bfpA--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
