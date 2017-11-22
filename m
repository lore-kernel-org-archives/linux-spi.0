From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: xilinx: Detect stall with Unknown commands
Date: Wed, 22 Nov 2017 11:12:15 +0000
Message-ID: <20171122111215.2isnpg3nfry3g3ll@sirena.org.uk>
References: <20171121090904.6901-1-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5wn762khz4ldrwo4"
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
To: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171121090904.6901-1-ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--5wn762khz4ldrwo4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 21, 2017 at 10:09:02AM +0100, Ricardo Ribalda Delgado wrote:

> +		stalled = 10;
>  		while (rx_words) {
> +			if (rx_words == n_words && !(stalled--) &&
> +			    !(sr & XSPI_SR_TX_EMPTY_MASK) &&
> +			    (sr & XSPI_SR_RX_EMPTY_MASK)) {

10 seems like a small number for what is essentially just a busy spin -
are we sure that we won't reasonably hit a case where the CPU is
sufficiently fast and the bus sufficiently slow we falsely detect a
stall?  Where did this number come from?

--5wn762khz4ldrwo4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloVW48ACgkQJNaLcl1U
h9Am4Qf6AhlTlLR7tDHFym38VfWsFWOPRRxzv0aZpmMuaf4izrjHWtazjtLBGkuL
R7Mi8goigOenbltVGceNEeCk19amTg9cyySRTYaepE9neUnyU4VuHk5p0P+6TJ9E
A0U8jJ7y3cgsQdYEGqXBh2o89722VKoc+lgTeoR0WleokV52jSrlMKryntqNnmlX
TNi+Tf7C6o18dHMXQTRDQOme+qKMK83nMIppW8GD+/i3bwiGsm7wo5VFayM7BCtG
DPnHBn/3T7pxNJ5b/oiB2tWyjRxPvEQ+L0lUd7374pSDtNvSliUk7PvwTKo5jmCZ
CjouUHyH/4Qhl1LgJeTt7644XxzMNw==
=fJfb
-----END PGP SIGNATURE-----

--5wn762khz4ldrwo4--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
