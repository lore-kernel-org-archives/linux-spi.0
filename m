From: Linus Walleij <linus.ml.walleij@gmail.com>
Subject: Re: [PATCH] Topcliff: Update PCH_SPI driver to 2.6.35
Date: Thu, 19 Aug 2010 09:31:58 +0200
Message-ID: <AANLkTinue_L8-E8Jqz=dZ4jRcE-4=in-Wb7YS=iL0_KM@mail.gmail.com>
References: <4C61EBAC.4000009@dsn.okisemi.com>
	<AANLkTikyz_RVcCeKzf9m10xXDyKZm3+Yy7y+axZN+MMx@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: meego-dev@meego.com, LKML <linux-kernel@vger.kernel.org>,
	David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net, qi.wang@intel.com,
	yong.y.wang@intel.com, andrew.chih.howe.khor@intel.com,
	arjan@linux.intel.com, gregkh@suse.de,
	Grant Likely <grant.likely@secretlab.ca>
To: Masayuki Ohtak <masa-korg@dsn.okisemi.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTikyz_RVcCeKzf9m10xXDyKZm3+Yy7y+axZN+MMx@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Masayuki,

Can't find the orginal patch on LKML or SPI-dev so guess it's on meego-=
dev.
I have to quote Grants comments to comment...

2010/8/14 Grant Likely <grant.likely@secretlab.ca>:
> 2010/8/10 Masayuki Ohtak <masa-korg@dsn.okisemi.com>:
>>(...)
>> +struct pch_spi_data {
>> + =A0 =A0 void __iomem *io_remap_addr;
>> + =A0 =A0 struct spi_master *p_master;

p_* is for "pointer" is it not? Hungarian notation is not liked in the
kernel, see Documentation/CodingStyle.

>> + =A0 =A0 struct work_struct work;
>> + =A0 =A0 struct workqueue_struct *p_wk_q;

Dito.

>> + =A0 =A0 wait_queue_head_t wait;
>> + =A0 =A0 u8 b_transfer_complete;
>> + =A0 =A0 u8 bcurrent_msg_processing;
>> + =A0 =A0 spinlock_t lock;
>> + =A0 =A0 struct list_head queue;
>> + =A0 =A0 u8 status;
>> + =A0 =A0 u32 bpw_len;
>> + =A0 =A0 s8 b_transfer_active;

This is hungarian notation again, signifying that this s8 (signed!)
should actually be a bool.

Change to bool and drop the b_ prefix.

>> + =A0 =A0 u32 tx_index;
>> + =A0 =A0 u32 rx_index;
>> + =A0 =A0 u16 *pkt_tx_buff;
>> + =A0 =A0 u16 *pkt_rx_buff;
>> + =A0 =A0 u8 n_curnt_chip;
>> + =A0 =A0 struct spi_device *p_current_chip;
>> + =A0 =A0 struct spi_message *p_current_msg;
>> + =A0 =A0 struct spi_transfer *p_cur_trans;
>> + =A0 =A0 struct pch_spi_board_data *p_board_dat;

The hungarian p_* prefix issue again.

>> +};
>> +
>> +/**
>> + * struct pch_spi_board_data - Holds the SPI device specific detail=
s
>> + * @pdev: =A0 =A0 =A0 =A0 =A0 =A0Pointer to the PCI device
>> + * @irq_reg_sts: =A0 =A0 Status of IRQ registration
>> + * @pci_req_sts: =A0 =A0 Status of pci_request_regions
>> + * @suspend_sts: =A0 =A0 Status of suspend
>> + * @p_data: =A0 =A0 =A0 =A0 =A0Pointer to SPI channel data structur=
e
>> + */
>> +struct pch_spi_board_data {
>> + =A0 =A0 struct pci_dev *pdev;

Hungarian p*?

>> + =A0 =A0 u8 irq_reg_sts;
>> + =A0 =A0 u8 pci_req_sts;
>> + =A0 =A0 u8 suspend_sts;
>> + =A0 =A0 struct pch_spi_data *p_data[PCH_MAX_DEV];

Hungarian p_*?

>> (...)
>> +/**
>> + * pch_spi_handler() - Interrupt handler
>> + * @irq: =A0 =A0 The interrupt number.
>> + * @dev_id: =A0Pointer to struct pch_spi_board_data.
>> + */
>> +static irqreturn_t pch_spi_handler(int irq, void *dev_id)
>> +{
>> + =A0 =A0 /*channel & read/write indices */
>> + =A0 =A0 int dev, read_cnt;
>> +
>> + =A0 =A0 /*SPSR content */
>> + =A0 =A0 u32 reg_spsr_val, reg_spcr_val;
>> +
>> + =A0 =A0 /*book keeping variables */
>> + =A0 =A0 u32 n_read, tx_index, rx_index, bpw_len;
>> +
>> + =A0 =A0 /*to hold channel data */
>> + =A0 =A0 struct pch_spi_data *p_data;

Hungarian p_*

>> +
>> + =A0 =A0 /*buffer to store rx/tx data */
>> + =A0 =A0 u16 *pkt_rx_buffer, *pkt_tx_buff;
>> +
>> + =A0 =A0 /*register addresses */
>> + =A0 =A0 void __iomem *spsr;
>> + =A0 =A0 void __iomem *spdrr;
>> + =A0 =A0 void __iomem *spdwr;
>> +
>> + =A0 =A0 /*remapped pci base address */
>> + =A0 =A0 void __iomem *io_remap_addr;
>> +
>> + =A0 =A0 irqreturn_t tRetVal =3D IRQ_NONE;

Horrible hungarian construct with t* prefix for "type",
And CamlCase. What's wrong with plain "ret"?

> nit: use lowercase for variable names.
>
>> +
>> + =A0 =A0 struct pch_spi_board_data *p_board_dat =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 (struct pch_spi_board_data *)dev_id;
>> +
>> + =A0 =A0 if (p_board_dat->suspend_sts =3D=3D true) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&p_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s return=
ing due to suspend\n", __func__);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 for (dev =3D 0; dev < PCH_MAX_DEV; dev++) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_data =3D p_board_dat->p_=
data[dev];
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 io_remap_addr =3D p_data->=
io_remap_addr;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spsr =3D io_remap_addr + P=
CH_SPSR;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reg_spsr_val =3D ioread32(=
spsr);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*Check if the interrupt i=
s for SPI device */
>> +

=46rom this point...

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg_spsr_val & (SPSR_F=
I_BIT | SPSR_RFI_BIT)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&p=
_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "SPSR =
in %s=3D%x\n", __func__, reg_spsr_val);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*clear in=
terrupt */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(=
reg_spsr_val, spsr);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (p_data=
->b_transfer_active =3D=3D true) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 rx_index =3D p_data->rx_index;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 tx_index =3D p_data->tx_index;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 bpw_len =3D p_data->bpw_len;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pkt_rx_buffer =3D p_data->pkt_rx_buff;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pkt_tx_buff =3D p_data->pkt_tx_buff;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spdrr =3D io_remap_addr + PCH_SPDRR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 spdwr =3D io_remap_addr + PCH_SPDWR;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 n_read =3D PCH_READABLE(reg_spsr_val);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 for (read_cnt =3D 0; (read_cnt < n_read);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0read_cnt++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 /*read data */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pkt_rx_buffer[rx_index++] =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(spdrr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 /*write data */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 if (tx_index < bpw_len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 iowrite32
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pkt_tx_buff
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[tx_index++],
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spdwr);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /*disable RFI if not needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if ((bpw_len - rx_index) <=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 PCH_MAX_FIFO_DEPTH) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 dev_dbg(&p_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%s disabling RFI as data "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "remaining=3D%d\n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 (bpw_len - rx_index));
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 reg_spcr_val =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 ioread32(io_remap_addr +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCH_SPCR);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 /*disable RFI */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 PCH_CLR_BITMSK(reg_spcr_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPCR_RFIE_BIT);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 /*reset rx threshold */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 reg_spcr_val &=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0MASK_RFIC_SPCR_BITS;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 reg_spcr_val |=3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (PCH_RX_THOLD_MAX <<
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPCR_RFIC_FIELD);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 iowrite32(PCH_CLR_BITMSK
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (reg_spcr_val,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SPCR_RFIE_BIT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (io_remap_addr +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 PCH_SPCR));
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /*update counts */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 p_data->tx_index =3D tx_index;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 p_data->rx_index =3D rx_index;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_dbg(&p_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "%s rx_index=3D%d tx_index=3D%d "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "nWritable=3D%d n_read=3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 __func__, rx_index, tx_index,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (16 -
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (PCH_WRITABLE(reg_spsr_val))),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 n_read);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*if trans=
fer complete interrupt */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (reg_sp=
sr_val & SPSR_FI_BIT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_dbg(&p_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s FI bit in SPSR"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " set\n", __func__);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /*disable FI & RFI interrupts */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 pch_spi_disable_interrupts(p_data->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 p_master, PCH_FI | PCH_RFI);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /*transfer is completed;inform
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0pch_spi_process_messages */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 if (pch_spi_gcbptr !=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 dev_dbg(&p_board_dat->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%s invoking callback\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 (*pch_spi_gcbptr) (p_data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +

To this point you are implementing an arrow antipattern.
=46or an in-depth explanation see:
http://c2.com/cgi/wiki?ArrowAntiPattern

if (noerror)
        ... much code ...
else
        errorpath

All these should be converted to the form:

if (error)
        errorpath
        return errorcode / goto cleanup

=2E.. rest of the code ...

This removes one indent and make the code much easier to
read.

This in combination with the fact that you're obviously running
checkpatch on top and forcing it down to 80 chars/line gives this
weird looking code.

>> +static int pch_spi_probe(struct pci_dev *pdev, const struct pci_dev=
ice_id
>> *id)
>> +{
>> +
>> + =A0 =A0 struct spi_master *p_master[PCH_MAX_DEV];

Hungarian p_* and even in hungarian it is also wrong because
this is an array of pointers not a plain pointer.

>> +
>> + =A0 =A0 struct pch_spi_board_data *p_board_dat;

Hungarian p_*

>> (...)
>> +static int pch_spi_resume(struct pci_dev *pdev)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 s32 retval;

s32?? What's wrong with an int?

>> +
>> + =A0 =A0 struct pch_spi_board_data *p_board_dat =3D pci_get_drvdata=
(pdev);
>> + =A0 =A0 dev_dbg(&pdev->dev, "%s ENTRY\n", __func__);

Here begins another deep nested arrow antipattern...

>> + =A0 =A0 if (p_board_dat =3D=3D NULL) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s pci_get_drvdata return=
ed NULL\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D -EFAULT;

return -EFAULT and de-indent, etc. You know the drill.

>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* move device to DO power state */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_set_power_state(pdev, PCI_D0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s pci_set_power_state invoked su=
ccessfully\n", __func__);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* restore state */
>> + =A0 =A0 =A0 =A0 =A0 =A0 pci_restore_state(pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s pci_restore_state invoked succ=
essfully\n", __func__);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 retval =3D pci_enable_device(pdev);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (retval < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s pci_en=
able_device failed\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 "%s pci_enable_device returned=3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 __func__, retval);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* disable PM notification=
s */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pci_enable_wake(pdev, PCI_=
D3hot, 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%s pci_enable_wake inv=
oked successfully\n", __func__);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* register IRQ handler */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((p_board_dat->irq_reg_=
sts) !=3D true) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* registe=
r IRQ */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 retval =3D=
 request_irq(p_board_dat->pdev->irq,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0pch_spi_handler, IRQF_SHARED,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0DRIVER_NAME,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0p_board_dat);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (retval=
 < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_err(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"%s request_irq failed\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_dbg(&pdev->dev, "%s request_irq"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0" returned=3D%d\n", __func__, retval);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 p_board_dat->irq_reg_sts =3D true;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* reset PCH SPI h/w */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 for (i =3D 0; i < PCH_MAX_DEV; i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pch_spi_reset(p_board_dat->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_data[i]->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 p_master);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "pdev->dev, %s pch_spi_reset "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "invoked successfully\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 pch_spi_set_master_mode
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (p_board_dat->p_data[i]->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0p_master);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "%s pch_spi_set_master_mode "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 "invoked successfully\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 /* set suspend status to false */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 p_board_dat->suspend_sts =3D false;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_dbg(&pdev->dev, "%s set p_board_dat"
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0"->bSuspending =3D false\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }

All the way to here.

>> (...)
>> --- /dev/null
>> +++ b/drivers/spi/pch_spi_platform_devices.c
>> @@ -0,0 +1,56 @@
>> +/*
>> + * Copyright (C) 2010 OKI SEMICONDUCTOR Co., LTD.
>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; version 2 of the License.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public Licens=
e
>> + * along with this program; if not, write to the Free Software
>> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A00211=
1-1307,
>> USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/spi/spidev.h>
>> +#include <linux/device.h>
>> +#include <linux/spi/spi.h>
>> +
>> +static struct spi_board_info pch_spi_slaves[] =3D {
>> + =A0 =A0 {
>> + =A0 =A0 =A0.modalias =3D "spidev",
>> + =A0 =A0 =A0.max_speed_hz =3D 1000000,
>> + =A0 =A0 =A0.bus_num =3D 0,
>> + =A0 =A0 =A0.chip_select =3D 0,
>> + =A0 =A0 =A0.platform_data =3D NULL,
>> + =A0 =A0 =A0.mode =3D SPI_MODE_0,
>> + =A0 =A0 =A0},
>> +#if (CONFIG_PCH_SPI_PLATFORM_DEVICE_COUNT - 1)

What does this #if() actually do?

Since the range in Kconfig is set to 1..2 I *think* this can be
rewritten

#if (CONFIG_PCH_SPI_PLATFORM_DEVICE_COUNT =3D=3D 2)

Which makes a lot more sense.

>> + =A0 =A0 {
>> + =A0 =A0 =A0.modalias =3D "spidev",
>> + =A0 =A0 =A0.max_speed_hz =3D 1000000,
>> + =A0 =A0 =A0.bus_num =3D 1,
>> + =A0 =A0 =A0.chip_select =3D 1,
>> + =A0 =A0 =A0.platform_data =3D NULL,
>> + =A0 =A0 =A0.mode =3D SPI_MODE_0,
>> + =A0 =A0 =A0},
>> +#endif
>> +};
>> +
>> +static __init int Load(void)

Rename from "Load" to pch_init or *_init whatever like everyone
else.

>> +{
>> + =A0 =A0 int iRetVal =3D -1;

Hungarian notation.

>> +
>> + =A0 =A0 if (!spi_register_board_info
>> + =A0 =A0 =A0 =A0 (pch_spi_slaves, ARRAY_SIZE(pch_spi_slaves)))
>> + =A0 =A0 =A0 =A0 =A0 =A0 iRetVal =3D 0;
>> +
>> + =A0 =A0 return iRetVal;
>> +}
>> +
>> +module_init(Load);

Yours,
Linus Walleij
