From: Thomas De Schampheleire <patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] FSL eSPI driver: fix byte-vs-character and receive buffer
	problems
Date: Fri, 29 Jul 2011 17:17:32 +0200
Message-ID: <CAAXf6LUVK0JPk_zGuWnRXyLbKJRCAtr3BUoUH7wJzvR1abMVWg@mail.gmail.com>
References: <60740d4b3d09a322a975.1311078082@localhost6.localdomain6>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: derek.kwindt-cfy2TCaE7SFv+uJa97DSA9BPR1lH4CV8@public.gmane.org, ronny.meeus-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
To: Mingkai Hu <Mingkai.hu-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, kumar.gala-KZfg59tc24xl57MIdRCFDg@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <60740d4b3d09a322a975.1311078082-bi+AKbBUZKagILUCTcTcHdKyNwTtLsGr@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Jul 19, 2011 at 2:21 PM, Thomas De Schampheleire
<patrickdepinguin+spidevel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> The Freescale eSPI driver has several problems related to transaction
> counting and receive buffer offset.
> - The len field in struct spi_transfer is counted in bytes, while the TRA=
NLEN
> =A0field in the eSPI controller is counted in characters. The relation be=
tween
> =A0both is given by the bits_per_word variable. The original driver always
> =A0used t->len for TRANLEN, which is not correct when bits_per_word is la=
rger
> =A0than 8.
> - The interrupt handler allowed the remaining bytes (mspi->len) to become
> =A0negative, due to an unconditional -4 even when the number of bytes rec=
eived
> =A0was less. Additionally, the interrupt handler incorrectly assumed that=
 with
> =A0each interrupt only one character was transmitted. This was not the ca=
se
> =A0since fsl_espi_cpu_bufs() always transmits in blocks of 32 bit, which =
is
> =A0always more than one character (the exact number depending on
> =A0bits_per_word).
> - In fsl_espi_do_one_msg(), the driver sets the length of the transfer be=
ing
> =A0prepared as (n_tx + n_rx), which is incorrect since these are full-dup=
lex
> =A0transactions. Moreover, the bytes received from the controller where w=
ritten
> =A0at the wrong offset in the driver's receive buffer. Specifically, they=
 were
> =A0written n_tx too far.
>
> Signed-off-by: Thomas De Schampheleire <thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>
> ---
>
> Note that this patch is against an earlier version of the eSPI driver tha=
n the
> one which is currently in the Linux tree. The aspects of the driver that =
I changed
> are still relevant for the new version though.
> I would like to get some feedback from the original author (Mingkai Hu) or
> others, to verify my changes in other conditions. I have tested 8 and 16 =
bit
> transfers on a temperature sensor and an EEPROM device, but do not have
> devices accepting other bits_per_word values.

Mingkai, Kumar,

Could you review these changes please?
Is it possible that the driver was only tested for 8-bit devices?

Thanks,
Thomas


>
>
> =A0spi_fsl_espi.c | =A0 37 +++++++++++++++++++++++++------------
> =A0spi_fsl_lib.h =A0| =A0 =A01 +
> =A02 files changed, 26 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/spi/spi_fsl_espi.c b/drivers/spi/spi_fsl_espi.c
> --- a/drivers/spi/spi_fsl_espi.c
> +++ b/drivers/spi/spi_fsl_espi.c
> @@ -212,7 +212,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bool is_dma_mapped)
> =A0{
> =A0 =A0 =A0 =A0struct mpc8xxx_spi *mpc8xxx_spi =3D spi_master_get_devdata=
(spi->master);
> - =A0 =A0 =A0 unsigned int len =3D t->len;
> + =A0 =A0 =A0 unsigned int count;
> =A0 =A0 =A0 =A0u8 bits_per_word;
> =A0 =A0 =A0 =A0int ret;
>
> @@ -221,23 +221,31 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bits_per_word =3D t->bits_per_word;
>
> =A0 =A0 =A0 =A0mpc8xxx_spi->len =3D t->len;
> - =A0 =A0 =A0 len =3D roundup(len, 4) / 4;
> -
> =A0 =A0 =A0 =A0mpc8xxx_spi->tx =3D t->tx_buf;
> =A0 =A0 =A0 =A0mpc8xxx_spi->rx =3D t->rx_buf;
> + =A0 =A0 =A0 mpc8xxx_spi->bits_per_word =3D bits_per_word;
>
> =A0 =A0 =A0 =A0INIT_COMPLETION(mpc8xxx_spi->done);
>
> + =A0 =A0 =A0 /* Convert between t->len (in bytes) and count (in characte=
rs) */
> + =A0 =A0 =A0 if (bits_per_word <=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D t->len;
> + =A0 =A0 =A0 } else if (bits_per_word <=3D 16) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 count =3D t->len >> 1;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0/* Set SPCOM[CS] and SPCOM[TRANLEN] field */
> - =A0 =A0 =A0 if ((t->len - 1) > SPCOM_TRANLEN_MAX) {
> + =A0 =A0 =A0 if ((count - 1) > SPCOM_TRANLEN_MAX) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(mpc8xxx_spi->dev, "Transaction len=
gth (%d)"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " beyond th=
e SPCOM[TRANLEN] field\n", t->len);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " beyond th=
e SPCOM[TRANLEN] field\n", count);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0mpc8xxx_spi_write_reg(&mpc8xxx_spi->espi_base->command,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN=
(t->len - 1)));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (SPCOM_CS(spi->chip_select) | SPCOM_TRANLEN=
(count - 1)));
>
> - =A0 =A0 =A0 ret =3D fsl_espi_cpu_bufs(mpc8xxx_spi, t, len);
> + =A0 =A0 =A0 ret =3D fsl_espi_cpu_bufs(mpc8xxx_spi, t, count);
> =A0 =A0 =A0 =A0if (ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> @@ -301,7 +309,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 trans.len =3D n_tx + n_rx;
> + =A0 =A0 =A0 trans.len =3D n_tx;
> =A0 =A0 =A0 =A0trans.tx_buf =3D local_buf;
> =A0 =A0 =A0 =A0trans.rx_buf =3D local_buf + n_tx;
> =A0 =A0 =A0 =A0spi_message_add_tail(&trans, &message);
> @@ -324,7 +332,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0m->actual_length +=3D t->len;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (rx_buf)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(rx_buf, t->rx_buf + =
n_tx, n_rx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 memcpy(rx_buf, t->rx_buf, n=
_rx);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (t->delay_usecs)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0udelay(t->delay_usecs);
> @@ -402,6 +410,7 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mspi->len >=3D 4) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_data =3D mpc8xxx_spi_re=
ad_reg(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0&mspi->espi_base->receive);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mspi->len -=3D 4;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmp =3D mspi->len;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_data =3D 0;
> @@ -412,10 +421,9 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rx_data <<=3D (4 - mspi->l=
en) * 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mspi->len =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mspi->len -=3D 4;
> -
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mspi->rx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mspi->get_rx(rx_data, mspi=
);
> =A0 =A0 =A0 =A0}
> @@ -430,7 +438,12 @@
> =A0 =A0 =A0 =A0/* Clear the events */
> =A0 =A0 =A0 =A0mpc8xxx_spi_write_reg(&mspi->espi_base->event, events);
>
> - =A0 =A0 =A0 mspi->count -=3D 1;
> + =A0 =A0 =A0 if (mspi->bits_per_word <=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mspi->count =3D mspi->len;
> + =A0 =A0 =A0 } else if (mspi->bits_per_word <=3D 16) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mspi->count =3D mspi->len >> 1;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0if (mspi->count) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 word =3D mspi->get_tx(mspi);
>
> diff --git a/drivers/spi/spi_fsl_lib.h b/drivers/spi/spi_fsl_lib.h
> --- a/drivers/spi/spi_fsl_lib.h
> +++ b/drivers/spi/spi_fsl_lib.h
> @@ -56,6 +56,7 @@
> =A0 =A0 =A0 =A0void (*spi_remove) (struct mpc8xxx_spi *mspi);
>
> =A0 =A0 =A0 =A0unsigned int count;
> + =A0 =A0 =A0 u8 bits_per_word;
> =A0 =A0 =A0 =A0unsigned int irq;
>
> =A0 =A0 =A0 =A0unsigned nsecs; =A0 =A0 =A0 =A0 /* (clock cycle time)/2 */
>

---------------------------------------------------------------------------=
---
Got Input?   Slashdot Needs You.
Take our quick survey online.  Come on, we don't ask for help often.
Plus, you'll get a chance to win $100 to spend on ThinkGeek.
http://p.sf.net/sfu/slashdot-survey
