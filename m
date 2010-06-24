From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi/omap2_mcspi: disable and enable
	chan between each SPI transfer
Date: Thu, 24 Jun 2010 09:12:06 -0600
Message-ID: <AANLkTin7mqe_zJIbyDcRPpCLaxPhl_dZQrSGua2z1nYW@mail.gmail.com>
References: <1277381565-6305-1-git-send-email-jason77.wang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	roman.tereshonkov-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1277381565-6305-1-git-send-email-jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jun 24, 2010 at 6:12 AM, Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> In current design, the SPI channel is always enable during the period
> of handling a SPI message, it is risky when more than one SPI transfer
> are included in a message. Current working route like that:
> [
> =A0SPI channel enable
> =A0configure channel
> =A0handle transfer #1
> =A0configure channel
> =A0handle transfer #2
> =A0...
> =A0SPI channel disable
> ]
> If we can disable channel before configure it and reenable
> channel after it is configured, it will be more safe.
>
> The commit a330ce2 "omap2_mcspi: Flush posted writes" make this risk
> to a real problem for ads7846 driver on omap3530evm. The
> ads7846 driver will send a SPI messge which includes,
> [
> =A0TX_ONLY transfer (1 byte)
> =A0RX_ONLY transfer (2 bytes)
> =A0TX_ONLY transfer (1 byte)
> =A0RX_ONLY transfer (2 bytes)
> ]
> If we don't add disable/reenable channel between TX and RX transfers,
> the RX transfer will get wrong datas sent from slave.

I don't understand the problem description.  Are you talking about
manipulation of the SS line, or a problem with the internal state on
the mcspi controller device?  What is the cause of the wrong data (ie.
is there a protocol error on the wire, or is the SPI controller not
performing the read correctly?)

Thanks,
g.

>
> Signed-off-by: Jason Wang <jason77.wang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
> =A0drivers/spi/omap2_mcspi.c | =A0 16 ++++++----------
> =A01 files changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/spi/omap2_mcspi.c b/drivers/spi/omap2_mcspi.c
> index b3a94ca..1e3cb7b 100644
> --- a/drivers/spi/omap2_mcspi.c
> +++ b/drivers/spi/omap2_mcspi.c
> @@ -408,7 +408,6 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct s=
pi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0count -=3D=
 (word_len <=3D 8) =A0? 2 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0(word_len <=3D 16) ? 4 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0/* word_len <=3D 32 */ 8;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi=
_set_enable(spi, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cou=
nt;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -430,8 +429,10 @@ omap2_mcspi_txrx_dma(struct spi_device *spi, struct =
spi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (word_len=
 <=3D 16) ? 2 :
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* word_len <=
=3D 32 */ 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
> +
> =A0 =A0 =A0 =A0return count;
> =A0}
>
> @@ -517,8 +518,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct s=
pi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0c =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (=
c =3D=3D 0 && tx =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap2_mcspi_set_enable(spi, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx++ =3D =
__raw_readl(rx_reg);
> @@ -570,8 +569,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct s=
pi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0c =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (=
c =3D=3D 0 && tx =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap2_mcspi_set_enable(spi, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx++ =3D =
__raw_readl(rx_reg);
> @@ -623,8 +620,6 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct s=
pi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0goto out;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0c =3D 0;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (=
c =3D=3D 0 && tx =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 omap2_mcspi_set_enable(spi, 0);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*rx++ =3D =
__raw_readl(rx_reg);
> @@ -646,7 +641,7 @@ omap2_mcspi_txrx_pio(struct spi_device *spi, struct s=
pi_transfer *xfer)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev, "EOT ti=
med out\n");
> =A0 =A0 =A0 =A0}
> =A0out:
> - =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> + =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 0);
> =A0 =A0 =A0 =A0return count - c;
> =A0}
>
> @@ -894,7 +889,6 @@ static void omap2_mcspi_work(struct work_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cs =3D spi->controller_state;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cd =3D spi->controller_data;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi, 1);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0list_for_each_entry(t, &m->transfers, tran=
sfer_list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->tx_buf =3D=3D NULL =
&& t->rx_buf =3D=3D NULL && t->len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D=
 -EINVAL;
> @@ -931,6 +925,8 @@ static void omap2_mcspi_work(struct work_struct *work)
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mcspi_write_chconf0(spi, c=
hconf);
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap2_mcspi_set_enable(spi,=
 1);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned =
=A0 =A0 =A0 =A0count;
>
> --
> 1.5.6.5
>
>



-- =

Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

---------------------------------------------------------------------------=
---
ThinkGeek and WIRED's GeekDad team up for the Ultimate =

GeekDad Father's Day Giveaway. ONE MASSIVE PRIZE to the =

lucky parental unit.  See the prize list and enter to win: =

http://p.sf.net/sfu/thinkgeek-promo
