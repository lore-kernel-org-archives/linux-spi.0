From: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH v2] spi: spi-imx: spi_imx_remove: do not disable disabled
 clocks
Date: Thu, 27 Feb 2014 17:23:43 +0800
Message-ID: <530F041F.80800@freescale.com>
References: <530EFE8E.5050303@freescale.com> <1393492575-32495-1-git-send-email-phdm@macqel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
To: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1393492575-32495-1-git-send-email-phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

=D3=DA 2014=C4=EA02=D4=C227=C8=D5 17:16, Philippe De Muyter =D0=B4=B5=C0=
:
> Currently, at module removal, one gets the following warnings:
> ------------[ cut here ]------------
> WARNING: at drivers/clk/clk.c:780 clk_disable+0x18/0x24()
> Modules linked in: spi_imx(-) [last unloaded: ev76c560]
> CPU: 1 PID: 16337 Comm: rmmod Tainted: G        W    3.10.17-80548-g9=
0191eb-dirty #33
> [<80013b4c>] (unwind_backtrace+0x0/0xf8) from [<800115dc>] (show_stac=
k+0x10/0x14)
> [<800115dc>] (show_stack+0x10/0x14) from [<800257b8>] (warn_slowpath_=
common+0x4c/0x68)
> [<800257b8>] (warn_slowpath_common+0x4c/0x68) from [<800257f0>] (warn=
_slowpath_null+0x1c/0x24)
> [<800257f0>] (warn_slowpath_null+0x1c/0x24) from [<803f60ec>] (clk_di=
sable+0x18/0x24)
> [<803f60ec>] (clk_disable+0x18/0x24) from [<7f02c9cc>] (spi_imx_remov=
e+0x54/0x9c [spi_imx])
> [<7f02c9cc>] (spi_imx_remove+0x54/0x9c [spi_imx]) from [<8025868c>] (=
platform_drv_remove+0x18/0x1c)
> [<8025868c>] (platform_drv_remove+0x18/0x1c) from [<80256f60>] (__dev=
ice_release_driver+0x70/0xcc)
> [<80256f60>] (__device_release_driver+0x70/0xcc) from [<80257770>] (d=
river_detach+0xcc/0xd0)
> [<80257770>] (driver_detach+0xcc/0xd0) from [<80256d90>] (bus_remove_=
driver+0x7c/0xc0)
> [<80256d90>] (bus_remove_driver+0x7c/0xc0) from [<80068668>] (SyS_del=
ete_module+0x144/0x1f8)
> [<80068668>] (SyS_delete_module+0x144/0x1f8) from [<8000e080>] (ret_f=
ast_syscall+0x0/0x30)
> ---[ end trace 1f5df9ad54996300 ]---
> ------------[ cut here ]------------
> WARNING: at drivers/clk/clk.c:780 clk_disable+0x18/0x24()
> Modules linked in: spi_imx(-) [last unloaded: ev76c560]
> CPU: 1 PID: 16337 Comm: rmmod Tainted: G        W    3.10.17-80548-g9=
0191eb-dirty #33
> [<80013b4c>] (unwind_backtrace+0x0/0xf8) from [<800115dc>] (show_stac=
k+0x10/0x14)
> [<800115dc>] (show_stack+0x10/0x14) from [<800257b8>] (warn_slowpath_=
common+0x4c/0x68)
> [<800257b8>] (warn_slowpath_common+0x4c/0x68) from [<800257f0>] (warn=
_slowpath_null+0x1c/0x24)
> [<800257f0>] (warn_slowpath_null+0x1c/0x24) from [<803f60ec>] (clk_di=
sable+0x18/0x24)
> [<803f60ec>] (clk_disable+0x18/0x24) from [<7f02c9e8>] (spi_imx_remov=
e+0x70/0x9c [spi_imx])
> [<7f02c9e8>] (spi_imx_remove+0x70/0x9c [spi_imx]) from [<8025868c>] (=
platform_drv_remove+0x18/0x1c)
> [<8025868c>] (platform_drv_remove+0x18/0x1c) from [<80256f60>] (__dev=
ice_release_driver+0x70/0xcc)
> [<80256f60>] (__device_release_driver+0x70/0xcc) from [<80257770>] (d=
river_detach+0xcc/0xd0)
> [<80257770>] (driver_detach+0xcc/0xd0) from [<80256d90>] (bus_remove_=
driver+0x7c/0xc0)
> [<80256d90>] (bus_remove_driver+0x7c/0xc0) from [<80068668>] (SyS_del=
ete_module+0x144/0x1f8)
> [<80068668>] (SyS_delete_module+0x144/0x1f8) from [<8000e080>] (ret_f=
ast_syscall+0x0/0x30)
> ---[ end trace 1f5df9ad54996301 ]---
>
> Since commit 9e556dcc55774c9a1032f32baa0e5cfafede8b70, "spi: spi-imx:=
 only
> enable the clocks when we start to transfer a message", clocks are al=
ways
> disabled except when transmitting messages.  There is thus no need to
> disable them at module removal.
>
> Signed-off-by: Philippe De Muyter <phdm-vQo90/bmh3WzQB+pC5nmwQ@public.gmane.org>
> Cc: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> Change since v1:
> keep the 'unprepare' part (Thanks Huang)
>  drivers/spi/spi-imx.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/spi/spi-imx.c b/drivers/spi/spi-imx.c
> index a5474ef..47f15d9 100644
> --- a/drivers/spi/spi-imx.c
> +++ b/drivers/spi/spi-imx.c
> @@ -948,8 +948,8 @@ static int spi_imx_remove(struct platform_device =
*pdev)
>  	spi_bitbang_stop(&spi_imx->bitbang);
> =20
>  	writel(0, spi_imx->base + MXC_CSPICTRL);
> -	clk_disable_unprepare(spi_imx->clk_ipg);
> -	clk_disable_unprepare(spi_imx->clk_per);
> +	clk_unprepare(spi_imx->clk_ipg);
> +	clk_unprepare(spi_imx->clk_per);
>  	spi_master_put(master);
> =20
>  	return 0;
Acked-by: Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
