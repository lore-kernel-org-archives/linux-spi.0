From: Daniel Sobe <daniel.sobe-3arQi8VN3Tc@public.gmane.org>
Subject: [PATCH] spi-imx: improve timing of bursts
Date: Mon, 17 Mar 2014 16:22:04 +0000
Message-ID: <8c8893eae0014e59ac6942062590d36e@DB4PR04MB393.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi,

The patch below addresses 2 improvements:

1) Burstsize of a transfer adjusted up to the maximum burstsize of the =
hardware --> no unwanted CS toggling between data words
2) Variable trigger level allows to increase priority for data transfer=
, enables continuous transfers up to the burstsize. --> remove gaps eve=
ry 64 words

The original behaviour of the driver is untouched. The additional featu=
res can be enabled via sysfs.

With file "bigburst" the driver is instructed to use the maximum possib=
le burst length, depending on the length of the transfer it received. D=
ue to the hardware of the iMX6 this only makes sense if a transfer has =
its bits per word set to 32.

With file "txthres" the transmit FIFO level is set (in the range of 1 t=
o 64), all other values disable the functionality. An interrupt will be=
 triggered if the specified FIFO level (or lower) is reached, re-fillin=
g the FIFO up to the max resp. the remaining data of the transfer. If d=
isabled, the original behaviour (refilling when FIFO is empty) is activ=
e. The functionality creates a higher interrupt load but allows continu=
ous transfers up to the selected burstsize.

I'd like to receive feedback on the patch, improving it and making it s=
uitable for a possible inclusion into the kernel. Unfortunately, I coul=
d only test the patch on a very old kernel. The patch itself applies ag=
ainst a recent kernel (3.14-rc6) and I checked that it compiles without=
 warnings.

Signed-off-by: Daniel Sobe <daniel.sobe-3arQi8VN3Tc@public.gmane.org>

--- linux-original/drivers/spi/spi-imx.c=A0=A0 =A02014-03-17 17:12:35.6=
91791218 +0100
+++ linux-stable/drivers/spi/spi-imx.c=A0=A0 =A02014-03-17 17:09:44.451=
795597 +0100
@@ -51,12 +51,14 @@
=A0/* generic defines to abstract from the different register layouts *=
/
=A0#define MXC_INT_RR=A0=A0 =A0(1 << 0) /* Receive data ready interrupt=
 */
=A0#define MXC_INT_TE=A0=A0 =A0(1 << 1) /* Transmit FIFO empty interrup=
t */
+#define MXC_INT_THE=A0=A0=A0=A0 (1 << 2) /* Transmit FIFO threshold in=
terrupt */
=A0
=A0struct spi_imx_config {
=A0=A0=A0 =A0unsigned int speed_hz;
=A0=A0=A0 =A0unsigned int bpw;
=A0=A0=A0 =A0unsigned int mode;
=A0=A0=A0 =A0u8 cs;
+=A0=A0 =A0unsigned long burstlen;
=A0};
=A0
=A0enum spi_imx_devtype {
@@ -154,6 +156,10 @@
=A0static int mxc_clkdivs[] =3D {0, 3, 4, 6, 8, 12, 16, 24, 32, 48, 64,=
 96, 128, 192,
=A0=A0=A0 =A0256, 384, 512, 768, 1024};
=A0
+// (sysfs-)tunable attributes
+static int allow_big_bursts =3D 0; // if set to 1 this enables 32-bit =
big bursts
+static int tx_fifo_thres =3D -1;=A0=A0 // if positive, use TX data req=
uest interrupt when applicable
+
=A0/* MX21, MX27 */
=A0static unsigned int spi_imx_clkdiv_1(unsigned int fin,
=A0=A0=A0 =A0=A0=A0 =A0unsigned int fspi, unsigned int max)
@@ -200,8 +206,13 @@
=A0
=A0#define MX51_ECSPI_INT=A0=A0 =A0=A0=A0 =A00x10
=A0#define MX51_ECSPI_INT_TEEN=A0=A0 =A0=A0=A0 =A0(1 <<=A0 0)
+#define MX51_ECSPI_INT_TDREN=A0=A0 =A0=A0=A0 =A0(1 <<=A0 1)
=A0#define MX51_ECSPI_INT_RREN=A0=A0 =A0=A0=A0 =A0(1 <<=A0 3)
=A0
+#define MX51_ECSPI_DMA =A0=A0=A0 =A00x14
+#define MX51_ECSPI_DMA_TX_THRES_OFFSET=A0 0
+#define MX51_ECSPI_DMA_TX_THRES_MASK=A0=A0=A0 (0x3F)
+
=A0#define MX51_ECSPI_STAT=A0=A0 =A0=A0=A0 =A00x18
=A0#define MX51_ECSPI_STAT_RR=A0=A0 =A0=A0=A0 =A0(1 <<=A0 3)
=A0
@@ -250,6 +261,12 @@
=A0=A0=A0 =A0if (enable & MXC_INT_TE)
=A0=A0=A0 =A0=A0=A0 =A0val |=3D MX51_ECSPI_INT_TEEN;
=A0
+=A0=A0 =A0// enable Tx threshold interrupt for faster reaction when tr=
ansmitting long messages
+=A0=A0 =A0if (enable & MXC_INT_THE) {
+=A0=A0 =A0=A0=A0 =A0val |=3D MX51_ECSPI_INT_TDREN;
+=A0=A0 =A0=A0=A0 =A0writel((unsigned int) tx_fifo_thres, spi_imx->base=
 + MX51_ECSPI_DMA);
+=A0=A0 =A0}
+
=A0=A0=A0 =A0if (enable & MXC_INT_RR)
=A0=A0=A0 =A0=A0=A0 =A0val |=3D MX51_ECSPI_INT_RREN;
=A0
@@ -270,6 +287,7 @@
=A0{
=A0=A0=A0 =A0u32 ctrl =3D MX51_ECSPI_CTRL_ENABLE, cfg =3D 0;
=A0=A0=A0 =A0u32 clk =3D config->speed_hz, delay;
+=A0=A0 =A0unsigned long burstlen;
=A0
=A0=A0=A0 =A0/*
=A0=A0=A0 =A0 * The hardware seems to have a race condition when changi=
ng modes. The
@@ -286,6 +304,27 @@
=A0=A0=A0 =A0/* set chip select to use */
=A0=A0=A0 =A0ctrl |=3D MX51_ECSPI_CTRL_CS(config->cs);
=A0
+=A0=A0 =A0// if possible and requested, increase burstlength
+=A0=A0 =A0// over whole message in 32 bit mode
+=A0=A0 =A0// (which is the only mode where HW supports this)
+=A0=A0 =A0// all other modes still use burstlength =3D=3D bpw
+=A0=A0 =A0if ((config->bpw =3D=3D 32) && (allow_big_bursts =3D=3D 1)) =
{
+=A0=A0 =A0=A0=A0 =A0if (config->burstlen <=3D 4096) {
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0burstlen =3D config->burstlen;
+=A0=A0 =A0=A0=A0 =A0} else {
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0// burst longer than burst register widt=
h -- need to scale appropriately
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0// so that the hardware will always term=
inate the burst appropriately
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0burstlen =3D 16;
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0do {
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0burstlen =3D burstlen << 1;
+=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0} while ((config->burstlen % (burstlen <=
< 1)) =3D=3D 0);
+=A0=A0 =A0=A0=A0 =A0}
+=A0=A0 =A0} else {
+=A0=A0 =A0=A0 burstlen =3D config->bpw;
+=A0=A0 =A0}
+
+=A0=A0 =A0ctrl |=3D (burstlen - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
+
=A0=A0=A0 =A0ctrl |=3D (config->bpw - 1) << MX51_ECSPI_CTRL_BL_OFFSET;
=A0
=A0=A0=A0 =A0cfg |=3D MX51_ECSPI_CONFIG_SBBCTRL(config->cs);
@@ -666,6 +705,10 @@
=A0=A0=A0 =A0=A0=A0 =A0spi_imx->txfifo++;
=A0=A0=A0 =A0}
=A0
+=A0=A0 =A0// always reconfigure IRQ source (for the TX data request IR=
Q to work properly)
+=A0=A0 =A0spi_imx->devtype_data->intctrl(spi_imx,
+=A0=A0 =A0=A0=A0 =A0((spi_imx->txfifo =3D=3D spi_imx_get_fifosize(spi_=
imx)) && (tx_fifo_thres !=3D -1)) ? MXC_INT_THE : MXC_INT_TE);
+
=A0=A0=A0 =A0spi_imx->devtype_data->trigger(spi_imx);
=A0}
=A0
@@ -708,6 +751,7 @@
=A0=A0=A0 =A0config.speed_hz=A0 =3D t ? t->speed_hz : spi->max_speed_hz=
;
=A0=A0=A0 =A0config.mode =3D spi->mode;
=A0=A0=A0 =A0config.cs =3D spi->chip_select;
+=A0=A0 =A0config.burstlen =3D t ? (t->len * 8) : config.bpw;
=A0
=A0=A0=A0 =A0if (!config.speed_hz)
=A0=A0=A0 =A0=A0=A0 =A0config.speed_hz =3D spi->max_speed_hz;
@@ -745,8 +789,6 @@
=A0
=A0=A0=A0 =A0spi_imx_push(spi_imx);
=A0
-=A0=A0 =A0spi_imx->devtype_data->intctrl(spi_imx, MXC_INT_TE);
-
=A0=A0=A0 =A0wait_for_completion(&spi_imx->xfer_done);
=A0
=A0=A0=A0 =A0return transfer->len;
@@ -801,6 +843,63 @@
=A0=A0=A0 =A0return 0;
=A0}
=A0
+static ssize_t spidrv_setbigburst(struct device *dev,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct device_attribute *attr,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 const char *buf, size_t size)
+{
+=A0=A0 =A0unsigned long tmp;
+=A0=A0 =A0tmp =3D simple_strtoul(buf, NULL, 10);
+=A0=A0 =A0if (tmp =3D=3D 1) {
+=A0=A0 =A0=A0=A0 =A0allow_big_bursts =3D 1;
+=A0=A0 =A0=A0=A0 =A0} else {
+=A0=A0 =A0=A0=A0 =A0allow_big_bursts =3D 0;
+=A0=A0 =A0}
+=A0=A0 =A0return size;
+}
+
+static ssize_t spidrv_getbigburst(struct device *dev,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct device_attribute *attr,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 char *buf)
+{
+=A0=A0 =A0sprintf (buf, "%d\n", allow_big_bursts);
+=A0=A0 =A0return (ssize_t)(strlen (buf) + 1);
+}
+
+static ssize_t spidrv_settxthres(struct device *dev,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 struct device_attribute *attr,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 const char *buf, size_t size)
+{
+=A0=A0 =A0unsigned long tmp;
+=A0=A0 =A0tmp =3D simple_strtoul(buf, NULL, 10);
+=A0=A0 =A0if ((tmp > 0) && (tmp < 65)) {
+=A0=A0 =A0=A0=A0 =A0tx_fifo_thres =3D tmp;
+=A0=A0 =A0} else {
+=A0=A0 =A0=A0=A0 =A0tx_fifo_thres =3D -1;
+=A0=A0 =A0}
+=A0=A0 =A0return size;
+}
+
+static ssize_t spidrv_gettxthres(struct device *dev,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 struct device_attribute *attr,
+=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0 char *buf)
+{
+=A0=A0 =A0sprintf (buf, "%d\n", tx_fifo_thres);
+=A0=A0 =A0return (ssize_t)(strlen (buf) + 1);
+}
+
+static DEVICE_ATTR(bigburst, 0666, spidrv_getbigburst, spidrv_setbigbu=
rst);
+static DEVICE_ATTR(txthres,=A0 0666, spidrv_gettxthres , spidrv_settxt=
hres);
+
+static struct attribute *spidrv_attributes[] =3D {
+=A0=A0 =A0&dev_attr_bigburst.attr,
+=A0=A0 =A0&dev_attr_txthres.attr,
+=A0=A0 =A0NULL
+};
+
+static const struct attribute_group spidrv_group =3D {
+=A0=A0 =A0.attrs =3D spidrv_attributes,
+};
+
=A0static int spi_imx_probe(struct platform_device *pdev)
=A0{
=A0=A0=A0 =A0struct device_node *np =3D pdev->dev.of_node;
@@ -840,6 +939,10 @@
=A0=A0=A0 =A0spi_imx =3D spi_master_get_devdata(master);
=A0=A0=A0 =A0spi_imx->bitbang.master =3D master;
=A0
+=A0=A0 =A0if (sysfs_create_group(&pdev->dev.kobj, &spidrv_group)) {
+=A0=A0 =A0=A0=A0 =A0return -ENOMEM;
+=A0=A0 =A0}
+
=A0=A0=A0 =A0for (i =3D 0; i < master->num_chipselect; i++) {
=A0=A0=A0 =A0=A0=A0 =A0int cs_gpio =3D of_get_named_gpio(np, "cs-gpios"=
, i);
=A0=A0=A0 =A0=A0=A0 =A0if (!gpio_is_valid(cs_gpio) && mxc_platform_info=
)


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
