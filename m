From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5 08/17] spi: mpc512x: adjust to OF based clock lookup
Date: Mon, 25 Nov 2013 17:30:08 +0000
Message-ID: <20131125173008.GQ14725@sirena.org.uk>
References: <1384729577-7336-1-git-send-email-gsi@denx.de>
 <1384729577-7336-9-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2574076024996262672=="
Cc: Mike Turquette <mturquette@linaro.org>, Detlev Zundel <dzu@denx.de>,
 linux-spi@vger.kernel.org, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
To: Gerhard Sittig <gsi@denx.de>
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1384729577-7336-9-git-send-email-gsi@denx.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
List-Id: linux-spi.vger.kernel.org


--===============2574076024996262672==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxSUI8jTRJ26tNoZ"
Content-Disposition: inline


--CxSUI8jTRJ26tNoZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 18, 2013 at 12:06:08AM +0100, Gerhard Sittig wrote:
> after device tree based clock lookup became available, the peripheral
> driver need no longer construct clock names which include the PSC index,
> remove the "psc%d_mclk" template and unconditionally use 'mclk'

Have there been other changes which make this happen?

--CxSUI8jTRJ26tNoZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSk4kcAAoJELSic+t+oim9/z8P/R/RzwHyE523m5unO25Z4V8e
L2azjAc9GtXjwCmcUEFBcufRioYtsf1KiL8AdxWFZ28+cCnkaW1NJQJ5vhlO8FK1
cSwwzTTcSK0TDWbEpQ9o/2+UPkfqIytbGWHv2v3nyxmVriWsjQaXnPnvX2E1T39z
/WjX6AIT6wJenwARDTg0GJwpKUr+UWgrJjIHL7NBlLU0dLKHB2Ou4wPFxC5KwbYw
Hu0BplP0AmO6ZMSV3dpZ33JOMOjhQ1EA0ATiq31e7s8j1A/mTcyzIbB5i59S3rWF
Ruvc1WvuVEqQ/j9c/fZEZqyWicM37zZ5MbmqM0dP23ZBF2+YqiW7MmdGlQ571cOK
V/kgFj8ygCgMMnW3c3QI/O+89Wumi7r+/nw65J0oLRnd6g8dTZRbJz/K7R9k4vR7
peCuz9CMMHwA0Rre7udBg/DDQDcTYBkvdwGh+drRGQ57z8h/qyn8ur7H4znslxJn
9YRPYzVf68oEeCT/dfwbOhUz6CakinUOGd5D/M2Uul3gDNyC79IKsr/qQ5boz071
oV8Pc8ERJXLmXkdrnEoL1vl6wATAGK2sbiBYsvglCeGMmfYzHvs/+atMaOmNvF0P
ZZBjK8vZ/nlZX8kFllHc1qX+nBAyrZZpwTSOnz7Fy7u9T2aFdhnM5HDOXWxiD/B8
i3dbR82ha2JRIicrqHlt
=gBcW
-----END PGP SIGNATURE-----

--CxSUI8jTRJ26tNoZ--

--===============2574076024996262672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev
--===============2574076024996262672==--
