From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: dw-pci: fix bug when regs left uninitialized
Date: Wed, 27 Aug 2014 15:46:08 +0100
Message-ID: <20140827144608.GE17528@sirena.org.uk>
References: <1409145672-10258-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x2HIghygH2WQ7WnY"
Cc: Baruch Siach <baruch@tkos.co.il>, linux-spi@vger.kernel.org,
	stable@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1409145672-10258-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: stable-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--x2HIghygH2WQ7WnY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 27, 2014 at 04:21:12PM +0300, Andy Shevchenko wrote:
> The commit 04f421e7 "spi: dw: use managed resources" changes drivers to use
> managed functions, but seems wasn't properly tested in PCI case. The regs field
> of struct dw_spi left uninitialized. Thus, kernel crashes when tries to access
> to the SPI controller registers. This patch fixes the issue.

Applied.  Please use the Fixes: tag and use a minimum of 12 characters
for the commit ID (to avoid collisions).

--x2HIghygH2WQ7WnY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJT/e8sAAoJELSic+t+oim9dBgP/2pKZ1VUKbDmO6b2SVsCtxTg
UnECUHiXgVOhPIitHvEbvcHjq9Mk4u9Rcm2rvpJ8FzrauuoIY5M1x/xP2YBhSbgo
D/ALZGwm7yvPHx/XLxFPpIUodbCq2gnJ0iHTJRu4ZGyq9C6KNa/gfvunt0P5g18z
/8Fku+Tw9tkzJL5Ts1LTTLqom/ADC0bCNAF5h+mQ/cTT8t2qd42iy85Z6D0QXtXn
S5+xmYjTAAeiEXn9pkVxLxoWbL7HpX/xevGErzyATZvtDahKVDhAbn4a8lrQ5iJo
NhMTjWITbF6r1x/KmzdJxqRwqn/YGLFCBAkI6brU+rIhE68veT4L+d/ey17wcmAK
ULQUEtxHP7Ka1+R8G2OmX44sjWoJan6vpUmqzAM7bEceP7E7hBf9K1rHLRj9Xl5t
ypmPs1aZtjftP0K9UqRGJsS607pCrtymLV4FEl+PW991RrP4KWBDZwLwSwAOy6SD
U/0YnokKrJQ+jEUwCd2//RLpOk/HcJBK0Fjiy2zQclFAugfQL6dTqEQk+aIw4A2k
ROHdkP7aD7jZr6B5rOh/ZFPL1/aXyzuU+wk9nvtWE71rN3g1rXuC/vfaKNvZCTwF
ICIqQYOGlE2J4p6E8Fyl6czfKYq3C49dfnuWdgF0fXn0+22+oI9F9mk/sInZk//Z
yksSkMDFtCMAeXJIprSh
=l3iL
-----END PGP SIGNATURE-----

--x2HIghygH2WQ7WnY--
