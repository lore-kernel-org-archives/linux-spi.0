From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] spi: Unlock a spinlock before calling into the controller driver.
Date: Sun, 24 Jun 2012 16:54:55 -0700
Message-ID: <CAOesGMgq5HRz+pDFQtED5GPN0RUrON=_k_y4YHHzKrMkHnVk4A@mail.gmail.com>
References: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net, grant.likely@secretlab.ca,
	linux-kernel@vger.kernel.org, LinusW <linus.walleij@linaro.org>,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Bryan Freed <bfreed@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1340409205-23606-1-git-send-email-bfreed@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi,

(Adding Linus Walleij and Mark Brown since they were the ones doing
the queue changes).

On Fri, Jun 22, 2012 at 4:53 PM, Bryan Freed <bfreed@chromium.org> wrot=
e:
> spi_pump_messages() calls into a controller driver with
> unprepare_transfer_hardware() which is documented as "This may sleep"=
=2E
> As in the prepare_transfer_hardware() call below, we should release t=
he
> queue_lock spinlock before making the call.
> Rework the logic a bit to hold queue_lock to protect the 'busy' flag,
> then release it to call unprepare_transfer_hardware().
>
> Signed-off-by: Bryan Freed <bfreed@chromium.org>
>
> ---
> =A0drivers/spi/spi.c | =A0 15 +++++++--------
> =A01 files changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index fc0da39..f7f9df9 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -532,17 +532,16 @@ static void spi_pump_messages(struct kthread_wo=
rk *work)
> =A0 =A0 =A0 =A0/* Lock queue and check for queue work */
> =A0 =A0 =A0 =A0spin_lock_irqsave(&master->queue_lock, flags);
> =A0 =A0 =A0 =A0if (list_empty(&master->queue) || !master->running) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (master->busy && master->unprepare_t=
ransfer_hardware) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D master->unprepa=
re_transfer_hardware(master);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_un=
lock_irqrestore(&master->queue_lock, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err=
(&master->dev,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "failed to unprepare transfer hardware\n");
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!master->busy) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(=
&master->queue_lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0master->busy =3D false;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&master->queue_=
lock, flags);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (master->unprepare_transfer_hardware=
 &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->unprepare_transfer_hard=
ware(master))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&master->dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "failed=
 to unprepare transfer hardware\n");


I'm not sure this is safe to do. The lock is dropped for the prepare
side, but in that case we can be sure that the above code can't come
in and unprepare at the same time since there is per definition a
request on the queue at that time.

On the other hand, between the lock drop and the call to unprepare
above, another code path can come in and queue up a request and either
not do prepare properly, or there will be a prepare that races with
the unprepare.

It might make more sense to use a workqueue here and schedule a
unprepare call that way instead (and cancelling appropriately before
the prepare call if needed). I'm open for other suggestions as well.


-Olof
