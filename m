From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] dt-bindings: spi: Fix the number of CS lines documented
 as an example
Date: Tue, 20 Aug 2019 13:05:47 +0100
Message-ID: <20190820120547.GA4738@sirena.co.uk>
References: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="uAKRQypu60I7Lcqm"
Cc: robh+dt@kernel.org, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190820115000.32041-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 20, 2019 at 05:20:00PM +0530, Manivannan Sadhasivam wrote:
> The number of CS lines is mentioned as 2 in the spi-controller binding
> but however in the example, 4 cs-gpios are used. Hence fix that to
> mention 4.

Please use subject lines matching the style for the subsystem.  This
makes it easier for people to identify relevant patches.

--uAKRQypu60I7Lcqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1b4hgACgkQJNaLcl1U
h9CaTAf+NDDtCxFNPDyqiudCbpGsmAOBaem3UqwpTZRbK9vy7b0ePoD9WJKWG+2O
1VxpcQp243Ardj1r8k9gZPYeWpolHmFen00GoakMDJiP7HLfjUIj/qReHkvbY23k
6f0+DWwWlW6dNYOTzunzeqihVNB8Ca+IRADgp6S89o9fMD/2KbIAsNrSKOJwuhAG
qtELaiaIKSFFbibjD1kLAjhcvcSZ6kYeF6sA6dNXvgvH9VgAuoWxcJTR092lPPDd
3f1T/MKZQyo3yal/0WJ9O5rKdUe7HAinhnc8ptUm11hvog21k+sWQkMFgELcJ3Ci
tVI+DaUHu+fv61YcaPMmvHPb8hITEA==
=qfh+
-----END PGP SIGNATURE-----

--uAKRQypu60I7Lcqm--
