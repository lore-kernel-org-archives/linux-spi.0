From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 1/6] spi: bcm2835: bcm2835_spi_transfer_one_poll
 remove unnecessary argument
Date: Wed, 8 May 2019 17:26:54 +0900
Message-ID: <20190508082654.GB14916@sirena.org.uk>
References: <20190423201513.8073-1-kernel@martin.sperl.org>
 <20190423201513.8073-2-kernel@martin.sperl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3542483013575646859=="
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-spi@vger.kernel.org
To: kernel@martin.sperl.org
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190423201513.8073-2-kernel@martin.sperl.org>
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


--===============3542483013575646859==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o3dU+gdzLtSIP39w"
Content-Disposition: inline


--o3dU+gdzLtSIP39w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2019 at 08:15:08PM +0000, kernel@martin.sperl.org wrote:
> From: Martin Sperl <kernel@martin.sperl.org>
>=20
> Remove the unnecessary argument of xfer_time_us when calling
> bcm2835_spi_transfer_one_poll.
>=20
> Signed-off-by: Martin Sperl <kernel@martin.sperl.org>
>=20
> Changelog:
>   V1 -> V2: applied feedback by Stefan Wahren
>             reorganized patchset
> 	    added extra rational, descriptions
>=20
> ---

As per SubmittingPatches the changelog should go after the ---.

--o3dU+gdzLtSIP39w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSks0ACgkQJNaLcl1U
h9BY0Qf+IN1cU8pA4fu4aeFzAF84gtxCwr7OTUKaDZsjCl3jHXWSPZW78sYMFWgJ
n0Dl4xw8E+iC+pk+JBMJ6yu8CzPN8bo4lHUHVsTTm0l0zRaYEXGDxd7PRMBnF/Hq
7fzwbDCqDMxXIqdZ8zWIG6X02G9JPyHHD7QICSXHK8vgJU0hL1EC9wiA+vGgZhRR
9FEhpt4+//JzSx8mghV76CKtdyeX2L19xuTfYfdzOqt9yI87DjVpeox3rJuNNNAh
pQ0v/JMW1t23Btzlxegpe870L9LBzOLCkiCAyPKcMNKZEfkYMmxc2gldgmDVeuDc
YStYnC0d+5bPIKklfVMc4FDZ0/XSvw==
=aPRu
-----END PGP SIGNATURE-----

--o3dU+gdzLtSIP39w--


--===============3542483013575646859==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============3542483013575646859==--
