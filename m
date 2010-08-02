From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH v3] spi: enable spi_board_info to be
	registered after spi_master
Date: Sun, 1 Aug 2010 23:53:25 -0600
Message-ID: <AANLkTi=dEQ9oRi-NOi=oyab3yBeX7HWDOqs+pS5=-Bix@mail.gmail.com>
References: <20100802134736.24854fac@feng-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>,
	spi-devel-list <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20100802134736.24854fac@feng-i7>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sun, Aug 1, 2010 at 11:47 PM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Hi All,
>
> Pls review this patch. thanks,

Hi Feng, Looking good.  One more comment below.

>
> -Feng
>
> Changelog:
> =A0 =A0 =A0 =A0v3:
> =A0 =A0 =A0 =A0 =A0 * As suggested by Grant, use one lock to protect the =
match
> =A0 =A0 =A0 =A0 =A0 =A0 between spi_master and spi board info
> =A0 =A0 =A0 =A0v2:
> =A0 =A0 =A0 =A0 =A0 * fix a typo in looping scan_masterlist()
> =A0 =A0 =A0 =A0 =A0 * fix one race condition found by Grant
>
> From 28af337ec89225a0dfb7ca516545b7eff112e3b2 Mon Sep 17 00:00:00 2001
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
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 84 +++++++++++++++++++++++++++++++=
+--------------
> =A0include/linux/spi/spi.h | =A0 =A03 ++
> =A02 files changed, 61 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b3a1f92..8fb2337 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -196,11 +196,16 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
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
> @@ -365,6 +370,24 @@ struct spi_device *spi_new_device(struct spi_master =
*master,
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_new_device);
>
> +/* Has to be called when board_lock is acquired */
> +static void spi_scan_masterlist(struct spi_board_info *bi)
> +{
> + =A0 =A0 =A0 struct spi_master *master;
> + =A0 =A0 =A0 struct spi_device *dev;
> +
> + =A0 =A0 =A0 list_for_each_entry(master, &spi_master_list, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (master->bus_num !=3D bi->bus_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi_new_device(master, bi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(master->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can't crea=
te new device for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bi->modalia=
s);
> + =A0 =A0 =A0 }
> +}
> +

The abstraction isn't quite at the right place because the same code
block is now duplicated twice.  Consider the following instead:

static void spi_match_master_to_boardinfo(struct spi_master *master,
				struct spi_board_info *bi)
{
	struct spi_device *dev;

	if (master->bus_num !=3D bi->bus_num)
		return;

	dev =3D spi_new_device(master, bi);
	if (!dev)
		dev_err(master->dev.parent, "can't create new device for %s\n",
			bi->modalias);
}

And then from spi_register_board_info, do:

	list_for_each_entry(master, &spi_master_list, list)
		spi_match_master_to_boardinfo(master, &bi->boardinfo);

And in spi_register_master, do:

	list_for_each_entry(bi, &board_list, list)
		spi_match_master_to_boardinfo(master, &bi->boardinfo);

It will be less code that way.

Otherwise, this patch looks good to me.  Unfortunately, it's too late
for 2.6.36, but I'll pick it up into my test branch in prep for the
2.6.37 cycle.

Cheers,
g.

> =A0/**
> =A0* spi_register_board_info - register SPI devices for a given board
> =A0* @info: array of chip descriptors
> @@ -387,43 +410,46 @@ EXPORT_SYMBOL_GPL(spi_new_device);
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
>
> - =A0 =A0 =A0 mutex_lock(&board_lock);
> - =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> - =A0 =A0 =A0 mutex_unlock(&board_lock);
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++, bi++, info++) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&bi->board_info, info, sizeof(*info)=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi_scan_masterlist(&bi->board_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&board_lock);
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -/* FIXME someone should add support for a __setup("spi", ...) that
> +/*
> + * FIXME someone should add support for a __setup("spi", ...) that
> =A0* creates board info from kernel command lines
> + *
> + * Should be called when board_lock is acquired
> =A0*/
> -
> =A0static void scan_boardinfo(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0struct boardinfo =A0 =A0 =A0 =A0*bi;
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 *dev;
>
> - =A0 =A0 =A0 mutex_lock(&board_lock);
> =A0 =A0 =A0 =A0list_for_each_entry(bi, &board_list, list) {
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_board_info =A0 *chip =3D &bi->bo=
ard_info;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (chip->bus_num !=3D master->bus_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev =3D spi_new_device(master, chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(master->dev.parent,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "can't crea=
te new device for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip->modal=
ias);
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 mutex_unlock(&board_lock);
> =A0}
>
> =A0/*--------------------------------------------------------------------=
-----*/
> @@ -537,15 +563,17 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0dev_dbg(dev, "registered master %s%s\n", dev_name(&master-=
>dev),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic ? " (dynamic)" : "=
");
>
> - =A0 =A0 =A0 /* populate children from any spi device tables */
> + =A0 =A0 =A0 mutex_lock(&board_lock);
> + =A0 =A0 =A0 list_add_tail(&master->list, &spi_master_list);
> =A0 =A0 =A0 =A0scan_boardinfo(master);
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
> @@ -568,6 +596,10 @@ void spi_unregister_master(struct spi_master *master)
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
