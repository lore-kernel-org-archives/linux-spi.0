From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-dw: Add lock protect dw_spi rx/tx to prevent
 concurrent calls
Date: Tue, 31 Dec 2019 00:29:28 +0000
Message-ID: <20191231002928.GD3897@sirena.org.uk>
References: <1577418669-34821-1-git-send-email-wuxu.wu@huawei.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="iVCmgExH7+hIHJ1A"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        hushiyuan@huawei.com
To: "wuxu.wu" <wuxu.wu@huawei.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1577418669-34821-1-git-send-email-wuxu.wu@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--iVCmgExH7+hIHJ1A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 27, 2019 at 11:51:09AM +0800, wuxu.wu wrote:

>  static void dw_writer(struct dw_spi *dws)
>  {
> -	u32 max = tx_max(dws);
> +	u32 max
>  	u16 txw = 0;

This is going to break the build, there's a missing ; in the
declaration of max.  Otherwise this looks good.

--iVCmgExH7+hIHJ1A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl4KlmcACgkQJNaLcl1U
h9AA4Qf8DzOXFKYiWrGAwiKjNf1jfbj33s54tU8nmpfWwnaLfIgpqwSj0fTRnfwy
tznV4UozcwcguyMAsbl4vn5Q0OrJOQfeLhwGdVBKXkJYOJLI40cgn0MFC6Ts4Ux3
il8MXI4Y93xXZ0OJh2BoW+j1MGNsCmAJ8PqtWiGr7yNygcp8aNmyytjXGbuBVooe
aiKeSt2yCDXUgWkkPS5CEcuLFmjodgumOlHravhrdDpRcAUR00YuTPCooZ28AMpx
kq+DAG4w0CcSyOsZcm0+ZJjIyO1DY5BYbNlb4TJJNPYQ6wNBi/3buiDZXfeBlGIN
DwRokHH0vSzHS75GN7ha/Shm8Bq0WQ==
=UER1
-----END PGP SIGNATURE-----

--iVCmgExH7+hIHJ1A--
