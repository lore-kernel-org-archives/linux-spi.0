From: Sonic Zhang <sonic.adi@gmail.com>
Subject: Re: [PATCH v2] spi:spi_bfin5xx: SPI SSEL deasserted too early in soft
 irq mode.
Date: Tue, 23 Aug 2011 16:16:51 +0800
Message-ID: <CAJxxZ0ME9vKgLHbFA1ZmuYRwfNvQaojDLhgBbeMa9qcoWj7-7Q@mail.gmail.com>
References: <1313117333-26763-1-git-send-email-sonic.adi@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: spi-devel-general@lists.sourceforge.net,
	LKML <linux-kernel@vger.kernel.org>,
	uclinux-dist-devel@blackfin.uclinux.org,
	Sonic Zhang <sonic.zhang@analog.com>
To: Grant Likely <grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1313117333-26763-1-git-send-email-sonic.adi@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Grant,

Any comments?


Sonic Zhang

On Fri, Aug 12, 2011 at 10:48 AM, Sonic Zhang <sonic.adi@gmail.com> wro=
te:
> From: Sonic Zhang <sonic.zhang@analog.com>
>
> Poll the FIFO till it is empty before deassert SSEL in pump_transfers=
 in
> soft irq mode. No polling is necessary in interrupt mode and error ha=
ndling.
>
> Signed-off-by: Sonic Zhang <sonic.zhang@analog.com>
> ---
> =A0drivers/spi/spi-bfin5xx.c | =A0 =A05 ++++-
> =A01 files changed, 4 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/spi/spi-bfin5xx.c b/drivers/spi/spi-bfin5xx.c
> index b8d25f2..7e03e7d 100644
> --- a/drivers/spi/spi-bfin5xx.c
> +++ b/drivers/spi/spi-bfin5xx.c
> @@ -587,6 +587,7 @@ static void bfin_spi_pump_transfers(unsigned long=
 data)
> =A0 =A0 =A0 =A0if (message->state =3D=3D DONE_STATE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&drv_data->pdev->dev, "transfe=
r: all done!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0message->status =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bfin_spi_flush(drv_data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bfin_spi_giveback(drv_data);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -870,8 +871,10 @@ static void bfin_spi_pump_transfers(unsigned lon=
g data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0message->actual_length +=3D drv_data->=
len_in_bytes;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Move to next transfer of this msg *=
/
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0message->state =3D bfin_spi_next_trans=
fer(drv_data);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_data->cs_change)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_data->cs_change) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bfin_spi_flush(drv_data=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bfin_spi_cs_deactive(d=
rv_data, chip);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Schedule next transfer tasklet */
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
