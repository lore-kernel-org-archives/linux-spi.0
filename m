From: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: resend: [PATCH] amba_pl022: Setup SPI configuration based on spi->mode
Date: Fri, 10 Sep 2010 15:57:57 -0700
Message-ID: <AANLkTikbKwo9=xLWo1qEcc2E5aa2iN2F_KCokJPpnWOk__46844.1500132487$1284159527$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Lukasz.Baj-++hxYGjEMp0AvxtiuMwx3w@public.gmane.org
To: sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, rabin.vincent-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org,
	linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org, srinidhi.kasagar-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org,
	u.kleine-k
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

(Re-send with full distribution list)

This patch changes the way SPI transfers are setup. The previous
method uses the pl022_config_chip data for configuration of
loopback mode, edge count, clock polarity, number of data bits,
and bit transfer order. This change configures these parameters
based on spi->mode passed via master->setup and will allow the
drivers use SPI to configure the interface.

The fields lbm, clk_phase, clk_pol, and data_size are no longer
needed. For the ST/pl023 setup, the first bit transferred for
both RX and TX is now selected with the SPI_LSB_FIRST flag in
spi->mode.

There are also several very minor cleanups in the patch that
fix return status on setup failures.

This has been tested with the AT25 serial EEPROM driver and
spidev modes 0-3 with loopback and varying data sizes.

Reported-by: Quentin Yang <quentinyang05-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Signed-off-by: Kevin Wells <wellsk40-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
=A0drivers/spi/amba-pl022.c | =A0121 ++++++++++++++++++++------------------=
--------
=A01 files changed, 53 insertions(+), 68 deletions(-)

diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
index acd35d1..1be488a 100644
--- a/drivers/spi/amba-pl022.c
+++ b/drivers/spi/amba-pl022.c
@@ -1248,12 +1248,6 @@ static int destroy_queue(struct pl022 *pl022)
=A0static int verify_controller_parameters(struct pl022 *pl022,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0struct pl022_config_chip *chip_info)
=A0{
- =A0 =A0 =A0 if ((chip_info->lbm !=3D LOOPBACK_ENABLED)
- =A0 =A0 =A0 =A0 =A0 && (chip_info->lbm !=3D LOOPBACK_DISABLED)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "loopback Mode is configured =
incorrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 }
=A0 =A0 =A0 =A0if ((chip_info->iface < SSP_INTERFACE_MOTOROLA_SPI)
=A0 =A0 =A0 =A0 =A0 =A0|| (chip_info->iface > SSP_INTERFACE_UNIDIRECTIONAL)=
) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(chip_info->dev,
@@ -1279,24 +1273,6 @@ static int verify_controller_parameters(struct
pl022 *pl022,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"cpsdvsr is configured incor=
rectly\n");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
=A0 =A0 =A0 =A0}
- =A0 =A0 =A0 if ((chip_info->endian_rx !=3D SSP_RX_MSB)
- =A0 =A0 =A0 =A0 =A0 && (chip_info->endian_rx !=3D SSP_RX_LSB)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "RX FIFO endianess is configu=
red incorrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 }
- =A0 =A0 =A0 if ((chip_info->endian_tx !=3D SSP_TX_MSB)
- =A0 =A0 =A0 =A0 =A0 && (chip_info->endian_tx !=3D SSP_TX_LSB)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "TX FIFO endianess is configu=
red incorrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 }
- =A0 =A0 =A0 if ((chip_info->data_size < SSP_DATA_BITS_4)
- =A0 =A0 =A0 =A0 =A0 || (chip_info->data_size > SSP_DATA_BITS_32)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "DATA Size is configured inco=
rrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 }
=A0 =A0 =A0 =A0if ((chip_info->com_mode !=3D INTERRUPT_TRANSFER)
=A0 =A0 =A0 =A0 =A0 =A0&& (chip_info->com_mode !=3D DMA_TRANSFER)
=A0 =A0 =A0 =A0 =A0 =A0&& (chip_info->com_mode !=3D POLLING_TRANSFER)) {
@@ -1316,20 +1292,6 @@ static int verify_controller_parameters(struct
pl022 *pl022,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"TX FIFO Trigger Level is co=
nfigured incorrectly\n");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
=A0 =A0 =A0 =A0}
- =A0 =A0 =A0 if (chip_info->iface =3D=3D SSP_INTERFACE_MOTOROLA_SPI) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((chip_info->clk_phase !=3D SSP_CLK_FIRST_=
EDGE)
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (chip_info->clk_phase !=3D SSP_CLK=
_SECOND_EDGE)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Clock Phase =
is configured incorrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((chip_info->clk_pol !=3D SSP_CLK_POL_IDLE=
_LOW)
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 && (chip_info->clk_pol !=3D SSP_CLK_P=
OL_IDLE_HIGH)) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(chip_info->dev,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "Clock Polari=
ty is configured incorrectly\n");
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
- =A0 =A0 =A0 }
=A0 =A0 =A0 =A0if (chip_info->iface =3D=3D SSP_INTERFACE_NATIONAL_MICROWIRE=
) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((chip_info->ctrl_len < SSP_BITS_4)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|| (chip_info->ctrl_len > SSP_BITS_3=
2)) {
@@ -1494,23 +1456,14 @@ static int process_dma_info(struct
pl022_config_chip *chip_info,
=A0* controller hardware here, that is not done until the actual transfer
=A0* commence.
=A0*/
-
-/* FIXME: JUST GUESSING the spi->mode bits understood by this driver */
-#define MODEBITS =A0 =A0 =A0 (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH \
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | SPI_LSB_FIRST | SPI_LOOP)
-
=A0static int pl022_setup(struct spi_device *spi)
=A0{
=A0 =A0 =A0 =A0struct pl022_config_chip *chip_info;
=A0 =A0 =A0 =A0struct chip_data *chip;
=A0 =A0 =A0 =A0int status =3D 0;
=A0 =A0 =A0 =A0struct pl022 *pl022 =3D spi_master_get_devdata(spi->master);
-
- =A0 =A0 =A0 if (spi->mode & ~MODEBITS) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "unsupported mode bits %x\=
n",
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spi->mode & ~MODEBITS);
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
- =A0 =A0 =A0 }
+ =A0 =A0 =A0 unsigned int bits =3D spi->bits_per_word;
+ =A0 =A0 =A0 u32 tmp;

=A0 =A0 =A0 =A0if (!spi->max_speed_hz)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
@@ -1555,18 +1508,12 @@ static int pl022_setup(struct spi_device *spi)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Set controller data default values:
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Polling is supported by default
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->lbm =3D LOOPBACK_DISABLED;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->com_mode =3D POLLING_TRANSFER;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->iface =3D SSP_INTERFACE_MOTOROLA_=
SPI;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->hierarchy =3D SSP_SLAVE;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->slave_tx_disable =3D DO_NOT_DRIVE=
_TX;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->endian_tx =3D SSP_TX_LSB;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->endian_rx =3D SSP_RX_LSB;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->data_size =3D SSP_DATA_BITS_12;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->rx_lev_trig =3D SSP_RX_1_OR_MORE_=
ELEM;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->tx_lev_trig =3D SSP_TX_1_OR_MORE_=
EMPTY_LOC;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->clk_phase =3D SSP_CLK_SECOND_EDGE;
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 chip_info->clk_pol =3D SSP_CLK_POL_IDLE_LOW;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->ctrl_len =3D SSP_BITS_8;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->wait_state =3D SSP_MWIRE_WAIT_ZER=
O;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip_info->duplex =3D SSP_MICROWIRE_CHANNEL_=
FULL_DUPLEX;
@@ -1601,12 +1548,16 @@ static int pl022_setup(struct spi_device *spi)
=A0 =A0 =A0 =A0chip->xfer_type =3D chip_info->com_mode;
=A0 =A0 =A0 =A0chip->cs_control =3D chip_info->cs_control;

- =A0 =A0 =A0 if (chip_info->data_size <=3D 8) {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "1 <=3D n <=3D8 bits per w=
ord\n");
+ =A0 =A0 =A0 if (bits <=3D 3) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PL022 doesn't support less than 4-bits */
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOTSUPP;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_config_params;
+ =A0 =A0 =A0 } else if (bits <=3D 8) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&spi->dev, "4 <=3D n <=3D8 bits per w=
ord\n");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->n_bytes =3D 1;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->read =3D READING_U8;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->write =3D WRITING_U8;
- =A0 =A0 =A0 } else if (chip_info->data_size <=3D 16) {
+ =A0 =A0 =A0 } else if (bits <=3D 16) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&spi->dev, "9 <=3D n <=3D 16 bits pe=
r word\n");
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->n_bytes =3D 2;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0chip->read =3D READING_U16;
@@ -1623,6 +1574,7 @@ static int pl022_setup(struct spi_device *spi)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_err(&spi->dev,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"a standard =
pl022 can only handle "
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"1 <=3D n <=
=3D 16 bit words\n");
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D -ENOTSUPP;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_config_params;
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
=A0 =A0 =A0 =A0}
@@ -1656,6 +1608,8 @@ static int pl022_setup(struct spi_device *spi)

=A0 =A0 =A0 =A0/* Special setup for the ST micro extended control registers=
 */
=A0 =A0 =A0 =A0if (pl022->vendor->extended_cr) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 u32 etx;
+
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (pl022->vendor->pl023) {
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* These bits are only in th=
e PL023 */
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, ch=
ip_info->clkdelay,
@@ -1671,29 +1625,51 @@ static int pl022_setup(struct spi_device *spi)
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, ch=
ip_info->wait_state,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 SSP_CR1_MASK_MWAIT_ST, 6);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, chip_info->data_siz=
e,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, bits - 1,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR0_MASK_DS=
S_ST, 0);
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, chip_info->endian_r=
x,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_CR1_MASK_R=
ENDN_ST, 4);
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, chip_info->endian_t=
x,
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_CR1_MASK_T=
ENDN_ST, 5);
+
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->mode & SPI_LSB_FIRST) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_RX_LSB;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etx =3D SSP_TX_LSB;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_RX_MSB;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 etx =3D SSP_TX_MSB;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, tmp, SSP_CR1_MASK_R=
ENDN_ST, 4);
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, etx, SSP_CR1_MASK_T=
ENDN_ST, 5);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, chip_info->rx_lev_=
trig,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR1_MASK_RX=
IFLSEL_ST, 7);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, chip_info->tx_lev_=
trig,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR1_MASK_TX=
IFLSEL_ST, 10);
=A0 =A0 =A0 =A0} else {
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, chip_info->data_siz=
e,
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, bits - 1,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR0_MASK_DS=
S, 0);
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr0, chip_info->iface,
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_CR0_MASK_FR=
F, 4);
=A0 =A0 =A0 =A0}
+
=A0 =A0 =A0 =A0/* Stuff that is common for all versions */
- =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, chip_info->clk_pol, SSP_CR0_MASK_SP=
O, 6);
- =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, chip_info->clk_phase, SSP_CR0_MASK_=
SPH, 7);
+ =A0 =A0 =A0 if (spi->mode & SPI_CPOL)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_POL_IDLE_HIGH;
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_POL_IDLE_LOW;
+ =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPO, 6);
+
+ =A0 =A0 =A0 if (spi->mode & SPI_CPHA)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_SECOND_EDGE;
+ =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D SSP_CLK_FIRST_EDGE;
+ =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr0, tmp, SSP_CR0_MASK_SPH, 6);
+
=A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr0, chip_info->clk_freq.scr, SSP_CR0_M=
ASK_SCR, 8);
=A0 =A0 =A0 =A0/* Loopback is available on all versions except PL023 */
- =A0 =A0 =A0 if (!pl022->vendor->pl023)
- =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, chip_info->lbm, SSP=
_CR1_MASK_LBM, 0);
+ =A0 =A0 =A0 if (!pl022->vendor->pl023) {
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi->mode & SPI_LOOP)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D LOOPBACK_ENABLED;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tmp =3D LOOPBACK_DISABLED;
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 SSP_WRITE_BITS(chip->cr1, tmp, SSP_CR1_MASK_L=
BM, 0);
+ =A0 =A0 =A0 }
=A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, SSP_DISABLED, SSP_CR1_MASK_SSE, 1);
=A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, chip_info->hierarchy, SSP_CR1_MASK=
_MS, 2);
=A0 =A0 =A0 =A0SSP_WRITE_BITS(chip->cr1, chip_info->slave_tx_disable,
SSP_CR1_MASK_SOD, 3);
@@ -1702,6 +1678,7 @@ static int pl022_setup(struct spi_device *spi)
=A0 =A0 =A0 =A0spi_set_ctldata(spi, chip);
=A0 =A0 =A0 =A0return status;
=A0err_config_params:
+ =A0 =A0 =A0 spi_set_ctldata(spi, NULL);
=A0err_first_setup:
=A0 =A0 =A0 =A0kfree(chip);
=A0 =A0 =A0 =A0return status;
@@ -1764,6 +1741,14 @@ pl022_probe(struct amba_device *adev, struct amba_id=
 *id)
=A0 =A0 =A0 =A0master->setup =3D pl022_setup;
=A0 =A0 =A0 =A0master->transfer =3D pl022_transfer;

+ =A0 =A0 =A0 /*
+ =A0 =A0 =A0 =A0* Supports mode 0-3, loopback, and active low CS. Transfer=
s are
+ =A0 =A0 =A0 =A0* always MS bit first on the original pl022.
+ =A0 =A0 =A0 =A0*/
+ =A0 =A0 =A0 master->mode_bits =3D SPI_CPOL | SPI_CPHA | SPI_CS_HIGH | SPI=
_LOOP;
+ =A0 =A0 =A0 if (pl022->vendor->extended_cr)
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 master->mode_bits |=3D SPI_LSB_FIRST;
+
=A0 =A0 =A0 =A0dev_dbg(&adev->dev, "BUSNO: %d\n", master->bus_num);

=A0 =A0 =A0 =A0status =3D amba_request_regions(adev, NULL);
--
1.7.2.2

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev
