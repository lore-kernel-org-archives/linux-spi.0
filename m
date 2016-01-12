From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH RFC] spi: orion.c: Add direct write mode
Date: Tue, 12 Jan 2016 10:13:58 +0000
Message-ID: <20160112101358.GY6588@sirena.org.uk>
References: <1452589339-21402-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3wDDcJ525A5nbDoJ"
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>,
	Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
	Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
To: Stefan Roese <sr-ynQEQJNshbs@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1452589339-21402-1-git-send-email-sr-ynQEQJNshbs@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--3wDDcJ525A5nbDoJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 12, 2016 at 10:02:19AM +0100, Stefan Roese wrote:

> +- direct-addr : The phandle to the node containing the base address
> +                of the direct-mapped MBus window for this SPI device.

Why are we not just making the MBus window a normal resource on the SPI
controller and why do we need to use this only for a single device?  If
we can program which device is used then we can just reconfigure
whenever we change devices and use this optimisation for everything.

> +		spidev@1 {
> +			compatible = "spidev";
> +			direct-addr = <&spi0_cs1>;
> +			reg = <1>;
> +		};

This is broken, spidev should never appear in a DT (and the driver will
complain loudly if it does).  Describe the actual hardware.

> +	/* Use SPI direct write mode if such an address is provided via DT */
> +	orion_spi = spi_master_get_devdata(spi->master);
> +	direct_addr = orion_spi->slave_direct_addr[spi->chip_select];
> +	if (direct_addr && xfer->tx_buf) {
> +		/* Deassert CS between the SPI transfers */
> +		writel(0x00010000, spi_reg(orion_spi,
> +					   SPI_DIRECT_WRITE_CONFIG_REG));

This is badly broken, we should be asserting /CS over the entire message
unless the individual transfer says otherwise.  I'm surprised this
works.

> +		/*
> +		 * Send the tx-data to the SPI device via the direct mapped
> +		 * address window
> +		 */
> +		memcpy(direct_addr, xfer->tx_buf, count);

What if we are transferring more data than the window mapped in
direct_addr and what if the transfer is bidirectional?  It looks like we
can only do this for transmit only transfers.

--3wDDcJ525A5nbDoJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWlNHlAAoJECTWi3JdVIfQCpsH/jZ3z8U4+A00pn2s8IJmIm/y
1hokJmVzjET0qjReeS0fzzq3ikIeoFZLJQXjaHmaK0ONhguhSGIGDgrVoth0cBYR
mCoXxCSI2bPH1Il7V/J3Iv4uEyLF5e6lfHdpd/0KNfnDos5skfThbXkuZUnIKBal
0Y3Zq8lwGiE1oFNOX4lMGBTdnfokrL4QkqVvtmxVWyoM5C1lYlkdbul0f/qKjY1Z
7lCpUQTOo0sjhdEAHdBvX9NK3AKUkCpCYUt7lWHvhtl17I25uWfNZ/UOy3KTLJaW
Q0u06r2B5cpPelrynVtdZPXjiAeAWZs9pbzhW3EpKujmJ/HJO5DP0FBftqZwtOo=
=W23W
-----END PGP SIGNATURE-----

--3wDDcJ525A5nbDoJ--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
