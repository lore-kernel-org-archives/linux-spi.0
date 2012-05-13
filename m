From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: [PATCH] spi/spi-fsl-spi: reference correct pdata in fsl_spi_cs_control
Date: Sun, 13 May 2012 11:22:25 +0200
Message-ID: <OFDB3A7477.7395BFE4-ONC12579FD.003346CE-C12579FD.00337DEA@transmode.se>
References: <1336775390-24128-1-git-send-email-herton.krzesinski@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Ben Hutchings <ben@decadent.org.uk>,
	Grant Likely <grant.likely@secretlab.ca>,
	Kenth Eriksson <kenth.eriksson@transmode.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: "Herton R. Krzesinski" <herton.krzesinski@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1336775390-24128-1-git-send-email-herton.krzesinski@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

"Herton R. Krzesinski" <herton.krzesinski@canonical.com> wrote on 2012/05/12 00:29:50:
>
> From: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
>
> Commit 178db7d3, "spi: Fix device unregistration when unregistering
> the bus master", changed spi device initialization of dev.parent pointer
> to be the master's device pointer instead of his parent.
>
> This introduced a bug in spi-fsl-spi, since its usage of spi device
> pointer was not updated accordingly. This was later fixed by commit
> 5039a86, "spi/mpc83xx: fix NULL pdata dereference bug", but it missed
> another spot on fsl_spi_cs_control function where we also need to update
> usage of spi device pointer. This change address that.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Herton Ronaldo Krzesinski <herton.krzesinski@canonical.com>
> ---
>  drivers/spi/spi-fsl-spi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/spi/spi-fsl-spi.c b/drivers/spi/spi-fsl-spi.c
> index 5f748c0..6a62934 100644
> --- a/drivers/spi/spi-fsl-spi.c
> +++ b/drivers/spi/spi-fsl-spi.c
> @@ -933,7 +933,7 @@ err:
>
>  static void fsl_spi_cs_control(struct spi_device *spi, bool on)
>  {
> -   struct device *dev = spi->dev.parent;
> +   struct device *dev = spi->dev.parent->parent;
>     struct mpc8xxx_spi_probe_info *pinfo = to_of_pinfo(dev->platform_data);
>     u16 cs = spi->chip_select;
>     int gpio = pinfo->gpios[cs];

So it seems
Acked-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
