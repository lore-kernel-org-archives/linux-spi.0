From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCHv2 9/9] spi: spidev: add Aardvark to device tree
 compatibility list
Date: Wed, 28 Jun 2017 19:54:45 +0100
Message-ID: <20170628185445.fsnqs2tlqqeqzl57@sirena.org.uk>
References: <1498578321-13980-1-git-send-email-amelie.delaunay@st.com>
 <1498578321-13980-10-git-send-email-amelie.delaunay@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rsfwamjmmxrfiyu3"
Cc: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>,
        Maxime Coquelin <mcoquelin.stm32-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Alexandre Torgue <alexandre.torgue-qxv4g6HH51o@public.gmane.org>,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Amelie Delaunay <amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1498578321-13980-10-git-send-email-amelie.delaunay-qxv4g6HH51o@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


--rsfwamjmmxrfiyu3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 27, 2017 at 05:45:21PM +0200, Amelie Delaunay wrote:
> This patch adds an entry for the TotalPhase Aardvark SPI Host Adapter,
> which can operate as an SPI Slave.

What does this device actually do and why is spidev a sensible fit for
it?

--rsfwamjmmxrfiyu3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT+3UACgkQJNaLcl1U
h9BU/Qf/UhIhQ1zK30aVgTdR4biW8ie5MNqXZLtRIJx/xyrZPeWhWbTbUIlnw+7F
bwXmRIvhD0uSG1k4i68XFOcVNfNcU26pWj+VOnV8Fw9Zp6g/7B8SU8Bi5k2tb53K
n12ORuccgWHRpjkKOdEMjX0VhHENIy9EhtIAPN5TiY+OaiockZTd1gmZKIV6fjOc
UhIpeA1imsu2EIE7q3rKMPwD5Q6DsQpkmlt1D1oItsHQMMc+F+UQVrBErHxBVv5I
sjHG3SGtIquKqzaP9ORzLGn7ETlKos03h3JvArecMWWOqnBGUNNTTOZncmo7SuZv
VM9XFvL5K/i/sSZdi1Q2sL6ZKzBYXA==
=Vhkz
-----END PGP SIGNATURE-----

--rsfwamjmmxrfiyu3--
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
