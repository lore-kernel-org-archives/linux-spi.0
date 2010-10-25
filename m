From: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] intel_mid_ssp_spi: Moorestown and Medfield SPI for SSP
	devices
Date: Mon, 25 Oct 2010 10:20:50 -0400
Message-ID: <AANLkTimjX4HB9SGB65oUmnpjpTT=z4KXprwH1T=r4ZM4@mail.gmail.com>
References: <20101022155530.2739.29656.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101022155530.2739.29656.stgit-bi+AKbBUZKY6gyzm1THtWbp2dZbC/Bob@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

2010/10/22 Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>:

> From: Mathieu SOULARD <mathieux.soulard-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> (...)
> +/**
> + * intel_mid_ssp_spi_dma_init() - Initialize DMA
> + * @drv_context: =A0 =A0 =A0 Pointer to the private driver context
> + *
> + * This function is called at driver setup phase to allocate DMA
> + * ressources.
> + */
> +static void intel_mid_ssp_spi_dma_init(struct ssp_driver_context *drv_co=
ntext)
> +{
> + =A0 =A0 =A0 struct intel_mid_dma_slave *rxs, *txs;
> + =A0 =A0 =A0 struct dma_slave_config *ds;

Hey, I really like this :-)

But where are you actually using this config?

It looks like you're in some transition phase to the
generic API.

> + =A0 =A0 =A0 dma_cap_mask_t mask;
> + =A0 =A0 =A0 struct device *dev =3D &drv_context->pdev->dev;
> + =A0 =A0 =A0 unsigned int device_id;
> +
> + =A0 =A0 =A0 /* Configure RX channel parameters */
> + =A0 =A0 =A0 rxs =3D &drv_context->dmas_rx;
> + =A0 =A0 =A0 ds =3D &rxs->dma_slave;
> +
> + =A0 =A0 =A0 ds->direction =3D DMA_FROM_DEVICE;
> + =A0 =A0 =A0 rxs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 rxs->cfg_mode =3D LNW_DMA_PER_TO_MEM;
> + =A0 =A0 =A0 ds->dst_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> + =A0 =A0 =A0 ds->src_addr_width =3D drv_context->n_bytes;
> +
> + =A0 =A0 =A0 /* Use a DMA burst according to the FIFO thresholds */
> + =A0 =A0 =A0 if (drv_context->rx_fifo_threshold =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 8;
> + =A0 =A0 =A0 } else if (drv_context->rx_fifo_threshold =3D=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 4;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Configure TX channel parameters */
> + =A0 =A0 =A0 txs =3D &drv_context->dmas_tx;
> + =A0 =A0 =A0 ds =3D &txs->dma_slave;
> +
> + =A0 =A0 =A0 ds->direction =3D DMA_TO_DEVICE;
> + =A0 =A0 =A0 txs->hs_mode =3D LNW_DMA_HW_HS;
> + =A0 =A0 =A0 txs->cfg_mode =3D LNW_DMA_MEM_TO_PER;

What I cannot wrap my head around is why your DMA
controller cannot figure these things out from the data
passed in to the

> + =A0 =A0 =A0 ds->src_addr_width =3D DMA_SLAVE_BUSWIDTH_4_BYTES;
> + =A0 =A0 =A0 ds->dst_addr_width =3D drv_context->n_bytes;

You also want to se
ds->src_addr and ds->dst_addr instead of passing that
through an artificial memcpy() call.

> + =A0 =A0 =A0 /* Use a DMA burst according to the FIFO thresholds */
> + =A0 =A0 =A0 if (drv_context->rx_fifo_threshold =3D=3D 8) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 8;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 8;
> + =A0 =A0 =A0 } else if (drv_context->rx_fifo_threshold =3D=3D 4) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 4;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 4;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->src_maxburst =3D 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ds->dst_maxburst =3D 1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Nothing more to do if already initialized */

There isn't?

You need to call
rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
                                       (unsigned long) ds);

To use that config you've set.

> + =A0 =A0 =A0 if (drv_context->dma_initialized)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 /* Use DMAC1 */
> + =A0 =A0 =A0 if (drv_context->quirks & QUIRKS_PLATFORM_MRST)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_id =3D PCI_MRST_DMAC1_ID;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_id =3D PCI_MDFL_DMAC1_ID;
> +
> + =A0 =A0 =A0 drv_context->dmac1 =3D pci_get_device(PCI_VENDOR_ID_INTEL,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_id, NULL);
> +
> + =A0 =A0 =A0 if (!drv_context->dmac1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Can't find DMAC1");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->virt_addr_sram_rx =3D ioremap_=
nocache(SRAM_BASE_ADDR,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 2 * MAX_SPI=
_TRANSFER_SIZE);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_context->virt_addr_sram_rx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->virt_addr_sram=
_tx =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context=
->virt_addr_sram_rx +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MAX_SPI_TRA=
NSFER_SIZE;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Virt_addr_sra=
m_rx is null\n");
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* 1. Allocate rx channel */
> + =A0 =A0 =A0 dma_cap_zero(mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);

You only want to request DMA_SLAVE really.

> +
> + =A0 =A0 =A0 drv_context->rxchan =3D dma_request_channel(mask, chan_filt=
er,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context);
> + =A0 =A0 =A0 if (!drv_context->rxchan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_exit;
> +
> + =A0 =A0 =A0 drv_context->rxchan->private =3D rxs;
> +
> + =A0 =A0 =A0 /* 2. Allocate tx channel */
> + =A0 =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
> + =A0 =A0 =A0 dma_cap_set(DMA_MEMCPY, mask);
> +
> + =A0 =A0 =A0 drv_context->txchan =3D dma_request_channel(mask, chan_filt=
er,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context);
> +
> + =A0 =A0 =A0 if (!drv_context->txchan)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto free_rxchan;
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->txchan->private =3D txs;

rxchan->device->device_control(rxchan, DMA_SLAVE_CONFIG,
                                       (unsigned long) ds);
txchan->device->device_control(txchan, DMA_SLAVE_CONFIG,
                                       (unsigned long) ds);

> + =A0 =A0 =A0 /* set the dma done bit to 1 */
> + =A0 =A0 =A0 drv_context->txdma_done =3D 1;
> + =A0 =A0 =A0 drv_context->rxdma_done =3D 1;
> +
> + =A0 =A0 =A0 drv_context->tx_param.drv_context =A0=3D drv_context;
> + =A0 =A0 =A0 drv_context->tx_param.direction =3D TX_DIRECTION;
> + =A0 =A0 =A0 drv_context->rx_param.drv_context =A0=3D drv_context;
> + =A0 =A0 =A0 drv_context->rx_param.direction =3D RX_DIRECTION;
> +
> + =A0 =A0 =A0 drv_context->dma_initialized =3D 1;
> +
> + =A0 =A0 =A0 return;
> +
> +free_rxchan:
> + =A0 =A0 =A0 dma_release_channel(drv_context->rxchan);
> +err_exit:
> + =A0 =A0 =A0 dev_err(dev, "Error : DMA Channel Not available\n");
> +
> + =A0 =A0 =A0 if (drv_context->quirks & QUIRKS_SRAM_ADDITIONAL_CPY)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(drv_context->virt_addr_sram_rx);
> +
> + =A0 =A0 =A0 pci_dev_put(drv_context->dmac1);
> + =A0 =A0 =A0 return;
> +}
> +
> (...)
> +/**
> + * dma_transfer() - Initiate a DMA transfer
> + * @drv_context: =A0 =A0 =A0 Pointer to the private driver context
> + */
> +static void dma_transfer(struct ssp_driver_context *drv_context)
> +{
> + =A0 =A0 =A0 dma_addr_t ssdr_addr;
> + =A0 =A0 =A0 struct dma_async_tx_descriptor *txdesc =3D NULL, *rxdesc =
=3D NULL;
> + =A0 =A0 =A0 struct dma_chan *txchan, *rxchan;
> + =A0 =A0 =A0 enum dma_ctrl_flags flag;
> + =A0 =A0 =A0 struct device *dev =3D &drv_context->pdev->dev;
> +
> + =A0 =A0 =A0 /* get Data Read/Write address */
> + =A0 =A0 =A0 ssdr_addr =3D (dma_addr_t)(drv_context->paddr + 0x10);
> +
> + =A0 =A0 =A0 if (drv_context->tx_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->txdma_done =3D 0;
> +
> + =A0 =A0 =A0 if (drv_context->rx_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->rxdma_done =3D 0;
> +
> + =A0 =A0 =A0 /* 2. prepare the RX dma transfer */
> + =A0 =A0 =A0 txchan =3D drv_context->txchan;
> + =A0 =A0 =A0 rxchan =3D drv_context->rxchan;
> +
> + =A0 =A0 =A0 flag =3D DMA_PREP_INTERRUPT | DMA_CTRL_ACK;
> +
> + =A0 =A0 =A0 if (likely(drv_context->quirks & QUIRKS_DMA_USE_NO_TRAIL)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Since the DMA is configured to do 32bits=
 access */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* to/from the DDR, the DMA transfer size m=
ust be =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* a multiple of 4 bytes =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_rx =3D drv_context->le=
n & ~(4 - 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_tx =3D drv_context->le=
n_dma_rx;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* In Rx direction, TRAIL Bytes are handled=
 by memcpy */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_context->rx_dma &&
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (drv_context->len_dma_rx >
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->rx_fifo_thresh=
old * drv_context->n_bytes))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_rx =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 TRUNCATE(drv_context->len_dma_rx,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drv_context->rx_fifo_threshold *
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 drv_context->n_bytes);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else if (!drv_context->rx_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "ERROR : rx_dm=
a is null\r\n");
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* TRAIL Bytes are handled by DMA */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (drv_context->rx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_rx =3D=
 drv_context->len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_tx =3D=
 drv_context->len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "ERROR : drv_c=
ontext->rx_dma is null!\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 rxdesc =3D rxchan->device->device_prep_dma_memcpy
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (rxchan, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DMA Channel */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->rx_dma, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* DAR */

/* DAR */ ?

Isn't that just a buffer?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssdr_addr, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* SAR */

This is not really a memcpy() targetr address because it's fixed,
right?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_rx, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0/* Data Length */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Flag */

If your slave config command is working then replace this
with ->device_prep_slave_sg() and drop these address
encoding through memcpy calls.

> + =A0 =A0 =A0 /* 3. prepare the TX dma transfer */
> + =A0 =A0 =A0 if (drv_context->tx_dma) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 txdesc =3D txchan->device->device_prep_dma_=
memcpy
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (txchan, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* DMA Channel */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ssdr_addr, =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0/* DAR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->tx_dma, =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0/* SAR */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 drv_context->len_dma_tx, =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0/* Data Length */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flag); =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Flag */

Dito.

Yours,
Linus Walleij

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
