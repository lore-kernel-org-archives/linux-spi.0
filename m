From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/2]spi: DUAL and QUAD support
Date: Thu, 22 Aug 2013 13:30:04 +0100
Message-ID: <20130822123004.GG26118@sirena.org.uk>
References: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1308601377559715465=="
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-mtd@lists.infradead.org, pekon@ti.com,
 spi-devel-general@lists.sourceforge.net, sourav.poddar@ti.com,
 tpiepho@gmail.com
To: wangyuhang <wangyuhang2014@gmail.com>
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
In-Reply-To: <1376216117-5864-1-git-send-email-wangyuhang2014@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
List-Id: linux-spi.vger.kernel.org


--===============1308601377559715465==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d3slIU+tL1lDaIh/"
Content-Disposition: inline


--d3slIU+tL1lDaIh/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Aug 11, 2013 at 06:15:17PM +0800, wangyuhang wrote:

Applied, this looks good thanks.  A few coding style issues which I'll
fix up myself but one thing:

> fix the previous patch some mistake below:
> 1. DT in slave node, use "spi-tx-nbits = <1/2/4>" in place of using
>    "spi-tx-dual, spi-tx-quad" directly, same to rx. So correct the
>    previous way to get the property in @of_register_spi_devices().

This new DT stuff needs to be reviewed on the devicetree list and
documented in the generic SPI bindings.  Can you please send a patch
doing that?

Please also note that the SPI list moved to vger.

--d3slIU+tL1lDaIh/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFgRJAAoJELSic+t+oim9Y4cP/A+tI6TPBpRCfdJMK2tXx6Lp
yV/gHFnf8xRuI71AeybCZD6Qzw6v2NiUf+YtZsturgmK1h44jKUzq9NwsEtw2/xA
yuO4RwEqrtpZY/gTNCYilkRWuDJJf7ySZWG4srhUqV97qP8ygcemmpxG3e9Kcboh
xfFMDPo0mFlup7qnz9Q/9gPBVEjgqq0h35yDUM/s7yuHmfwMex71TMCfpnABUejn
DYldEmyqaM0BVi/kfyKrhiXm7E+FIQ1udsKrVyoCSkP5cJZ/pF7342FSKqi+8d/Q
ATrJM4jCUlE2ILs6RD5E91+Z0p0oUPHD/iLKLs2JeGhEr0tBUteaAwDh2XgP88dn
CceEKl3eeAk6ofOncaw7YFhsdc13gzU3JNLW4Dzy6bLJ63hIxK7G5V2oiWMi/GWK
kLn73kHVNIQKDR6DgCqYkDQh4yDLqeIx5TFjiUQgesW+gna8+uqIDSQ9vEcWwRWX
isMA4nzHCCejBCMrnt0cNKgdKDdz/QGSY7ThVuurLt11hSTfKRlPcV522cZKzB6j
q3Q40SZ8dMQ1lNPN2y+NMFSmsQ4+B1NLX8aYbJYaU6yDkhDqsIf/JAfSpg3HvXYR
LhpsrX2W8Oc9KCSaBEy1bXIUT0JQbPLPyEEMFJ8aJy0zPlhW9DLzfASpBXlC8O02
F65cIZ4cUcARp1ReJJYE
=1RbE
-----END PGP SIGNATURE-----

--d3slIU+tL1lDaIh/--


--===============1308601377559715465==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

--===============1308601377559715465==--
