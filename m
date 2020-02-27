From: Naga Sureshkumar Relli <nagasure-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
Subject: RE: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
Date: Thu, 27 Feb 2020 06:52:34 +0000
Message-ID: <MN2PR02MB572711F7545C52882C32F7C6AFEB0@MN2PR02MB5727.namprd02.prod.outlook.com>
References: <20200224162643.29102-1-thommyj@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Thommy Jakobsson <thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20200224162643.29102-1-thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Thommy,

> -----Original Message-----
> From: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org> O=
n Behalf Of
> Thommy Jakobsson
> Sent: Monday, February 24, 2020 9:57 PM
> To: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Michal Simek <michals-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>; linux-spi@vger=
.kernel.org
> Cc: Thommy Jakobsson <thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> Subject: [PATCH] spi/zynqmp: remove entry that causes a cs glitch
>=20
> In the public interface for chipselect, there is always an entry commente=
d as "Dummy generic
> FIFO entry" pushed down to the fifo right after the activate/deactivate c=
ommand. The dummy
> entry is 0x0, irregardless if the intention was to activate or deactive t=
he cs. This causes the cs
> line to glitch rather than beeing activated in the case when there was an=
 activate command.
>=20
> This has been observed on oscilloscope, and have caused problems for at l=
east one specific
> flash device type connected to the qspi port. After the change the glitch=
 is gone and cs goes
> active when intended.
>=20
> The reason why this worked before (except for the glitch) was because whe=
n sending the actual
> data, the CS bits are once again set. Since most flashes uses mode 0, the=
re is always a half clk
> period anyway for cs to clk active setup time. If someone would rely on t=
iming from a
> chip_select call to a transfer_one, it would fail though.
>=20
> It is unknown why the dummy entry was there in the first place, git log s=
eems to be of no help
> in this case. The reference manual gives no indication of the necessity o=
f this. In fact the lower
> 8 bits are a setup (or hold in case of deactivate) time expressed in cycl=
es. So this should not be
> needed to fulfill any setup/hold timings.
>=20
> Signed-off-by: Thommy Jakobsson <thommyj-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  drivers/spi/spi-zynqmp-gqspi.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/spi/spi-zynqmp-gqspi.c b/drivers/spi/spi-zynqmp-gqsp=
i.c index
> 60c4de4e4485..7412a3042a8d 100644
> --- a/drivers/spi/spi-zynqmp-gqspi.c
> +++ b/drivers/spi/spi-zynqmp-gqspi.c
> @@ -401,9 +401,6 @@ static void zynqmp_qspi_chipselect(struct spi_device =
*qspi, bool
> is_high)
>=20
>  	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, genfifoentry);
>=20
> -	/* Dummy generic FIFO entry */
> -	zynqmp_gqspi_write(xqspi, GQSPI_GEN_FIFO_OFST, 0x0);
> -
>  	/* Manually start the generic FIFO command */
>  	zynqmp_gqspi_write(xqspi, GQSPI_CONFIG_OFST,
>  			zynqmp_gqspi_read(xqspi, GQSPI_CONFIG_OFST) |
> --
> 2.17.1
Reviewed-by: Naga Sureshkumar Relli <naga.sureshkumar.relli-gjFFaj9aHVfQT0dZR+AlfA@public.gmane.org>
