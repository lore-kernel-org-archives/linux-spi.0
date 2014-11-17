From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V3 0/2] spi: IMG SPFI driver
Date: Mon, 17 Nov 2014 13:31:04 +0000
Message-ID: <20141117133104.GY2722@sirena.org.uk>
References: <1415990912-31744-1-git-send-email-abrestic@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xd9y+pRso0hzCdjI"
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	James Hartley <James.Hartley@imgtec.com>,
	Ezequiel Garcia <Ezequiel.Garcia@imgtec.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org
To: Andrew Bresticker <abrestic@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415990912-31744-1-git-send-email-abrestic@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--xd9y+pRso0hzCdjI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 14, 2014 at 10:48:30AM -0800, Andrew Bresticker wrote:
> This series adds support for the Sychronous Peripheral Flash Interface
> master found on IMG SoCs.  The controller supports up to 5 chip-select
> lines and single, dual, and optionally quad, mode transfers.

Applied, thanks.

--xd9y+pRso0hzCdjI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUafiRAAoJECTWi3JdVIfQeVoH/RmOoL4pofcM7yOMVU3mlwi1
XwF6zz6DHx2LyUX+K2bU/J97wx8qIFToWU9JAnkH7zk31IxRQ/K/2JimsTVsJImG
ENvbOMupJ9tDh9H8MxNBK+QU2ZuLdV1OKog/7yWjHyUxvZGSZgv0lWnZvlzPsuYG
mP+5jD98SLRDF6YMwN23ttBcfUKrKz6P9dGprB2rN4ti2HbrxjPF5gATUs3xQNcS
QZQCXYr2t3uPZcqp72dtpjlahPyVw/KDPzmz6I4IUVVNlVdD6DJBUppCp0G3oX77
dVxOdN4ILowW1cX6+dZfVzEtx4YEkdS8RoYs/SH7Z+rq+VKzee2Ad6dKDQh4HLE=
=Vulf
-----END PGP SIGNATURE-----

--xd9y+pRso0hzCdjI--
