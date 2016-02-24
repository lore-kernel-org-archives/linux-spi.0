From: "Huang, Tao" <huangtao@rock-chips.com>
Subject: Re: [PATCH] spi/rockchip: Make sure spi clk is on in
 rockchip_spi_set_cs
Date: Wed, 24 Feb 2016 19:09:57 +0800
Message-ID: <56CD8F85.2090204@rock-chips.com>
References: <1456308004-29102-1-git-send-email-huibin.hong@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Huibin Hong <huibin.hong@rock-chips.com>,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
	"shawn.lin" <shawn.lin@kernel-upstream.org>,
	linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rockchip.com>
To: Mark Brown <broonie@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1456308004-29102-1-git-send-email-huibin.hong@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi, Mark:

Another way to solve this bug is add runtime PM support while spi setup=
=2E
Some other chips may have some problem, for example mt65xx and orion,
which access hardware register too.

On 2016=E5=B9=B402=E6=9C=8824=E6=97=A5 18:00, Huibin Hong wrote:
> Rockchip_spi_set_cs could be called by spi_setup, but
> spi_setup may be called by device driver after runtime suspend.
> Then the spi clock is closed, rockchip_spi_set_cs may access the
> spi registers, which causes cpu block in some socs.
>=20
> Fixes: 64e36824b32 ("spi/rockchip: add driver for Rockchip RK3xxx")
> Cc: Addy Ke <addy.ke@rockchip.com>
> Cc: shawn.lin <shawn.lin@kernel-upstream.org>
> Signed-off-by: Huibin Hong <huibin.hong@rock-chips.com>
> ---
>=20
>  drivers/spi/spi-rockchip.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi-rockchip.c b/drivers/spi/spi-rockchip.c
> index 79a8bc4..035767c 100644
> --- a/drivers/spi/spi-rockchip.c
> +++ b/drivers/spi/spi-rockchip.c
> @@ -265,7 +265,10 @@ static inline u32 rx_max(struct rockchip_spi *rs=
)
>  static void rockchip_spi_set_cs(struct spi_device *spi, bool enable)
>  {
>  	u32 ser;
> -	struct rockchip_spi *rs =3D spi_master_get_devdata(spi->master);
> +	struct spi_master *master =3D spi->master;
> +	struct rockchip_spi *rs =3D spi_master_get_devdata(master);
> +
> +	pm_runtime_get_sync(rs->dev);
>=20
>  	ser =3D readl_relaxed(rs->regs + ROCKCHIP_SPI_SER) & SER_MASK;
>=20
> @@ -290,6 +293,8 @@ static void rockchip_spi_set_cs(struct spi_device=
 *spi, bool enable)
>  		ser &=3D ~(1 << spi->chip_select);
>=20
>  	writel_relaxed(ser, rs->regs + ROCKCHIP_SPI_SER);
> +
> +	pm_runtime_put_sync(rs->dev);
>  }
>=20
>  static int rockchip_spi_prepare_message(struct spi_master *master,
> --
> 1.9.1
>=20
>=20
>=20
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
>=20
>=20
>=20
