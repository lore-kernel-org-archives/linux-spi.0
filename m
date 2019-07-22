From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/4][V3] spi: Add optional stall delay between cs_change
 transfers
Date: Mon, 22 Jul 2019 17:32:02 +0100
Message-ID: <20190722163202.GG4756@sirena.org.uk>
References: <20190722124747.4792-1-alexandru.ardelean@analog.com>
 <20190722124747.4792-2-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="B8ONY/mu/bqBak9m"
Cc: linux-iio@vger.kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        jic23@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        Michael Hennerich <michael.hennerich@analog.com>
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190722124747.4792-2-alexandru.ardelean@analog.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--B8ONY/mu/bqBak9m
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 22, 2019 at 03:47:44PM +0300, Alexandru Ardelean wrote:
> Some devices like the ADIS16460 IMU require a longer period between
> transfers, i.e. between when the CS is de-asserted and re-asserted. The
> default value of 10us is not enough. This change makes the delay
> configurable for when the next CS change goes active, allowing the default
> to remain 10us is case it is unspecified.

For the third time:

| This looks like cs_change_delay.

>  #define	SPI_NBITS_QUAD		0x04 /* 4bits transfer */
>  	u8		bits_per_word;
>  	u8		word_delay_usecs;
> +	u8		cs_change_delay;
>  	u16		delay_usecs;
>  	u32		speed_hz;
>  	u16		word_delay;

This patch doesn't apply and even if it did it won't compile because you
are trying to add a field with the same name as an existing one.

--B8ONY/mu/bqBak9m
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl015QIACgkQJNaLcl1U
h9D5fwf/Wo4+Hmy98fxnDeg7DpbiGSC8Ran91cmRVruDQ85ReTVXSyjGLF7QuDPU
h5eXuOE2jwzrDrqVmX1CK8kXQCF5k9I9SiLWZZlPBxVAFGQmOBufa2voUWHN3zr7
lhESGw8Ayl7JzHYF6KRvtGSIFq5vJ2fhLLFH+lDZ0ewq7A92U99OqyjaZD0gZCo7
Nb3YJ2wASgP37haiibEHvpddA585QtGgcCjqdxybeoIxAqkez/2RTijc3DBRcXeb
VsseUyF20RRXnICBpBgUnonhzzwN7jwf1VIOM4aKGiWIIXGRqiKO3OD9akqXodSG
owJ6FsifVUS4oEXPHb76eFpu1x5A0g==
=+XeL
-----END PGP SIGNATURE-----

--B8ONY/mu/bqBak9m--
