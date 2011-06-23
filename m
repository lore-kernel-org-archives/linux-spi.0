From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 08/11] spi-dw: Ensure fifo lenght is set.
Date: Wed, 22 Jun 2011 21:55:22 -0600
Message-ID: <BANLkTi=Jv2aVuHqVXh77aGxMFV_Q_wXQCg@mail.gmail.com>
References: <1308794413-11069-1-git-send-email-dirk.brandewie@gmail.com> <1308794413-11069-9-git-send-email-dirk.brandewie@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
To: dirk.brandewie@gmail.com
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1308794413-11069-9-git-send-email-dirk.brandewie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jun 22, 2011 at 8:00 PM,  <dirk.brandewie@gmail.com> wrote:
> From: Dirk Brandewie <dirk.brandewie@gmail.com>
>
> Bug on fifo_len not being set. =A0The fifo sizing routine does not wo=
rk
> since the txfltr register can not be written while the controller is
> enabled. The max value of txfltr can be larger than the fifo. =A0The
> register allows values upto 0x3f (63) the fifo depth on the Intel
> SOC's if 40
>
> Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
> ---
> =A0drivers/spi/spi-dw.c | =A0 18 ++----------------
> =A01 files changed, 2 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/spi/spi-dw.c b/drivers/spi/spi-dw.c
> index ad92826..cc38aa0 100644
> --- a/drivers/spi/spi-dw.c
> +++ b/drivers/spi/spi-dw.c
> @@ -776,25 +776,11 @@ static int destroy_queue(struct spi_dw *dws)
> =A0/* Restart the controller, disable all interrupts, clean rx fifo *=
/
> =A0static void spi_dw_hw_init(struct spi_dw *dws)
> =A0{
> + =A0 =A0 =A0 BUG_ON(!dws->fifo_len);
> +

Ditto here.  BUG is too big a reaction.  Fail to initialize the
device, sure, and print a warning, but don't BUG.

g.

> =A0 =A0 =A0 =A0spi_dw_disable(dws);
> =A0 =A0 =A0 =A0spi_dw_mask_intr(dws, 0xff);
> =A0 =A0 =A0 =A0spi_dw_enable(dws);
> -
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Try to detect the FIFO depth if not set by interfa=
ce driver,
> - =A0 =A0 =A0 =A0* the depth could be from 2 to 256 from HW spec
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!dws->fifo_len) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 fifo;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 for (fifo =3D 2; fifo <=3D 257; fifo++)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_writew(dws, txfltr, =
fifo);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (fifo !=3D dw_readw(=
dws, txfltr))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> -
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dws->fifo_len =3D (fifo =3D=3D 257) ? 0=
 : fifo;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_writew(dws, txfltr, 0);
> - =A0 =A0 =A0 }
> =A0}
>
> =A0int __devinit spi_dw_add_host(struct spi_dw *dws)
> --
> 1.7.3.4
>
>
> ---------------------------------------------------------------------=
---------
> Simplify data backup and recovery for your virtual environment with v=
Ranger.
> Installation's a snap, and flexible recovery options mean your data i=
s safe,
> secure and there when you need it. Data protection magic?
> Nope - It's vRanger. Get your free trial download today.
> http://p.sf.net/sfu/quest-sfdev2dev
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
