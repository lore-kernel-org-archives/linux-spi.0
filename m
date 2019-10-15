From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 04/19] spi: sprd: convert transfer word delay to
 spi_delay struct
Date: Tue, 15 Oct 2019 12:11:26 +0100
Message-ID: <20191015111126.GA4030@sirena.co.uk>
References: <20190926105147.7839-1-alexandru.ardelean@analog.com>
 <20190926105147.7839-5-alexandru.ardelean@analog.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7783444321353056408=="
Cc: f.fainelli@gmail.com, baolin.wang@linaro.org, linux-iio@vger.kernel.org,
 zhang.lyra@gmail.com, linus.walleij@linaro.org, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 jic23@kernel.org, linux-tegra@vger.kernel.org, orsonzhai@gmail.com,
 linux-arm-kernel@lists.infradead.org
To: Alexandru Ardelean <alexandru.ardelean@analog.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190926105147.7839-5-alexandru.ardelean@analog.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============7783444321353056408==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 26, 2019 at 01:51:32PM +0300, Alexandru Ardelean wrote:
> The Spreadtrum SPI driver is the only user of the `word_delay` field in
> the `spi_transfer` struct.

This doesn't apply against current code, please check and resend.

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl2lqV0ACgkQJNaLcl1U
h9CHiQf9GnqkNc3cR7NIFRHuaNNvuhYAgTsUs8m4UlwI7cQ/XcISc7kD1fUMD3tu
By1lFV/xCEANfVBa8wDijwRyvK5RMcTXYFuPZAetNPoRb006+se0MZbPeukeTjlw
JSA7tlI9mnu5p+5lXHQxIIigZnVdcgCqujQ3AG3lPW3YUHt8BIrVJqPGNkvhBDkF
YLjLMMUvSJpskjMq9OLBCtKhevA7ZHMdvfuxJ22h5BQPsNZWZxZJv7QAMdhXA7VI
nkJjcxeyvBY0GzAz5vi3SJGlLFDAec1qvF16d7mOre/0bWCRTNML0gyIt0wNiwZs
80Dr9YLhjDBQmNejzh3MvVO6sStBxQ==
=wgwp
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--


--===============7783444321353056408==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============7783444321353056408==--
