From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 6/8] spi: spi-geni-qcom: Add interconnect support
Date: Tue, 17 Mar 2020 13:06:16 +0000
Message-ID: <20200317130616.GE3971@sirena.org.uk>
References: <1584105134-13583-1-git-send-email-akashast@codeaurora.org>
 <1584105134-13583-7-git-send-email-akashast@codeaurora.org>
 <20200313131603.GG5528@sirena.org.uk>
 <aa197568-3bac-6962-d39d-3261f68c0514@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, agross-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org,
        mark.rutland-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
        linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, swboyd-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        mgautam-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org,
        dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org
To: Akash Asthana <akashast-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <aa197568-3bac-6962-d39d-3261f68c0514-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-spi.vger.kernel.org


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 17, 2020 at 03:05:21PM +0530, Akash Asthana wrote:

> We are taking care of actual throughput requirement in avg_bw vote and the
> intention of putting peak as twice of avg is to ensure that if high speed
> peripherals(ex:USB) removes their votes, we shouldn't see any latency issue
> because of other ICC client who don't vote for their BW requirement or
> *actual* BW requirement. Factor of 2 is chosen randomly. Please
> correct/improve me if this is not okay.

> If this is okay, I will centralize this design for SPI QUP, I2C and UART
> driver.

That seems reasonable to me, it was just the fact that every driver
seemed to be doing the same thing that I was noticing - what was being
done seemed OK.

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl5wy0cACgkQJNaLcl1U
h9Ae3QgAggJnWHS/CyykvzCHo7E8nPR1L9kx3kYVZpAuCtrYfxzrw9cs6+7l/K1G
CKM6uVeL3GtVc7wO+8Y3B6KSmyXcNYMZnHTk/skQlxv2i32r3gRIYxXbl1xqoZXn
8r//df86MC+eLCnCLLngJD57k4mHG6yP0+05zpZ28N8F0rSFbG5+hC303bojUM9i
/wi8QJBfXtABa4qZ1UpiAlUghsIIjLQDn+LYHFDALx1Ju/5XShsVHfIMaJuVeVQ4
vbfLjXl+GDyNSQ8Yxa7Thzojxjys+Wk1ZFChxJ7FPfhGEYWjAv/Q8k12R7D/oUl9
4srH0EJ6Y77GgPuPPEQpQYO6ecHiMg==
=e7Eb
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
