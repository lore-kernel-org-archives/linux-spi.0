From: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH] mpc52xx_psc_spi: fix it for
	CONFIG_PPC_MERGE
Date: Mon, 21 May 2007 09:31:18 +0200
Message-ID: <46514AC6.8080704@toptica.com>
References: <20070516073707.GD9667@nd47.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linuxppc-embedded-mnsaURCQ41sdnm+yROfE0A@public.gmane.org
To: Domen Puncer <domen-CvScVCPLwOZg9hUCZPvPmw@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20070516073707.GD9667-yTFm/CsSGdPT0JcTxXCzFdi2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Acked-by: Dragos Carp <dragos.carp-+ybMorV4k0dBDgjK7y7TUQ@public.gmane.org>

Domen Puncer wrote:
> Fix mpc5200 PSC SPI driver to actually work for CONFIG_PPC_MERGE
> - s/mpc52xx/mpc5200/, as this was changed in device tree some time ago
> - fix spi id detection
>
>
> Signed-off-by: Domen Puncer <domen.puncer-P35k8AZwkyRBDgjK7y7TUQ@public.gmane.org>
>
> ---
>  drivers/spi/mpc52xx_psc_spi.c |   25 +++++++++++--------------
>  1 file changed, 11 insertions(+), 14 deletions(-)
>
> Index: work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- work-powerpc.git.orig/drivers/spi/mpc52xx_psc_spi.c
> +++ work-powerpc.git/drivers/spi/mpc52xx_psc_spi.c
> @@ -329,8 +329,8 @@ static int mpc52xx_psc_spi_port_config(i
>  	int ret =3D 0;
>  =

>  #if defined(CONFIG_PPC_MERGE)
> -	cdm =3D mpc52xx_find_and_map("mpc52xx-cdm");
> -	gpio =3D mpc52xx_find_and_map("mpc52xx-gpio");
> +	cdm =3D mpc52xx_find_and_map("mpc5200-cdm");
> +	gpio =3D mpc52xx_find_and_map("mpc5200-gpio");
>  #else
>  	cdm =3D ioremap(MPC52xx_PA(MPC52xx_CDM_OFFSET), MPC52xx_CDM_SIZE);
>  	gpio =3D ioremap(MPC52xx_PA(MPC52xx_GPIO_OFFSET), MPC52xx_GPIO_SIZE);
> @@ -445,9 +445,6 @@ static int __init mpc52xx_psc_spi_do_pro
>  	struct spi_master *master;
>  	int ret;
>  =

> -	if (pdata =3D=3D NULL)
> -		return -ENODEV;
> -
>  	master =3D spi_alloc_master(dev, sizeof *mps);
>  	if (master =3D=3D NULL)
>  		return -ENOMEM;
> @@ -594,17 +591,17 @@ static int __init mpc52xx_psc_spi_of_pro
>  	}
>  	regaddr64 =3D of_translate_address(op->node, regaddr_p);
>  =

> +	/* get PSC id (1..6, used by port_config) */
>  	if (op->dev.platform_data =3D=3D NULL) {
> -		struct device_node *np;
> -		int i =3D 0;
> +		const u32 *psc_nump;
>  =

> -		for_each_node_by_type(np, "spi") {
> -			if (of_find_device_by_node(np) =3D=3D op) {
> -				id =3D i;
> -				break;
> -			}
> -			i++;
> +		psc_nump =3D of_get_property(op->node, "cell-index", NULL);
> +		if (!psc_nump || *psc_nump > 5) {
> +			printk(KERN_ERR "mpc52xx_psc_spi: Device node %s has invalid "
> +					"cell-index property\n", op->node->full_name);
> +			return -EINVAL;
>  		}
> +		id =3D *psc_nump + 1;
>  	}
>  =

>  	return mpc52xx_psc_spi_do_probe(&op->dev, (u32)regaddr64, (u32)size64,
> @@ -617,7 +614,7 @@ static int __exit mpc52xx_psc_spi_of_rem
>  }
>  =

>  static struct of_device_id mpc52xx_psc_spi_of_match[] =3D {
> -	{ .type =3D "spi", .compatible =3D "mpc52xx-psc-spi", },
> +	{ .type =3D "spi", .compatible =3D "mpc5200-psc-spi", },
>  	{},
>  };
>  =

>
>
>   =



-- =


Dragos Carp
Research & Development

Phone: +49 89 85837-159, Fax: +49 89 85837-200
Address: TOPTICA Photonics AG, Lochhamer Schlag 19, D-82166 Graefelfing, Ge=
rmany

TOPTICA =96 A Passion for Precision
TOPTICA Photonics AG, Registered Office: 82166 Graefelfing, Germany
Companies' Register: Amtsgericht M=FCnchen, HRB 137368
Executive Directors: Dr. Wilhelm Kaenders, Dr. Thomas Weber
Chairman of the Supervisory Board: Dr. Kristian Hohla
www.toptica.com


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
