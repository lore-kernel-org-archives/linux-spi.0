From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] spi: spi-ep93xx: Change dir type in
 ep93xx_spi_dma_{finish,prepare}
Date: Thu, 4 Oct 2018 11:32:47 +0100
Message-ID: <20181004103247.GC6412@sirena.org.uk>
References: <20181004023926.15847-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6zdv2QT/q3FMhpsV"
Cc: linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        H Hartley Sweeten <hartleys@visionengravers.com>,
        Mika Westerberg <mika.westerberg@iki.fi>
To: Nathan Chancellor <natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181004023926.15847-1-natechancellor@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org


--6zdv2QT/q3FMhpsV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 03, 2018 at 07:39:26PM -0700, Nathan Chancellor wrote:
> Clang warns when one enumerated type is implicitly converted to another.
>=20
> drivers/spi/spi-ep93xx.c:342:62: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration

Please remember to CC driver maintainers and authors on patch
submissions so they can review things, copying in Hartley and Mika.

> type 'enum dma_data_direction' [-Wenum-conversion]
>         nents =3D dma_map_sg(chan->device->dev, sgt->sgl, sgt->nents, dir=
);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:428:58: note: expanded from macro
> 'dma_map_sg'
> \#define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
>                                ~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:348:57: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>                 dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir=
);
>                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> drivers/spi/spi-ep93xx.c:377:56: warning: implicit conversion from
> enumeration type 'enum dma_transfer_direction' to different enumeration
> type 'enum dma_data_direction' [-Wenum-conversion]
>         dma_unmap_sg(chan->device->dev, sgt->sgl, sgt->nents, dir);
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
> ./include/linux/dma-mapping.h:429:62: note: expanded from macro
> 'dma_unmap_sg'
> \#define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>                                  ~~~~~~~~~~~~~~~~~~          ^
> 3 warnings generated.
>=20
> dma_{,un}map_sg expects an enum of type dma_data_direction but this
> driver uses dma_transfer_direction for everything. Converting to
> dma_data_direction would be desirable but there are a few shared
> structures that expect dma_transfer_direction so it is just simpler to
> change the parameter here. dma_transfer_direction and dma_data_direction
> are different sizes but this driver only uses the 1 and 2 values which
> mean the same thing so this change is safe.
>=20
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/spi/spi-ep93xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/spi/spi-ep93xx.c b/drivers/spi/spi-ep93xx.c
> index f1526757aaf6..189fc2225b69 100644
> --- a/drivers/spi/spi-ep93xx.c
> +++ b/drivers/spi/spi-ep93xx.c
> @@ -256,8 +256,7 @@ static int ep93xx_spi_read_write(struct spi_master *m=
aster)
>   * in case of failure.
>   */
>  static struct dma_async_tx_descriptor *
> -ep93xx_spi_dma_prepare(struct spi_master *master,
> -		       enum dma_transfer_direction dir)
> +ep93xx_spi_dma_prepare(struct spi_master *master, int dir)
>  {
>  	struct ep93xx_spi *espi =3D spi_master_get_devdata(master);
>  	struct spi_transfer *xfer =3D master->cur_msg->state;
> @@ -359,8 +358,7 @@ ep93xx_spi_dma_prepare(struct spi_master *master,
>   * Function finishes with the DMA transfer. After this, the DMA buffer is
>   * unmapped.
>   */
> -static void ep93xx_spi_dma_finish(struct spi_master *master,
> -				  enum dma_transfer_direction dir)
> +static void ep93xx_spi_dma_finish(struct spi_master *master, int dir)
>  {
>  	struct ep93xx_spi *espi =3D spi_master_get_devdata(master);
>  	struct dma_chan *chan;
> --=20
> 2.19.0
>=20

--6zdv2QT/q3FMhpsV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu17E4ACgkQJNaLcl1U
h9BaGAf/fV+/e0h6rs2itGWzMcx4OzEXDa6d3Whxpc9ruajYoMwZK0hkzvnNBCQZ
gz8L4JJSqds/ycFS8JHiDL93Gs9j7tQb9WoCAAReY0SjUoUak/bawG4VrtRq0qlx
w8lfCmhGMYSOJuXrA3RosGo3MgoImRk2xtE/545LXDE4a7rhfv5Q2JMHiME9r6jI
Jzmu9UlajUQahpTGiGgwyYJ0e4pJ5eqtbgtSu3dqW8TXaVLH29DnfDf7dSTCX3fs
v9Yw4OwvtwwXRoaEBp3+M/jwoyF53ncPxgD2kYI6i2V0w2kEVsdZLcVuwTUyJ+Zb
EpmKELAeQlaD5q4CFbezTAalgurhKw==
=bvKK
-----END PGP SIGNATURE-----

--6zdv2QT/q3FMhpsV--
