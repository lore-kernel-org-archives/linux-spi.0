From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: qup: provide proper bus numbers
Date: Thu, 21 Jan 2016 18:38:10 +0000
Message-ID: <20160121183810.GN6588@sirena.org.uk>
References: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IcjWnDSMZlCA27rX"
Cc: Andy Gross <andy.gross@linaro.org>, linux-spi@vger.kernel.org,
	David Brown <david.brown@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453401227-27135-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--IcjWnDSMZlCA27rX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 21, 2016 at 06:33:47PM +0000, Srinivas Kandagatla wrote:

> This driver reuses pdev->id for spi bus numbers resulting in random
> or very large bus numbering when used with device trees. pdev->id
> is not the correct choice when using device trees. So add code to

What makes you say this, why is pdev->id not "correct"?  It is worrying
if anything cares what number we pick.

> get bus numbers via device tree aliases and if it fails then generate
> a unique bus number.

The other question is even if this is a good idea why is it something
that should be open coded in individual drivers, if we want to change
the policy we should be consistent between drivers.

--IcjWnDSMZlCA27rX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWoSWRAAoJECTWi3JdVIfQ44EH/AvmlJeCVJZwBj7GR7SozV20
FomO/xIbe3PwzCaNcxSrfl0aNNxdHFyJLG6xjLbcbESP+id+XgeXi0uWecVtJAIq
EjOwbA3MYZM+RSd4rONh7407qFyXn2jsBWyk/yc5G/xtrUkEQEcXqk47cR2A0xbj
DtY3pYeQe5Z40zV9w1CxaS5y6BDYEKBnGQHd8OvuRTwTukOUVsKMoADnEvtGkxFo
JkyJaoPKeuthVzx0U9pweOLzysTb+ZzA4iTCBpXouOhx956ZzxKySX4BZEDibQWr
iLDjey0VsERg3iuR/1f6OpAbuNjJB4pLcKyQ83Pcca2+yhE9zjtaGHE9dU0hEBM=
=w23G
-----END PGP SIGNATURE-----

--IcjWnDSMZlCA27rX--
