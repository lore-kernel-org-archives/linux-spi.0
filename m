From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/4] spi/xilinx: Clean ioremap calling
Date: Mon, 8 Jul 2013 15:50:02 +0100
Message-ID: <20130708145002.GI27646@sirena.org.uk>
References: <ff70173bee5f9223ffea2b92b903b4e46ef8b323.1373290150.git.michal.simek@xilinx.com>
 <cc1bf277180140e94abaac7d3a8c2d6a723f7ad2.1373290150.git.michal.simek@xilinx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6LJmZOW/XGr4HvhC"
Cc: linux-kernel@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
	linux-spi <linux-spi@vger.kernel.org>,
	Grant Likely <grant.likely@linaro.org>,
	spi-devel-general@lists.sourceforge.net
To: Michal Simek <michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cc1bf277180140e94abaac7d3a8c2d6a723f7ad2.1373290150.git.michal.simek@xilinx.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6LJmZOW/XGr4HvhC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 08, 2013 at 03:29:15PM +0200, Michal Simek wrote:
> devm_ioremap_resource() automatically checks that
> struct resource is initialized.
> Also group platform_get_resource() and devm_ioremap_resource()
> together.
> And remove mem resource from struct xilinx_spi.

Applied, thanks.

--6LJmZOW/XGr4HvhC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR2tGXAAoJELSic+t+oim92n8P/iVzUfuSFXVlLuWKM6jI3O2m
rGeEa4Bcc2Boean5dbTANoRZtJjt7nTkLLYFwjApcxG2pjMXxvNIKSSLRLz6eFOk
CARQUncty7NoqwOkgOntNrwO9SEgRLn4kUspsq/75Tq4iYzFcbzoUrSsUSC0DxDu
ULxxDleockbd5wtMyPFbXxNunWex7gxs7Mq87ZZIjZ87roFwxRS6YAntPRz/+Mx9
SZay5pVbhJ3ZfLbm8frBc8IWvCqANVXXV9PuGT3V2G34UwDLHkOB3BxlQCPA6lnn
XeltAKO0wjSzTLbcyTQE+uNABAdaWwYIl61PBKqA40Y8y7w/wVF9/C/ssU9fKRsi
NAMNqXVRLM1TBV9P+k/221aPr4kZzb+SfUMJ4Wa4fA+RMF7lSXGFYOOszG1ljoXd
NBebYsriILJR2k6Vu/DVXJD/UDCje2NDyVF/PirDXu43oHOAruIbtxYrGGwoYCRN
Yt1kni9LiHWLRLHYqWASeVEV9iHDvYoiWyESXeqHi0lEEMlKJKEE9jIGQl5Yqyq+
l0Ht8RbyK0XVo26N99/rLh1LFunG8XvVyzXjR0a1bLJsogWOLo82E3K01GkFW0we
92nWf/QP6sDveKqj9lsoAKuXllWF+i1V2WG6oWXEkuXxKcUDLkUzfrKgJGhQdRE3
HsNYvlNLY02pcnDb5d8e
=xSJp
-----END PGP SIGNATURE-----

--6LJmZOW/XGr4HvhC--
