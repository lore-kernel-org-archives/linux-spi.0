From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 14/15] spi/xilinx: Check number of slaves range
Date: Wed, 28 Jan 2015 19:40:48 +0000
Message-ID: <20150128194048.GK21293@sirena.org.uk>
References: <1422447834-23116-1-git-send-email-ricardo.ribalda@gmail.com>
 <1422447834-23116-15-git-send-email-ricardo.ribalda@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4029954555016324974=="
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Michal Simek <michal.simek@xilinx.com>,
 =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
 linux-spi@vger.kernel.org
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1422447834-23116-15-git-send-email-ricardo.ribalda@gmail.com>
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


--===============4029954555016324974==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JqPwA6/cWC5gSNSn"
Content-Disposition: inline


--JqPwA6/cWC5gSNSn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jan 28, 2015 at 01:23:53PM +0100, Ricardo Ribalda Delgado wrote:

> +#define MAX_CS			32
> +

This really ought to be namespaced.

--JqPwA6/cWC5gSNSn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJUyTs/AAoJECTWi3JdVIfQ8gAIAIWnKfxiBl8ljTAgeu9JluoN
RYzLdcHKtSF923PvHoKy0Pw+Zw4d0oUj3l9QMcLVkuy1Lp/rT0ihPp180S08ms6D
epBsCMhJDVabS/iFZi+v3YPP8Lb6i5YkMLRT3ecAEyUil2mmfd0jPyy9EhACryo1
n5HV8ek7bPrsl2ZcFF38MKdsGoYvovF4aVirXi2OzTKW9zXbcOZg58Y0VSDf3dpp
QdzDvZqRN5LZ5KhQqEVTMv5GQgdhYQshlmiiclYMuOsfX5y1Ui5Z5P3YvNukkoQb
ta3mRsedQKzcrAVj1oQ/PVtRsfQBPsMLllAMx64q/b5IWHcTShqXkW8uMbMyAHA=
=vhaD
-----END PGP SIGNATURE-----

--JqPwA6/cWC5gSNSn--


--===============4029954555016324974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============4029954555016324974==--
