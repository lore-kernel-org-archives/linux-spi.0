From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: enable spi_board_info to be
	registered after spi_master
Date: Tue, 27 Jul 2010 11:27:16 -0600
Message-ID: <AANLkTi=C48+mnNjrxha8WqagCybF45f7aTn6nxt2qRuU@mail.gmail.com>
References: <1280223769-19919-1-git-send-email-feng.tang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
To: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1280223769-19919-1-git-send-email-feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 27, 2010 at 3:42 AM, Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> Currently spi_register_board_info() has to be called before its related
> spi_master be registered, otherwise these board info will be just ignored.
>
> This patch will remove this order limit, it adds a global spi master list
> like the existing global board info listr. Whenever a board info is
> registered, the spi master list will be scanned, and a new spi device will
> be created if they match.
>
> Signed-off-by: Feng Tang <feng.tang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/spi.c =A0 =A0 =A0 | =A0 66 +++++++++++++++++++++++++++++++=
++-------------
> =A0include/linux/spi/spi.h | =A0 =A03 ++
> =A02 files changed, 50 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index b3a1f92..f4a5221 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -196,13 +196,16 @@ EXPORT_SYMBOL_GPL(spi_register_driver);
>
> =A0struct boardinfo {
> =A0 =A0 =A0 =A0struct list_head =A0 =A0 =A0 =A0list;
> - =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0n_board_info;
> - =A0 =A0 =A0 struct spi_board_info =A0 board_info[0];
> + =A0 =A0 =A0 struct spi_board_info =A0 board_info;
> =A0};
>
> =A0static LIST_HEAD(board_list);
> =A0static DEFINE_MUTEX(board_lock);
>
> +
> +static LIST_HEAD(master_list);
> +static DEFINE_MUTEX(master_lock);
> +

Protect against global namespace collisions.  spi_master_list and
spi_master_list_lock.

You can probably use one mutex for both the board and master lists.

> =A0/**
> =A0* spi_alloc_device - Allocate a new SPI device
> =A0* @master: Controller to which device is connected
> @@ -365,6 +368,19 @@ struct spi_device *spi_new_device(struct spi_master =
*master,
> =A0}
> =A0EXPORT_SYMBOL_GPL(spi_new_device);
>
> +static void scan_masterlist(struct spi_board_info *bi)

spi_scan_master_list

> +{
> + =A0 =A0 =A0 struct spi_master *master;
> +
> + =A0 =A0 =A0 mutex_lock(&master_lock);
> + =A0 =A0 =A0 list_for_each_entry(master, &master_list, list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (master->bus_num !=3D bi->bus_num)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) spi_new_device(master, bi);

Always check the return value.  At the very least print out an error
message.  I know you're copying the scan_boardinfo() lead, but that is
a bad example.  There are error paths in spi_new_device() that will
not print any output.

> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 mutex_unlock(&master_lock);
> +}
> +
> =A0/**
> =A0* spi_register_board_info - register SPI devices for a given board
> =A0* @info: array of chip descriptors
> @@ -387,41 +403,45 @@ EXPORT_SYMBOL_GPL(spi_new_device);
> =A0int __init
> =A0spi_register_board_info(struct spi_board_info const *info, unsigned n)
> =A0{
> - =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi;
> + =A0 =A0 =A0 struct boardinfo =A0 =A0 =A0 =A0*bi, *tmp_bi;
> + =A0 =A0 =A0 int i;
>
> - =A0 =A0 =A0 bi =3D kmalloc(sizeof(*bi) + n * sizeof *info, GFP_KERNEL);
> + =A0 =A0 =A0 bi =3D kzalloc(n * sizeof *bi, GFP_KERNEL);

sizeof(*bi)

> =A0 =A0 =A0 =A0if (!bi)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
> - =A0 =A0 =A0 bi->n_board_info =3D n;
> - =A0 =A0 =A0 memcpy(bi->board_info, info, n * sizeof *info);
>
> + =A0 =A0 =A0 tmp_bi =3D bi;
> =A0 =A0 =A0 =A0mutex_lock(&board_lock);
> - =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++, bi++, info++) {

I'd do this the other way around (bi vs. tmp_bi).  I think this is
somewhat clearer:

for (i =3D 0, tmp_bi =3D bi; i < n; i++, tmp_bi++, info++)

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(&bi->board_info, info, sizeof *info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&bi->list, &board_list);
> + =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0mutex_unlock(&board_lock);
> +
> + =A0 =A0 =A0 bi =3D tmp_bi;
> + =A0 =A0 =A0 for (i =3D 0; i < n; i++)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 scan_masterlist(&bi->board_info);

How does this work?  The same board_info struct is passed to
scan_masterlist() multiple times.

> +
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> =A0/* FIXME someone should add support for a __setup("spi", ...) that
> =A0* creates board info from kernel command lines
> =A0*/
> -
> =A0static void scan_boardinfo(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0struct boardinfo =A0 =A0 =A0 =A0*bi;
>
> =A0 =A0 =A0 =A0mutex_lock(&board_lock);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* NOTE: this relies on spi_new_device to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* issue diagnostics when given bogus inp=
uts
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (void) spi_new_device(master, chip);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mutex_unlock(&board_lock);
> =A0}
> @@ -537,6 +557,10 @@ int spi_register_master(struct spi_master *master)
> =A0 =A0 =A0 =A0dev_dbg(dev, "registered master %s%s\n", dev_name(&master-=
>dev),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dynamic ? " (dynamic)" : "=
");
>
> + =A0 =A0 =A0 mutex_lock(&master_lock);
> + =A0 =A0 =A0 list_add_tail(&master->list, &master_list);
> + =A0 =A0 =A0 mutex_unlock(&master_lock);
> +

There seems to be a race condition here.  If a boardinfo is registered
after this list add, but before scan_boardinfo(master), then a
boardinfo can get parsed twice for a single master.  I think the
proper thing to do is to hold the mutex over the whole operation; from
registering the list or master, until after the scan is complete.


Otherwise, in general I like the patch.  spin it again to address the
comments, and I think I can get it into linux-next for 2.6.36.

Thanks!
g.

> =A0 =A0 =A0 =A0/* populate children from any spi device tables */
> =A0 =A0 =A0 =A0scan_boardinfo(master);
> =A0 =A0 =A0 =A0status =3D 0;
> @@ -568,6 +592,10 @@ void spi_unregister_master(struct spi_master *master)
> =A0{
> =A0 =A0 =A0 =A0int dummy;
>
> + =A0 =A0 =A0 mutex_lock(&master_lock);
> + =A0 =A0 =A0 list_del(&master->list);
> + =A0 =A0 =A0 mutex_unlock(&master_lock);
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
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
The Palm PDK Hot Apps Program offers developers who use the
Plug-In Development Kit to bring their C/C++ apps to Palm for a share =

of $1 Million in cash or HP Products. Visit us here for more details:
http://ad.doubleclick.net/clk;226879339;13503038;l?
http://clk.atdmt.com/CRS/go/247765532/direct/01/
