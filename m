From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] spi: spi-gpio: fix SPI_CS_HIGH capability
Date: Thu, 21 Feb 2019 20:21:29 +0100
Message-ID: <20190221192129.GJ2061@latitude>
References: <20190221152459.axrjce7yqkjmedgl@shell.armlinux.org.uk>
 <E1gwqlS-00053l-QU@rmk-PC.armlinux.org.uk>
 <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8561632142360866982=="
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 linux-spi@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
 Mark Brown <broonie@kernel.org>,
 Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
To: Fabio Estevam <festevam@gmail.com>
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOMZO5B_ELinMtAipaM9GP3Frj1YxRA5DmL-RJYnSE5i_W04uw@mail.gmail.com>
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


--===============8561632142360866982==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ns7jmDPpOpCD+GE/"
Content-Disposition: inline


--Ns7jmDPpOpCD+GE/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 21, 2019 at 01:14:04PM -0300, Fabio Estevam wrote:
> On Thu, Feb 21, 2019 at 1:00 PM Russell King <rmk+kernel@armlinux.org.uk>=
 wrote:
> >
> > spi-gpio is capable of dealing with active-high chip-selects.
> > Unfortunately, commit 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE
> > support") broke this by setting master->mode_bits, which overrides
> > the setting in the spi-bitbang code.  Fix this.
> >
> > Fixes: 4b859db2c606 ("spi: spi-gpio: add SPI_3WIRE support")
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > Patch against 4.20
>=20
> Adding Jonathan who sent a similar fix recently:
> https://patchwork.kernel.org/patch/10804855/

Hello Russel,

your patch looks better, and I think Mark Brown has already applied it.

Thanks.

--Ns7jmDPpOpCD+GE/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAlxu+jIACgkQCDBEmo7z
X9u6xg//Y3siFJybMCa3/A1LdwUkzzddcQTwtdyEB1/3MxL6r6c0EnQDNEex9C8Y
X6FpoSbs7YshlZ1dvPz3BaOE7t1w1kB+pMVvvhTvg5BCdG6/T1T2JwqM4hSraQmd
/5hSR4VXZOTz6XgGX+MXP9q471DVcm06lRrH7qXnjRPnMQqJ8lDCZG7gPlZ+oF1z
3s/o8LU4zIPZDPwt5Y9KRIEntfl5fE2HRxxmJuO8J3xDnU8BZR6zUzLeEa8UVOmK
EqnaJqCRR76gYtB56rgS87ypzeJa0Tu9Fwi7KOYbsnuPnASgT56/5tWORaAOWWR2
/bYPlnPLWnW7VIrphuu9AtiJBVmIvzXbLKQxDWralUkhuUHTSDAKWtax4sFJc0TE
q6j96aYeF+0Rvf3wKqb48CQKGKh7h+G+loWKkKHdVTGsVU83pA2FG42SArDXeLMG
cW3pQ9Rou8otTAdAoc/DxLQCNUNT4DdIjVegidHn5HnCF3MlAE7EKYs2Ru9eq1Qz
nsR3KX0FaB0ojeElo+D+UJ8Q0Jd/A7EADVXLtXoQUxTixfkBF1NIpn462fn8ljCE
RyI7+Cm01o9UIVuW2fGfObnOgTVcbMHvTzuBh4H6v2vFawvPJ8BQeIEXkheNcPfH
DapZlbrUtRZ6TJPo8n603999cfveVGmta/iyk5VTCgwV9SFqN9g=
=ZvR7
-----END PGP SIGNATURE-----

--Ns7jmDPpOpCD+GE/--


--===============8561632142360866982==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============8561632142360866982==--
