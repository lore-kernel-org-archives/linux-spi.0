From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v5 8/8] spi: nsp-qspi: Add Broadcom NSP, NS2, Cygnus SoC
 support
Date: Tue, 16 Aug 2016 19:40:30 +0100
Message-ID: <20160816184030.GB9347@sirena.org.uk>
References: <1469830393-13295-1-git-send-email-kdasu.kdev@gmail.com>
 <1469830393-13295-9-git-send-email-kdasu.kdev@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dWDJ72qfEa57oDWE"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	vigneshr-l0cyMroinI0@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org,
	bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, vikram.prakash-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	andy.fung-dY08KVG/lbpWk0Htik3J/w@public.gmane.org, jon.mason-dY08KVG/lbpWk0Htik3J/w@public.gmane.org,
	jchandra-dY08KVG/lbpWk0Htik3J/w@public.gmane.org
To: Kamal Dasu <kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1469830393-13295-9-git-send-email-kdasu.kdev-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--dWDJ72qfEa57oDWE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jul 29, 2016 at 06:13:13PM -0400, Kamal Dasu wrote:

> -		irq = platform_get_irq_byname(pdev, name);
> +		if (soc && qspi_irq_tab[val].irq_source == MUXED_L1) {
> +			/* all mspi, bspi intrs muxed to one L1 intr */
> +			irq = platform_get_irq(pdev, 0);
> +			of_property_read_string(dev->of_node,
> +						"interrupt-names",
> +						&name);
> +		}

I am confused why we are parsing the interrupt-names property here?

> +	/*
> +	 * Some SoCs integrate spi controller (e.g., its interrupt bits)
> +	 * in specific ways
> +	 */
> +	if (soc) {
> +		qspi->soc = soc;
> +		soc->bcm_qspi_int_set(soc, MSPI_DONE, true);
> +	} else {
> +		qspi->soc = NULL;
> +	}

The variable name "soc" here doesn't seem hugely descriptive when it's
just for the interrupt controller.

--dWDJ72qfEa57oDWE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXs14cAAoJECTWi3JdVIfQkvgH/2wU7JcMsOOSEDDIujt9dxW1
Mt5c5K0rpzMG7Q1IXKTqBdGRpq4i1ocmxqgbblp3YEjDLRrygwe5gqXHnxdGtpSj
byNmPopxss8+q+0Sd3MCfOsJD8TTMfRpUrC/rhL05pfr256omQvfKxj/VXYBBIn9
17kjxqlZkCBP2LPQ7bhYNzay0tUpi1a8JxWuV1FxKSSOOFovNdH87wRfrAYvNZOl
CVjur9GEl5a1403lO2F1o0EN2vRwQi7vKXw5qPcTK4/3cg/QuAfBEXspDsmAWIPB
A2FENTootM4StSBno1Jj03DYFl+APv3i7ahQWzFubnz7QY+lDmMC3uqj840BH6A=
=SOBc
-----END PGP SIGNATURE-----

--dWDJ72qfEa57oDWE--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
