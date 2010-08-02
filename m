From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v5] spi: enable spi_board_info to be
	registered after spi_master
Date: Mon, 2 Aug 2010 02:32:55 -0600
Message-ID: <AANLkTimw5wvRKZw4QWDO+9ubyjszF5RiSQ=JzbbT2V3M@mail.gmail.com>
References: <20100802155215.193482f0@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100802155215.193482f0@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Aug 2, 2010 at 1:52 AM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi All,
>
> Pls review this patch. thanks,

Queued into my spi/test branch.

Thanks,
g.

>
> -Feng
>
> Changelog:
> =A0 =A0 =A0 =A0v4/5:
> =A0 =A0 =A0 =A0 =A0 * Abstract a spi_match_master_to_boardinfo() which wi=
ll
> =A0 =A0 =A0 =A0 =A0 =A0 be called in scanning master/boardinfo list, sugg=
ested
> =A0 =A0 =A0 =A0 =A0 =A0 by Grant also.
> =A0 =A0 =A0 =A0v3:
> =A0 =A0 =A0 =A0 =A0 * As suggested by Grant, use one lock to protect the =
match
> =A0 =A0 =A0 =A0 =A0 =A0 between spi_master and spi board info
> =A0 =A0 =A0 =A0v2:
> =A0 =A0 =A0 =A0 =A0 * fix a typo in looping scan_masterlist()
> =A0 =A0 =A0 =A0 =A0 * fix one race condition found by Grant
>
>
> From b42755bb2e4e2162951bf6544e9fce82452eab5e Mon Sep 17 00:00:00 2001
> From: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> Date: Tue, 27 Jul 2010 17:15:05 +0800
> Subject: [PATCH] spi: enable spi_board_info to be registered after spi_ma=
ster
>
> Currently spi_register_board_info() has to be called before its related
> spi_master be registered, otherwise these board info will be just ignored.
>
> This patch will remove this order limit, it adds a global spi master list
> like the existing global board info listr. Whenever a board info or a
> spi_master is registered, the spi master list or board info list
> will be scanned, and a new spi device will be created if there is a
> master-board info match.
>
> Cc: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
> Cc: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 86 ++++++++++++++++++++++++-------=
---------------
> =A0include/linux/spi/spi.h | =A0 =A03 ++
> =A02 files changed, 48 insertions(+), 41 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b3a1f92..a868cc0 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -27,11 +27,6 @@
> =A0#include <linux/mod_devicetable.h>
> =A0#include <linux/spi/spi.h>
>
> -
> -/* SPI bustype and spi_master class are registered after board init code
> - * provides the SPI device tables, ensuring that both are present by the
> - * time controller driver registration causes spi_devices to "enumerate".
> - */
> =A0static void spidev_release(struct device *dev)
> =A0{
> =A0 =A0 =A0 =A0struct spi_device =A0 =A0 =A0 *spi =3D to_spi_device(dev);
> @@ -196,11 +191,16 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
>
> =A0struct boardinfo {
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n_board_info;
> - =A0 =A0 =A0 struct spi_board_info =A0 board_info[0];
> + =A0 =A0 =A0 struct spi_board_info =A0 board_info;
> =A0};
>
> =A0static LIST_HEAD(board_list);
> +static LIST_HEAD(spi_master_list);
> +
> +/*
> + * Used to protect add/del opertion for board_info list and
> + * spi_master list, and their matching process
> + */
> =A0static DEFINE_MUTEX(board_lock);
>
> =A0/**
> @@ -365,6 +365,20 @@ struct spi_device *spi_new_device(struct spi_master =
*master,
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_new_device);
>
> +static void spi_match_master_to_boardinfo(struct spi_master *master,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_=
board_info *bi)
> +{
> + =A0 =A0 =A0 struct spi_device *dev;
> +
> + =A0 =A0 =A0 if (master->bus_num !=3D bi->bus_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 dev =3D spi_new_device(master, bi);
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(master->dev.parent, "can't create n=
ew device for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bi->modalias);
> +}
> +
> =A0/**
> =A0* spi_register_board_info - register SPI devices for a given board
> =A0* @info: array of chip descriptors
> @@ -387,43 +401,25 @@ EXPORT_SYMBOL_GPL(spi_new_device);
> =A0int __init
> =A0spi_register_board_info(struct spi_board_info const *info, unsigned n)
> =A0{
> - =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi;
> + =A0 =A0 =A0 struct boardinfo *bi;
> + =A0 =A0 =A0 int i;
>
> - =A0 =A0 =A0 bi =3D kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
> + =A0 =A0 =A0 bi =3D kzalloc(n * sizeof(*bi), GFP_KERNEL);
> =A0 =A0 =A0 =A0if (!bi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> - =A0 =A0 =A0 bi->n_board_info =3D n;
> - =A0 =A0 =A0 memcpy(bi->board_info, info, n * sizeof *info);
> -
> - =A0 =A0 =A0 mutex_lock(&board_lock);
> - =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> - =A0 =A0 =A0 mutex_unlock(&board_lock);
> - =A0 =A0 =A0 return 0;
> -}
>
> -/* FIXME someone should add support for a __setup("spi", ...) that
> - * creates board info from kernel command lines
> - */
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++, bi++, info++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_master *master;
>
> -static void scan_boardinfo(struct spi_master *master)
> -{
> - =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi;
> -
> - =A0 =A0 =A0 mutex_lock(&board_lock);
> - =A0 =A0 =A0 list_for_each_entry(bi, &board_list, list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_board_info =A0 *chip =3D bi->boa=
rd_info;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (n =3D bi->n_board_info; n > 0; n--, ch=
ip++) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip->bus_num !=3D mast=
er->bus_num)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: this relies on spi=
_new_device to
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* issue diagnostics when=
 given bogus inputs
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) spi_new_device(maste=
r, chip);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&bi->board_info, info, sizeof(*info)=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(master, &spi_master_lis=
t, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_match_master_to_boardin=
fo(master, &bi->board_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&board_lock);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mutex_unlock(&board_lock);
> +
> + =A0 =A0 =A0 return 0;
> =A0}
>
> =A0/*--------------------------------------------------------------------=
-----*/
> @@ -506,6 +502,7 @@ int spi_register_master(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0static atomic_t =A0 =A0 =A0 =A0 dyn_bus_id =3D ATOMIC_INIT=
((1<<15) - 1);
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev =3D master->dev.par=
ent;
> + =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EN=
ODEV;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dynamic =3D 0;
>
> @@ -537,15 +534,18 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0dev_dbg(dev, "registered master %s%s\n", dev_name(&master-=
>dev),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic ? " (dynamic)" : "=
");
>
> - =A0 =A0 =A0 /* populate children from any spi device tables */
> - =A0 =A0 =A0 scan_boardinfo(master);
> + =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 list_add_tail(&master->list, &spi_master_list);
> + =A0 =A0 =A0 list_for_each_entry(bi, &board_list, list)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_match_master_to_boardinfo(master, &bi->=
board_info);
> + =A0 =A0 =A0 mutex_unlock(&board_lock);
> +
> =A0 =A0 =A0 =A0status =3D 0;
> =A0done:
> =A0 =A0 =A0 =A0return status;
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_register_master);
>
> -
> =A0static int __unregister(struct device *dev, void *master_dev)
> =A0{
> =A0 =A0 =A0 =A0/* note: before about 2.6.14-rc1 this would corrupt memory=
: */
> @@ -568,6 +568,10 @@ void spi_unregister_master(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0int dummy;
>
> + =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 list_del(&master->list);
> + =A0 =A0 =A0 mutex_unlock(&board_lock);
> +
> =A0 =A0 =A0 =A0dummy =3D device_for_each_child(master->dev.parent, &maste=
r->dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0__unregister);
> =A0 =A0 =A0 =A0device_unregister(&master->dev);
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index af56071..f4a29b6 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -204,6 +204,7 @@ static inline void spi_unregister_driver(struct spi_d=
river *sdrv)
> =A0/**
> =A0* struct spi_master - interface to SPI master controller
> =A0* @dev: device interface to this driver
> + * @list: link with the global spi_master list
> =A0* @bus_num: board-specific (and often SOC-specific) identifier for a
> =A0* =A0 =A0 given SPI controller.
> =A0* @num_chipselect: chipselects are used to distinguish individual
> @@ -235,6 +236,8 @@ static inline void spi_unregister_driver(struct spi_d=
river *sdrv)
> =A0struct spi_master {
> =A0 =A0 =A0 =A0struct device =A0 dev;
>
> + =A0 =A0 =A0 struct list_head list;
> +
> =A0 =A0 =A0 =A0/* other than negative (=3D=3D assign one dynamically), bu=
s_num is fully
> =A0 =A0 =A0 =A0 * board-specific. =A0usually that simplifies to being SOC=
-specific.
> =A0 =A0 =A0 =A0 * example: =A0one SOC has three SPI controllers, numbered=
 0..2,
> --
> 1.7.0.4
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share
of $1 Million in cash or HP Products. Visit us here for more details:
http://p.sf.net/sfu/dev2dev-palm
