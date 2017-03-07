From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH] spi: sun6i: Allow transfers larger than FIFO size
Date: Tue, 7 Mar 2017 11:18:52 +0100
Message-ID: <20170307101852.uuxiu5ycd7zbgrxm@lukather>
References: <20170306121443.36954-1-icenowy@aosc.xyz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0893829086322692611=="
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, linux-arm-kernel@lists.infradead.org
To: Icenowy Zheng <icenowy@aosc.xyz>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170306121443.36954-1-icenowy@aosc.xyz>
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


--===============0893829086322692611==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vptwfxvc7j4c66tt"
Content-Disposition: inline


--vptwfxvc7j4c66tt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 06, 2017 at 08:14:43PM +0800, Icenowy Zheng wrote:
> The spi-sun6i driver have the same problem that spi-sun4i used to have
> -- SPI transfers are limited to one FIFO depth.
>=20
> This commit fixes this problem in the same way it's fixed in spi-sun4i.
> See commit 196737912da5 ("spi: sun4i: Allow transfers larger than FIFO si=
ze")
> for more information.
>=20
> The sun6i SPI controllers features changeable interrupt trigger level, bu=
t I
> set it to 3/4 of fifo depth, as same as the the sun4i SPI controllers.
>=20
> Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--vptwfxvc7j4c66tt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYvokMAAoJEBx+YmzsjxAgTv0P/jfyDyvh79zhCzq8j2GT4iDK
wgIUxNEtWCFBUaX9bgwtNdeKoBntuL1ZpkzQI8ORgHo4Y4jFWLm6dcdkNzQIOVLY
LEp/z7cRziaVuNMv/VdIuM5jTeaY7TYfOXUEtCN8R1mIYppPsFzFTqUGB+K20IFN
laOCPs31IHkWzRs984f8Y0KVYvAMyAs1b3CrWyAJxByfJ6Q0sn2Dm3A+toRhT501
i9E3Iy9k09OrdQIBpQfsd8iescYn7xn8iQv6/UTyD0BtfitQ5/a2ix7YOcDnw1WW
2YuK2oawpyExqorcDMq1Z6D/+oUh+EGBAg8taW/vKRme6ERxFj9MpnonhIEMrL1O
K/2LiL18rqQ1DnBR7lnn51HQlAIrqcYhXXTPvflQWgPqCS8Cs63dIBZoFQnrYWA8
3n+mCNkduAvPo54RBffaCfr0I+Lk8vNhVbnXNs82yuHfjuV1+e7X1GqXiA4uLqVo
i2B7vI2kXDp7yr8XxfSKggrbwsgtf+mFTcz2Hg2c0Sw0ZrkKrlcKBlnaoGq3RZRt
Ahe+fdfCJWGSLgNfd82AcnE9PCA6+xvNCvVUTnhNSji51HZ7M3IdThMJJbuorTxD
B7VksQGc/3wLRj3HCeC3cv9kK+RA+9nBplxMRU1+ZcfWI9hTutTrqR6RCTbbLO2o
AG+dyJJ4kAjBHRBzDldH
=kEoD
-----END PGP SIGNATURE-----

--vptwfxvc7j4c66tt--


--===============0893829086322692611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============0893829086322692611==--
