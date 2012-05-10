From: Shubhrajyoti Datta <omaplinuxkernel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/omap2-mcspi: convert to the pump message
	infrastructure
Date: Thu, 10 May 2012 18:29:41 +0530
Message-ID: <CAM=Q2cto4mGd+_mTzgQDsgmxzvwfuKyAewdV+VDWPPVww-pKaA@mail.gmail.com>
References: <1336562199-17599-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1336562199-17599-1-git-send-email-shubhrajyoti-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, May 9, 2012 at 4:46 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> This patch converts the OMAP SPI driver to use the SPI infrastructure
> pump message queue.Also fixes the below warning.
> master is unqueued, this is deprecated
Just realised that sent the missed a few cleanups please ignore this patch.
Will resend it in while.

>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> ---
> Applies on Grants spi next branch.
>
> =A0drivers/spi/spi-omap2-mcspi.c | =A0244 +++++++++++++++++++------------=
----------
> =A01 files changed, 114 insertions(+), 130 deletions(-)
>
> diff --git a/drivers/spi/spi-omap2-mcspi.c b/drivers/spi/spi-omap2-mcspi.c
> index f374eee..44f76df 100644
> --- a/drivers/spi/spi-omap2-mcspi.c
> +++ b/drivers/spi/spi-omap2-mcspi.c
> @@ -120,10 +120,8 @@ struct omap2_mcspi_regs {
> =A0};
>
> =A0struct omap2_mcspi {
> - =A0 =A0 =A0 struct work_struct =A0 =A0 =A0work;
> =A0 =A0 =A0 =A0/* lock protects queue and registers */
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0lock;
> - =A0 =A0 =A0 struct list_head =A0 =A0 =A0 =A0msg_queue;
> =A0 =A0 =A0 =A0struct spi_master =A0 =A0 =A0 *master;
> =A0 =A0 =A0 =A0/* Virtual base address of the controller */
> =A0 =A0 =A0 =A0void __iomem =A0 =A0 =A0 =A0 =A0 =A0*base;
> @@ -131,7 +129,6 @@ struct omap2_mcspi {
> =A0 =A0 =A0 =A0/* SPI1 has 4 channels, while SPI2 has 2 */
> =A0 =A0 =A0 =A0struct omap2_mcspi_dma =A0*dma_channels;
> =A0 =A0 =A0 =A0struct device =A0 =A0 =A0 =A0 =A0 *dev;
> - =A0 =A0 =A0 struct workqueue_struct *wq;
> =A0 =A0 =A0 =A0struct omap2_mcspi_regs ctx;
> =A0};
>
> @@ -275,6 +272,23 @@ static int omap2_mcspi_enable_clocks(struct omap2_mc=
spi *mcspi)
> =A0 =A0 =A0 =A0return pm_runtime_get_sync(mcspi->dev);
> =A0}
>
> +static int omap2_prepare_transfer(struct spi_master *master)
> +{
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(master=
);
> +
> + =A0 =A0 =A0 pm_runtime_get_sync(mcspi->dev);
> + =A0 =A0 =A0 return 0;
> +}
> +
> +static int omap2_unprepare_transfer(struct spi_master *master)
> +{
> + =A0 =A0 =A0 struct omap2_mcspi *mcspi =3D spi_master_get_devdata(master=
);
> +
> + =A0 =A0 =A0 pm_runtime_mark_last_busy(mcspi->dev);
> + =A0 =A0 =A0 pm_runtime_put_autosuspend(mcspi->dev);
> + =A0 =A0 =A0 return 0;
> +}
> +
> =A0static int mcspi_wait_for_reg_bit(void __iomem *reg, unsigned long bit)
> =A0{
> =A0 =A0 =A0 =A0unsigned long timeout;
> @@ -846,144 +860,126 @@ static void omap2_mcspi_cleanup(struct spi_device=
 *spi)
> =A0 =A0 =A0 =A0}
> =A0}
>
> -static void omap2_mcspi_work(struct work_struct *work)
> +static void omap2_mcspi_work(struct omap2_mcspi *mcspi, struct spi_messa=
ge *m)
> =A0{
> - =A0 =A0 =A0 struct omap2_mcspi =A0 =A0 =A0*mcspi;
> -
> - =A0 =A0 =A0 mcspi =3D container_of(work, struct omap2_mcspi, work);
> -
> - =A0 =A0 =A0 if (omap2_mcspi_enable_clocks(mcspi) < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> -
> - =A0 =A0 =A0 spin_lock_irq(&mcspi->lock);
>
> =A0 =A0 =A0 =A0/* We only enable one channel at a time -- the one whose m=
essage is
> - =A0 =A0 =A0 =A0* at the head of the queue -- although this controller w=
ould gladly
> + =A0 =A0 =A0 =A0* -- although this controller would gladly
> =A0 =A0 =A0 =A0 * arbitrate among multiple channels. =A0This corresponds =
to "single
> =A0 =A0 =A0 =A0 * channel" master mode. =A0As a side effect, we need to m=
anage the
> =A0 =A0 =A0 =A0 * chipselect with the FORCE bit ... CS !=3D channel enabl=
e.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 while (!list_empty(&mcspi->msg_queue)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_message =A0 =A0 =A0 =A0 =A0 =A0 =
=A0*m;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 *spi;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct spi_transfer =A0 =A0 =A0 =A0 =A0 =A0=
 *t =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 cs_active =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap2_mcspi_cs =A0 =A0 =A0 =A0 =A0 *=
cs;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct omap2_mcspi_device_config *cd;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 par_override =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 status =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 chconf;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 m =3D container_of(mcspi->msg_queue.next, s=
truct spi_message,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0queue);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del_init(&m->queue);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irq(&mcspi->lock);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi =3D m->spi;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs =3D spi->controller_state;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 cd =3D spi->controller_data;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_for_each_entry(t, &m->transfers, trans=
fer_list) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf =3D=3D NULL &=
& t->rx_buf =3D=3D NULL && t->len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
-EINVAL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (par_override || t->spee=
d_hz || t->bits_per_word) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_overrid=
e =3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
omap2_mcspi_setup_transfer(spi, t);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status =
< 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!t->spe=
ed_hz && !t->bits_per_word)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 par_override =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 struct spi_device =A0 =A0 =A0 =A0 =A0 =A0 =A0 *spi;
> + =A0 =A0 =A0 struct spi_transfer =A0 =A0 =A0 =A0 =A0 =A0 *t =3D NULL;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 cs_active =3D 0;
> + =A0 =A0 =A0 struct omap2_mcspi_cs =A0 =A0 =A0 =A0 =A0 *cs;
> + =A0 =A0 =A0 struct omap2_mcspi_device_config *cd;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 par_override =3D 0;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 status =3D 0;
> + =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 chconf;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs_active) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi=
_force_cs(spi, 1);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_active =
=3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 spin_lock_irq(&mcspi->lock);
> + =A0 =A0 =A0 list_del_init(&m->queue);
> + =A0 =A0 =A0 spin_unlock_irq(&mcspi->lock);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf =3D mcspi_cached_chc=
onf0(spi);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf &=3D ~OMAP2_MCSPI_CH=
CONF_TRM_MASK;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf &=3D ~OMAP2_MCSPI_CH=
CONF_TURBO;
> + =A0 =A0 =A0 spi =3D m->spi;
> + =A0 =A0 =A0 cs =3D spi->controller_state;
> + =A0 =A0 =A0 cd =3D spi->controller_data;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf |=3D=
 OMAP2_MCSPI_CHCONF_TRM_RX_ONLY;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (t->rx_buf =3D=3D N=
ULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf |=3D=
 OMAP2_MCSPI_CHCONF_TRM_TX_ONLY;
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cd && cd->turbo_mode &&=
 t->tx_buf =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Turbo mo=
de is for more than one word */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->len =
> ((cs->word_len + 7) >> 3))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 chconf |=3D OMAP2_MCSPI_CHCONF_TURBO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> + =A0 =A0 =A0 list_for_each_entry(t, &m->transfers, transfer_list) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf =3D=3D NULL && t->rx_buf =3D=
=3D NULL && t->len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -EINVAL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (par_override || t->speed_hz || t->bits_=
per_word) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_override =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D omap2_mcspi_setu=
p_transfer(spi, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status < 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!t->speed_hz && !t->bit=
s_per_word)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_overrid=
e =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_chconf0(spi, ch=
conf);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!cs_active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_force_cs(spi, 1=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_active =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =
=A0 =A0 =A0 =A0count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf =3D mcspi_cached_chconf0(spi);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf &=3D ~OMAP2_MCSPI_CHCONF_TRM_MASK;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf &=3D ~OMAP2_MCSPI_CHCONF_TURBO;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RX_ONLY =
mode needs dummy data in TX reg */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_b=
uf =3D=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __raw_writel(0, cs->base
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 + OMAP2_MCSPI_TX0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf |=3D OMAP2_MCSPI_CHC=
ONF_TRM_RX_ONLY;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (t->rx_buf =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf |=3D OMAP2_MCSPI_CHC=
ONF_TRM_TX_ONLY;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->is_d=
ma_mapped || t->len >=3D DMA_MIN_BYTES)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 count =3D omap2_mcspi_txrx_dma(spi, t);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 count =3D omap2_mcspi_txrx_pio(spi, t);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->actual_l=
ength +=3D count;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cd && cd->turbo_mode && t->tx_buf =3D=
=3D NULL) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Turbo mode is for more t=
han one word */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->len > ((cs->word_len=
 + 7) >> 3))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 chconf |=3D=
 OMAP2_MCSPI_CHCONF_TURBO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count !=
=3D t->len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 status =3D -EIO;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mcspi_write_chconf0(spi, chconf);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned =A0 =A0 =A0 =A0cou=
nt;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* RX_ONLY mode needs dummy=
 data in TX reg */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->tx_buf =3D=3D NULL)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_write=
l(0, cs->base
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 + OMAP2_MCSPI_TX0);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->delay_usecs)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(t->d=
elay_usecs);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (m->is_dma_mapped || t->=
len >=3D DMA_MIN_BYTES)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D o=
map2_mcspi_txrx_dma(spi, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D o=
map2_mcspi_txrx_pio(spi, t);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->actual_length +=3D count;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ignore the "leave it on =
after last xfer" hint */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->cs_change) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi=
_force_cs(spi, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_active =
=3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count !=3D t->len) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D =
-EIO;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Restore defaults if they were overriden =
*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (par_override) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_override =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D omap2_mcspi_setu=
p_transfer(spi, NULL);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->delay_usecs)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 udelay(t->delay_usecs);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (cs_active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* ignore the "leave it on after last xfer"=
 hint */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (t->cs_change) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap2_mcspi_force_cs(spi, =
0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cs_active =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 /* Restore defaults if they were overriden */
> + =A0 =A0 =A0 if (par_override) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 par_override =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D omap2_mcspi_setup_transfer(spi, =
NULL);
> + =A0 =A0 =A0 }
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->status =3D status;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 m->complete(m->context);
> + =A0 =A0 =A0 if (cs_active)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_force_cs(spi, 0);
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irq(&mcspi->lock);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
>
> - =A0 =A0 =A0 spin_unlock_irq(&mcspi->lock);
> + =A0 =A0 =A0 m->status =3D status;
>
> - =A0 =A0 =A0 omap2_mcspi_disable_clocks(mcspi);
> =A0}
>
> -static int omap2_mcspi_transfer(struct spi_device *spi, struct spi_messa=
ge *m)
> +static int omap2_mcspi_transfer_one_message(struct spi_master *master,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 struct spi_message *m)
> =A0{
> =A0 =A0 =A0 =A0struct omap2_mcspi =A0 =A0 =A0*mcspi;
> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;
> =A0 =A0 =A0 =A0struct spi_transfer =A0 =A0 *t;
>
> + =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0m->actual_length =3D 0;
> =A0 =A0 =A0 =A0m->status =3D 0;
>
> =A0 =A0 =A0 =A0/* reject invalid messages and transfers */
> - =A0 =A0 =A0 if (list_empty(&m->transfers) || !m->complete)
> + =A0 =A0 =A0 if (list_empty(&m->transfers))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0list_for_each_entry(t, &m->transfers, transfer_list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0const void =A0 =A0 =A0*tx_buf =3D t->tx_bu=
f;
> @@ -995,7 +991,7 @@ static int omap2_mcspi_transfer(struct spi_device *sp=
i, struct spi_message *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| (t->bit=
s_per_word &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0( =A0t->bits_per_word < 4
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0|| t->bits_per_word > 32))) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "transfe=
r: %d Hz, %d %s%s, %d bpw\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mcspi->dev, "transf=
er: %d Hz, %d %s%s, %d bpw\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0t->speed_hz,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0tx_buf ? "tx" : "",
> @@ -1004,7 +1000,7 @@ static int omap2_mcspi_transfer(struct spi_device *=
spi, struct spi_message *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->speed_hz && t->speed_hz < (OMAP2_MC=
SPI_MAX_FREQ >> 15)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "speed_h=
z %d below minimum %d Hz\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mcspi->dev, "speed_=
hz %d below minimum %d Hz\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0t->speed_h=
z,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP2_MCSP=
I_MAX_FREQ >> 15);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> @@ -1014,35 +1010,30 @@ static int omap2_mcspi_transfer(struct spi_device=
 *spi, struct spi_message *m)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0continue;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tx_buf !=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_singl=
e(&spi->dev, (void *) tx_buf,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->tx_dma =3D dma_map_singl=
e(mcspi->dev, (void *) tx_buf,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0len, DMA_TO_DEVICE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi-=
>dev, t->tx_dma)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&sp=
i->dev, "dma %cX %d bytes error\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(mcspi=
->dev, t->tx_dma)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mcs=
pi->dev, "dma %cX %d bytes error\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0'T', len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EI=
NVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rx_buf !=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_singl=
e(&spi->dev, rx_buf, t->len,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t->rx_dma =3D dma_map_singl=
e(mcspi->dev, rx_buf, t->len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0DMA_FROM_DEVICE);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(&spi-=
>dev, t->rx_dma)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&sp=
i->dev, "dma %cX %d bytes error\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (dma_mapping_error(mcspi=
->dev, t->rx_dma)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mcs=
pi->dev, "dma %cX %d bytes error\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0'R', len);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (tx_buf=
 !=3D NULL)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dma_unmap_single(&spi->dev, t->tx_dma,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dma_unmap_single(mcspi->dev, t->tx_dma,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0len, DMA_TO_DEVICE);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EI=
NVAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mcspi =3D spi_master_get_devdata(spi->master);
> -
> - =A0 =A0 =A0 spin_lock_irqsave(&mcspi->lock, flags);
> - =A0 =A0 =A0 list_add_tail(&m->queue, &mcspi->msg_queue);
> - =A0 =A0 =A0 queue_work(mcspi->wq, &mcspi->work);
> - =A0 =A0 =A0 spin_unlock_irqrestore(&mcspi->lock, flags);
> -
> + =A0 =A0 =A0 omap2_mcspi_work(mcspi, m);
> + =A0 =A0 =A0 spi_finalize_current_message(master);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -1120,7 +1111,9 @@ static int __devinit omap2_mcspi_probe(struct platf=
orm_device *pdev)
> =A0 =A0 =A0 =A0master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
>
> =A0 =A0 =A0 =A0master->setup =3D omap2_mcspi_setup;
> - =A0 =A0 =A0 master->transfer =3D omap2_mcspi_transfer;
> + =A0 =A0 =A0 master->prepare_transfer_hardware =3D omap2_prepare_transfe=
r;
> + =A0 =A0 =A0 master->unprepare_transfer_hardware =3D omap2_unprepare_tra=
nsfer;
> + =A0 =A0 =A0 master->transfer_one_message =3D omap2_mcspi_transfer_one_m=
essage;
> =A0 =A0 =A0 =A0master->cleanup =3D omap2_mcspi_cleanup;
> =A0 =A0 =A0 =A0master->dev.of_node =3D node;
>
> @@ -1145,12 +1138,6 @@ static int __devinit omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0mcspi =3D spi_master_get_devdata(master);
> =A0 =A0 =A0 =A0mcspi->master =3D master;
>
> - =A0 =A0 =A0 mcspi->wq =3D alloc_workqueue(dev_name(&pdev->dev), WQ_MEM_=
RECLAIM, 1);
> - =A0 =A0 =A0 if (mcspi->wq =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOMEM;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_master;
> - =A0 =A0 =A0 }
> -
> =A0 =A0 =A0 =A0r =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> =A0 =A0 =A0 =A0if (r =3D=3D NULL) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENODEV;
> @@ -1169,10 +1156,8 @@ static int __devinit omap2_mcspi_probe(struct plat=
form_device *pdev)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0mcspi->dev =3D &pdev->dev;
> - =A0 =A0 =A0 INIT_WORK(&mcspi->work, omap2_mcspi_work);
>
> =A0 =A0 =A0 =A0spin_lock_init(&mcspi->lock);
> - =A0 =A0 =A0 INIT_LIST_HEAD(&mcspi->msg_queue);
> =A0 =A0 =A0 =A0INIT_LIST_HEAD(&mcspi->ctx.cs);
>
> =A0 =A0 =A0 =A0mcspi->dma_channels =3D kcalloc(master->num_chipselect,
> @@ -1253,7 +1238,6 @@ static int __devexit omap2_mcspi_remove(struct plat=
form_device *pdev)
>
> =A0 =A0 =A0 =A0spi_unregister_master(master);
> =A0 =A0 =A0 =A0kfree(dma_channels);
> - =A0 =A0 =A0 destroy_workqueue(mcspi->wq);
> =A0 =A0 =A0 =A0platform_set_drvdata(pdev, NULL);
>
> =A0 =A0 =A0 =A0return 0;
> --
> 1.7.5.4
>
>
> -------------------------------------------------------------------------=
-----
> Live Security Virtual Conference
> Exclusive live event will cover all the ways today's security and
> threat landscape has changed and how IT managers can respond. Discussions
> will include endpoint security, mobile security and the latest in malware
> threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
