From: Jane Wan <Jane.Wan-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>
Subject: RE: [PATCH] Configure FSL eSPI CSBEF, CSAFT, and whether to send
 all received data to user
Date: Wed, 16 Apr 2014 16:39:47 +0000
Message-ID: <6f2c800fbba74470a6a49903b34e7796@SN2PR07MB064.namprd07.prod.outlook.com>
References: <1397328516-13260-1-git-send-email-Jane.Wan@gainspeed.com>
 <1397328516-13260-2-git-send-email-Jane.Wan@gainspeed.com>
 <20140414205547.GI25182@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	"robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org" <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>,
	"kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org" <kenth.eriksson-SNLAxHN9vbdl57MIdRCFDg@public.gmane.org>,
	"thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org"
	<thomas.de.schampheleire-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	"b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	"jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	"sr-ynQEQJNshbs@public.gmane.org" <sr-ynQEQJNshbs@public.gmane.org>, Insop Song <Insop.Song-X7+3OicCfH32eFz/2MeuCQ@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140414205547.GI25182-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Content-Language: en-US
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Apr 14, 2014 at 09:51:56PM +0100, Mark Brown wrote:
> On Sat, Apr 12, 2014 at 11:48:36AM -0700, Jane Wan wrote:
> > Make FSL eSPI CSnBEF and CSnAFT in ESPI_SPMODEn registers (n=0,1,2,3)
> > configurable through device tree.  FSL eSPI driver hardcodes them to 0.
> > Some device requires different value.
> 
> What do these do?

CSnBEF is the chip select setup time.  It's the delay in bits from the activation 
of chip select pin to the first clock for data frame.

CSnAFT is the chip select hold time.  It's the delay in bits from the last clock 
for data frame to the deactivation of chip select pin.

> > Allow FSL eSPI driver configurable whether to send all received data
> > form slave devices to user.  When user wants to send n_tx bytes and
> > receives n_rx bytes, FSL eSPI driver sends (n_tx + n_rx) bytes on MOSI.
> > For the received (n_tx + n_rx) bytes from MISO, current FSL eSPI
> > driver drops the first n_tx bytes, only passes the last n_rx bytes to user.
> > Some device driver has problem with this.  It requires to know all
> > bytes that the slave device puts on MISO.
> 
> This sounds like a separate patch to the first one, the described behaviour is
> definitely buggy and any correctly implemented Linux driver that does
> bidirectional I/O will have trouble with it.  It should be split out from the new DT
> bindings which are a new feature.
> 
> > ---
> >  drivers/spi/spi-fsl-espi.c       |   68 ++++++++++++++++++++++++++++++++++---
> -
> >  1 files changed, 61 insertions(+), 7 deletions(-)
> 
> All DT binding changes need to be documented in the binding document.

The binding document is updated.  The new changes (for CSnBEF and CSnAFT only)  will 
look like the following.  If this is ok, I'll send it as a separate patch for further discussion.

---
 Documentation/devicetree/bindings/spi/fsl-spi.txt |    6 ++++
 drivers/spi/spi-fsl-espi.c                        |   34 ++++++++++++++++++---
 2 files changed, 36 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/spi/fsl-spi.txt b/Documentation/devicetree/bindings/spi/fsl-spi.txt
index b032dd7..2c7fd41 100644
--- a/Documentation/devicetree/bindings/spi/fsl-spi.txt
+++ b/Documentation/devicetree/bindings/spi/fsl-spi.txt
@@ -42,6 +42,10 @@ Required properties:
 - interrupts : should contain eSPI interrupt, the device has one interrupt.
 - fsl,espi-num-chipselects : the number of the chipselect signals.
 
+Optional properties:
+- fsl,csbef: chip select assertion time in bits before frame starts
+- fsl,csaft: chip select negation time in bits after frame ends
+
 Example:
 	spi@110000 {
 		#address-cells = <1>;
@@ -51,4 +55,6 @@ Example:
 		interrupts = <53 0x2>;
 		interrupt-parent = <&mpic>;
 		fsl,espi-num-chipselects = <4>;
+		fsl,csbef = <1>;
+		fsl,csaft = <1>;
 	};
diff --git a/drivers/spi/spi-fsl-espi.c b/drivers/spi/spi-fsl-espi.c index 428dc7a..7ff9463 100644
--- a/drivers/spi/spi-fsl-espi.c
+++ b/drivers/spi/spi-fsl-espi.c
@@ -590,8 +590,10 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	struct spi_master *master;
 	struct mpc8xxx_spi *mpc8xxx_spi;
 	struct fsl_espi_reg *reg_base;
-	u32 regval;
-	int i, ret = 0;
+	struct device_node *nc;
+	const __be32 *prop;
+	u32 regval, csmode;
+	int i, len, ret = 0;
 
 	master = spi_alloc_master(dev, sizeof(struct mpc8xxx_spi));
 	if (!master) {
@@ -638,8 +640,32 @@ static struct spi_master * fsl_espi_probe(struct device *dev,
 	mpc8xxx_spi_write_reg(&reg_base->event, 0xffffffff);
 
 	/* Init eSPI CS mode register */
-	for (i = 0; i < pdata->max_chipselect; i++)
-		mpc8xxx_spi_write_reg(&reg_base->csmode[i], CSMODE_INIT_VAL);
+	for_each_available_child_of_node(master->dev.of_node, nc) {
+		/* get chip select */
+		prop = of_get_property(nc, "reg", &len);
+		if (!prop || len < sizeof(*prop))
+			continue;
+		i = be32_to_cpup(prop);
+		if (i < 0 || i >= pdata->max_chipselect)
+			continue;
+
+		csmode = CSMODE_INIT_VAL;
+		/* check if CSBEF is set in device tree */
+		prop = of_get_property(nc, "fsl,csbef", &len);
+		if (prop && len >= sizeof(*prop)) {
+			csmode &= ~(CSMODE_BEF(0xf));
+			csmode |= CSMODE_BEF(be32_to_cpup(prop));
+		}
+		/* check if CSAFT is set in device tree */
+		prop = of_get_property(nc, "fsl,csaft", &len);
+		if (prop && len >= sizeof(*prop)) {
+			csmode &= ~(CSMODE_AFT(0xf));
+			csmode |= CSMODE_AFT(be32_to_cpup(prop));
+		}
+		mpc8xxx_spi_write_reg(&reg_base->csmode[i], csmode);
+
+		dev_info(dev, "cs=%d, init_csmode=0x%x\n", i, csmode);
+	}
 
 	/* Enable SPI interface */
 	regval = pdata->initial_spmode | SPMODE_INIT_VAL | SPMODE_ENABLE;
--
1.7.9.5

> > +/* whether to send all rx data to user per chip select */ static u8
> > +*spi_raw_rxdata_to_user;
> > +
> 
> No, any data needs to be part of the driver data structure not a global variable.

I will look into this.

> > +		if (spi_raw_rxdata_to_user[m->spi->chip_select])
> > +			espi_trans->len = n_tx;
> > +		else
> > +			espi_trans->len = trans_len + n_tx;
> 
> Why is there even an option for the buggy behaviour?

We have three devices attached to the FSL eSPI interface, with chip select (CS) 
0-2. The device driver for the device at CS #2 requires to know all the data that 
the slave device put on MISO.  But the device drivers for the other two devices 
(at CS #0 and #1) work with the existing FSL eSPI driver.  The device at CS #0 is 
Micron n25q512a compatible.

We make the FSL eSPI driver configurable through device tree.  If we make a fix 
without the DT option, the fix will break other device drivers working with the 
existing FSL eSPI driver.

Could this still be considered as a solution?  If this is ok, I can send it as a separate 
patch.  Otherwise, we will look if this driver can be modified without DT option.

Regards,
Jane
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
