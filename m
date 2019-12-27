From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH]    spi: spi-dw: Add lock protect dw_spi rx/tx to
 prevent concurrent calls
Date: Fri, 27 Dec 2019 00:50:19 +0000
Message-ID: <20191227005019.GI27497@sirena.org.uk>
References: <1576900099-40754-1-git-send-email-wuxu.wu@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ev7mvGV+3JQuI2Eo"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
To: "wuxu.wu" <wuxu.wu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1576900099-40754-1-git-send-email-wuxu.wu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--ev7mvGV+3JQuI2Eo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 21, 2019 at 11:48:19AM +0800, wuxu.wu wrote:
> 	dw_spi_irq()nd dw_spi_transfer_one concurrent calls.
>=20
> 	I find a panic in dw_writer(): txw =3D *(u8 *)(dws->tx);

Please fix the indentation of your commit log, it's indented by a
tab - look at other patches people are posting for examples...

> 	[ 1025.321302] Call trace:
> 	[ 1025.321309]  machine_kexec+0x58/0x3e8
> 	[ 1025.321319]  __crash_kexec+0x98/0x148

Please think hard before including complete backtraces in upstream
reports, they are very large and contain almost no useful information
relative to their size so often obscure the relevant content in your
message. If part of the backtrace is usefully illustrative then it's
usually better to pull out the relevant sections.

> 	[ 1025.321365]  dw_spi_irq+0x48/0x70
> 	[ 1025.321377]  __handle_irq_event_percpu+0x74/0x278
>=20
> Signed-off-by: wuxu.wu <wuxu.wu@huawei.com>
> ---

The Signed-off-by here has the right indenttion for the
changelog.

>  static void dw_writer(struct dw_spi *dws)
>  {
> -	u32 max =3D tx_max(dws);
> +	u32 max
>  	u16 txw =3D 0;
> +	unsigned long flags;
> =20
> +	spin_lock_irqsave(&dws->buf_lock, flags);

We shouldn't use spin_lock_irqsave() here since this is called
=66rom interrupt context by interrupt_transfer() - we should use
plain old spin_lock() here.  Otherwise the code change looks
good, well spotted!

--ev7mvGV+3JQuI2Eo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4FVUoACgkQJNaLcl1U
h9CceQf9GaikZTXYD0rg68bF6w6UrTSEJ1u5MP/k9IMNIFuqUSlQ3ioVg8kBobkq
Jo30DM3KNwXISBvtCS/KZxBvWjRjcI9A7Q1iLMmPNdGlF9/EumeuFFp0BJr/P1cF
X7ICunNMD+/Qg4hKNnu2hn9+cZZsddmhnlfu407nYSJnxjbAYtIIXmtis+k34ZF+
VKZiKqqq6BK3QwfZaf1FjvIl36m2r1FEGab8p3oKU+MdY0i/dXLeyPe7tMSGvo50
Yln0Tv3oxHQQLKnwn717sDdL9gvC/nw41zJefziOTg9JXiFpZqWSvCey75ysEhjL
wKXR1p488/0AmcNHuWw6kLbwpcksEA==
=YLiK
-----END PGP SIGNATURE-----

--ev7mvGV+3JQuI2Eo--
