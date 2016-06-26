From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] spi: spidev: fix the check for spidev in dt
Date: Sun, 26 Jun 2016 02:09:09 +0100
Message-ID: <20160626010909.GD28202@sirena.org.uk>
References: <cover.1466696079.git.hramrach@gmail.com>
 <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tauoZ0QFNrdllat7"
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Andrey Ryabinin <aryabinin@virtuozzo.com>,
	Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Adrien Schildknecht <adrien+dev@schischi.me>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
To: Michal Suchanek <hramrach@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8b66102e44829c5dc445c17f7bfad1050840b9f0.1466696079.git.hramrach@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--tauoZ0QFNrdllat7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 24, 2016 at 04:20:32PM +0200, Michal Suchanek wrote:

> The check is supposed to warn about spidev specified directly in
> devicetree as compatible. This just does not work. I have a devicetree
> with no compatible whatsoever and hacked my kernel so I can manually
> bind spidev. This still triggers.

This is the third copy of this I've got in two days, please calm down.

--tauoZ0QFNrdllat7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXbys0AAoJECTWi3JdVIfQF9EH/0UwUhX9kLkaNMd3Tj6mkq9f
WlqW1krFAqPCrF1qdQglRYFGOEgabj/x0WhI4K4Wrp6h/k49uKauE5/A2tT5XVSM
GNMm73R5wuP82EL1AhcaGe09IMSdMW3/POtPnneUzrYRLqN4aYubRP0Tdbv9ouxm
kE2CxU+bfgj1Pa6o02hgTiKXBV3vV5isK+Uu2mZy04DwcP3C3FA/czZhGzd/JUh9
GtFTOT8Gwkq9R9zJDEaV1nwCqT8jUBZrDlkjy9yx+mmhxAOmV3hcMFDcXJhDB6BM
wQRcQANvXq2wWkdq83/deGPJM/3JjTInaQOCsmwlzsX34MIsew0I2UIWxWsADJw=
=qiGS
-----END PGP SIGNATURE-----

--tauoZ0QFNrdllat7--
