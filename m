From: kbb-DU79CLUmun8xNU+NZBVoVw@public.gmane.org
Subject: Need Help: mmc over spi
Date: Tue, 15 Jul 2008 16:56:03 -0500 (CDT)
Message-ID: <63553.216.207.242.34.1216158963.squirrel@www.texascellnet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0383605183=="
To: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

--===============0383605183==
Content-Type: multipart/alternative;boundary="----=_20080715165603_84927"

------=_20080715165603_84927
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hopefully a better formed set of questions:

I am trying to get
MMC over SPI working in the 2.4.26 kernel.

the .config has
configured:

CONFIG_SPI=3Dy
CONFIG_SPI_MASTER=3Dy

#
# SPI Master Controller Drivers
#
CONFIG_SPI_BITBANG=3Dy
# CONFIG_SPI_PXA2XX is not set

CONFIG_MMC=3Dy
CONFIG_MMC_DEBUG=3Dy
CONFIG_MMC_UNSAFE_RESUME=3Dy

#
# MMC/SD Card Drivers
#
CONFIG_MMC_BLOCK=3Dy
CONFIG_MMC_BLOCK_BOUNCE=3Dy
# CONFIG_SDIO_UART is not set

#
# MMC/SD Host Controller Drivers
#
CONFIG_MMC_SPI=3Dm

I have added a the pxi_platform_data struct/code to the init
file.
I have not developed in the 2.6 but am familiar with the 2.4
kernel.

static int mmc_DetectInit(struct device *dev,
irqreturn_t (*mmc_detect_int)(int, void *), void *data)
{
=A0=A0=A0 struct mmc_host *mmc =3D (struct mmc_host*)data;
=A0=A0=A0 int err;

printk("\n\n\n\nHEY HEY HEY
KBB \n\n\n\n");
=A0=A0=A0
/*----------------------------------------------------------------
=A0=A0=A0 ** GPIO 12 as CD interrupt
=A0=A0=A0 **
GPIO as CS0
=A0=A0=A0 ** GPIO 6 as CLK
=A0=A0=A0
**----------------------------------------------------------------
=A0=A0=A0 */
=A0=A0=A0 GPSR(RESETAVR) =3D
GPIO_bit(RESETAVR);
=A0=A0=A0 mdelay(100);
=A0=A0=A0 GPCR(RESETAVR) =3D GPIO_bit(RESETAVR);

=A0=A0=A0 GRER(0) =3D GRER(0) & 0xFFFFFEBF;
=A0=A0=A0 GFER(0) =3D GRER(0) & 0xFFFFFEBF;
=A0=A0=A0 GPSR(0) =3D GPSR(0) & 0x00000140;
=A0=A0=A0 GPDR(0) =3D GPDR(0) & 0x00000140;
=A0=A0=A0 GAFR(0) =3D (GAFR(0) & 0xFFFDDFFF);

=A0=A0=A0 pxa_gpio_mode(GPIO_MMC_ON|GPIO_OUT);
=A0=A0=A0 pxa_gpio_mode(GPIO_MMC_WP|GPIO_IN);

=A0=A0=A0 // added to the addition from turboX
=A0=A0=A0 pxa_gpio_mode(GPIO8_MMCCS0|GPIO_OUT);
=A0=A0=A0 pxa_gpio_mode(GPIO6_MMCCLK|GPIO_OUT);

=A0=A0=A0 pxa_gpio_mode(GPIO32_MMCCLK_MD);
=A0=A0=A0 pxa_gpio_mode(GPIO92_MMCDAT0_MD);
=A0=A0=A0 pxa_gpio_mode(GPIO109_MMCDAT1_MD);
=A0=A0=A0 pxa_gpio_mode(GPIO110_MMCDAT2_MD);
=A0=A0=A0 pxa_gpio_mode(GPIO111_MMCDAT3_MD);
=A0=A0=A0 pxa_gpio_mode(GPIO112_MMCCMD_MD);

=A0=A0=A0 pxa_gpio_mode(GPIO_MMC_CD|GPIO_IN);
=A0=A0=A0 set_irq_type(MMC_DET_IRQ, IRQT_BOTHEDGE);

=A0=A0=A0 err =3D request_irq(MMC_DET_IRQ, mmc_detect_int,
IRQF_DISABLED,
=A0=A0=A0 =A0=A0=A0
=A0=A0=A0 =A0 "MMC card detect", (void *)mmc);

=A0=A0=A0 if (err) {
=A0=A0=A0
=A0=A0=A0 pr_err("mci: request irq MMC/SD: can't request MMC
card detect IRQ\n");
=A0=A0=A0 =A0=A0=A0
return -1;
=A0=A0=A0 }

=A0=A0=A0 return
0;
}


static void mmc_Setpower(struct device *dev,
unsigned int vdd)
{
=A0=A0=A0 struct
pxamci_platform_data* p_d =3D dev->platform_data;

=A0=A0=A0 /* printk("%s: vdd %x\n", __func__, vdd);
*/

=A0=A0=A0 if (!vdd)
=A0=A0=A0
=A0=A0=A0 GPSR(GPIO_MMC_ON) =3D GPIO_bit(GPIO_MMC_ON);
=A0=A0=A0 else if (( 1 << vdd ) &
p_d->ocr_mask)
=A0=A0=A0 =A0=A0=A0
GPCR(GPIO_MMC_ON) =3D GPIO_bit(GPIO_MMC_ON);
=A0=A0=A0 else
=A0=A0=A0 =A0=A0=A0 pr_err("Unable to set MCI
power\n");

}

static void mmc_Exit(struct device
*dev, void *data)
{
=A0=A0=A0 struct mmc_host *mmc =3D
(struct mmc_host*)data;
=A0=A0=A0 unsigned long flags;

=A0=A0=A0 local_irq_save(flags);
=A0=A0=A0
free_irq(MMC_DET_IRQ, (void *)mmc);
=A0=A0=A0
local_irq_restore(flags);
}

static int mmc_Ronly(struct
device * dev)
{
=A0=A0=A0 return (GPLR(GPIO_MMC_WP)
& GPIO_bit(GPIO_MMC_WP)) ? 1 : 0;
}

static struct
pxamci_platform_data mmc_platform_data =3D {
=A0=A0=A0
.ocr_mask=A0=A0=A0 =3D MMC_VDD_32_33|MMC_VDD_33_34,
=A0=A0=A0 .detect_delay=A0=A0=A0 =3D 2,
=A0=A0=A0 .init=A0=A0=A0 =A0=A0=A0 =3D
mmc_DetectInit,
=A0=A0=A0 .setpower=A0=A0=A0 =3D
mmc_Setpower,
=A0=A0=A0 .exit=A0=A0=A0
=A0=A0=A0 =3D mmc_Exit,
=A0=A0=A0
.get_ro=A0=A0=A0 =A0=A0=A0 =3D mmc_Ronly,
};

Also the SSP code addition, but not sure this is correct???:

static struct resource pxa_ssp_resources[] =3D {
=A0=A0=A0
[0] =3D {
=A0=A0=A0 =A0=A0=A0
.start=A0=A0=A0 =3D __PREG(SSCR0_P(1)),
=A0=A0=A0
=A0=A0=A0 .end=A0=A0=A0 =3D __PREG(SSCR0_P(1)) + 0x14,
=A0=A0=A0 =A0=A0=A0 .flags=A0=A0=A0 =3D
IORESOURCE_MEM,
=A0=A0=A0 },
=A0=A0=A0 [1] =3D
{
=A0=A0=A0 =A0=A0=A0 .start=A0=A0=A0 =3D
IRQ_SSP,
=A0=A0=A0 =A0=A0=A0 .end=A0=A0=A0
=3D IRQ_SSP,
=A0=A0=A0 =A0=A0=A0
.flags=A0=A0=A0 =3D IORESOURCE_IRQ,
=A0=A0=A0 },
};

static struct pxa2xx_spi_master pxa_ssp_master_info =3D {
=A0=A0=A0 .ssp_type=A0=A0=A0 =3D PXA25x_SSP,
=A0=A0=A0 .clock_enable=A0=A0=A0 =3D CKEN_SSP,
=A0=A0=A0 .num_chipselect=A0=A0=A0 =3D 0,
};

static struct platform_device pxa_ssp =3D {
=A0=A0=A0
.name=A0=A0=A0 =A0=A0=A0 =3D "pxa2xx-spi",
=A0=A0=A0 .id=A0=A0=A0 =A0=A0=A0 =3D 1,
=A0=A0=A0 .resource=A0=A0=A0 =3D pxa_ssp_resources,
=A0=A0=A0 .num_resources=A0=A0=A0 =3D
ARRAY_SIZE(pxa_ssp_resources),
=A0=A0=A0 .dev =3D {
=A0=A0=A0 =A0=A0=A0 .platform_data=A0=A0=A0 =3D
&pxa_ssp_master_info,
=A0=A0=A0 },
};


I build the mmc_spi driver and I can not get the card detect to
work at all.

the interrupt should be GPIO12 w/ either direction
picked.

My question is what should be the next step to get this
going?

Thank you,
Kbb



------=_20080715165603_84927
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hopefully a better formed set of questions:<br /><br />I am trying to get
MMC over SPI working in the 2.4.26 kernel.<br /><br />the .config has
configured:<br /><br />CONFIG_SPI=3Dy<br />CONFIG_SPI_MASTER=3Dy<br /><br
/>#<br /># SPI Master Controller Drivers<br />#<br
/>CONFIG_SPI_BITBANG=3Dy<br /># CONFIG_SPI_PXA2XX is not set<br /><br
/>CONFIG_MMC=3Dy<br />CONFIG_MMC_DEBUG=3Dy<br />CONFIG_MMC_UNSAFE_RESUME=3D=
y<br
/><br />#<br /># MMC/SD Card Drivers<br />#<br />CONFIG_MMC_BLOCK=3Dy<br
/>CONFIG_MMC_BLOCK_BOUNCE=3Dy<br /># CONFIG_SDIO_UART is not set<br /><br
/>#<br /># MMC/SD Host Controller Drivers<br />#<br />CONFIG_MMC_SPI=3Dm<=
br
/><br />I have added a the pxi_platform_data struct/code to the init
file.<br />I have not developed in the 2.6 but am familiar with the 2.4
kernel.<br /><br />static int mmc_DetectInit(struct device *dev,
irqreturn_t (*mmc_detect_int)(int, void *), void *data)<br />{<br
/>&nbsp;&nbsp;&nbsp; struct mmc_host *mmc =3D (struct mmc_host*)data;<br
/>&nbsp;&nbsp;&nbsp; int err;<br /><br />printk(&quot;\n\n\n\nHEY HEY HEY
KBB \n\n\n\n&quot;);<br />&nbsp;&nbsp;&nbsp;
/*----------------------------------------------------------------<br
/>&nbsp;&nbsp;&nbsp; ** GPIO 12 as CD interrupt<br />&nbsp;&nbsp;&nbsp; *=
*
GPIO as CS0<br />&nbsp;&nbsp;&nbsp; ** GPIO 6 as CLK<br
/>&nbsp;&nbsp;&nbsp;
**----------------------------------------------------------------<br
/>&nbsp;&nbsp;&nbsp; */<br />&nbsp;&nbsp;&nbsp; GPSR(RESETAVR) =3D
GPIO_bit(RESETAVR);<br />&nbsp;&nbsp;&nbsp; mdelay(100);<br
/>&nbsp;&nbsp;&nbsp; GPCR(RESETAVR) =3D GPIO_bit(RESETAVR);<br /><br
/>&nbsp;&nbsp;&nbsp; GRER(0) =3D GRER(0) &amp; 0xFFFFFEBF;<br
/>&nbsp;&nbsp;&nbsp; GFER(0) =3D GRER(0) &amp; 0xFFFFFEBF;<br
/>&nbsp;&nbsp;&nbsp; GPSR(0) =3D GPSR(0) &amp; 0x00000140;<br
/>&nbsp;&nbsp;&nbsp; GPDR(0) =3D GPDR(0) &amp; 0x00000140;<br
/>&nbsp;&nbsp;&nbsp; GAFR(0) =3D (GAFR(0) &amp; 0xFFFDDFFF);<br /><br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO_MMC_ON|GPIO_OUT);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO_MMC_WP|GPIO_IN);<br /><br
/>&nbsp;&nbsp;&nbsp; // added to the addition from turboX<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO8_MMCCS0|GPIO_OUT);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO6_MMCCLK|GPIO_OUT);<br /><br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO32_MMCCLK_MD);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO92_MMCDAT0_MD);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO109_MMCDAT1_MD);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO110_MMCDAT2_MD);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO111_MMCDAT3_MD);<br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO112_MMCCMD_MD);<br /><br
/>&nbsp;&nbsp;&nbsp; pxa_gpio_mode(GPIO_MMC_CD|GPIO_IN);<br
/>&nbsp;&nbsp;&nbsp; set_irq_type(MMC_DET_IRQ, IRQT_BOTHEDGE);<br /><br
/>&nbsp;&nbsp;&nbsp; err =3D request_irq(MMC_DET_IRQ, mmc_detect_int,
IRQF_DISABLED,<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; &nbsp; &quot;MMC card detect&quot;, (void *)mmc);<br
/><br />&nbsp;&nbsp;&nbsp; if (err) {<br />&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; pr_err(&quot;mci: request irq MMC/SD: can't request MM=
C
card detect IRQ\n&quot;);<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
return -1;<br />&nbsp;&nbsp;&nbsp; }<br /><br />&nbsp;&nbsp;&nbsp; return
0;<br />}<br /><br /><br />static void mmc_Setpower(struct device *dev,
unsigned int vdd)<br />{<br />&nbsp;&nbsp;&nbsp; struct
pxamci_platform_data* p_d =3D dev-&gt;platform_data;<br /><br
/>&nbsp;&nbsp;&nbsp; /* printk(&quot;%s: vdd %x\n&quot;, __func__, vdd);
*/<br /><br />&nbsp;&nbsp;&nbsp; if (!vdd)<br />&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; GPSR(GPIO_MMC_ON) =3D GPIO_bit(GPIO_MMC_ON);<br
/>&nbsp;&nbsp;&nbsp; else if (( 1 &lt;&lt; vdd ) &amp;
p_d-&gt;ocr_mask)<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
GPCR(GPIO_MMC_ON) =3D GPIO_bit(GPIO_MMC_ON);<br />&nbsp;&nbsp;&nbsp; else=
<br
/>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; pr_err(&quot;Unable to set MCI
power\n&quot;);<br /><br />}<br /><br />static void mmc_Exit(struct devic=
e
*dev, void *data)<br />{<br />&nbsp;&nbsp;&nbsp; struct mmc_host *mmc =3D
(struct mmc_host*)data;<br />&nbsp;&nbsp;&nbsp; unsigned long flags;<br
/><br />&nbsp;&nbsp;&nbsp; local_irq_save(flags);<br />&nbsp;&nbsp;&nbsp;
free_irq(MMC_DET_IRQ, (void *)mmc);<br />&nbsp;&nbsp;&nbsp;
local_irq_restore(flags);<br />}<br /><br />static int mmc_Ronly(struct
device * dev)<br />{<br />&nbsp;&nbsp;&nbsp; return (GPLR(GPIO_MMC_WP)
&amp; GPIO_bit(GPIO_MMC_WP)) ? 1 : 0;<br />}<br /><br />static struct
pxamci_platform_data mmc_platform_data =3D {<br />&nbsp;&nbsp;&nbsp;
.ocr_mask&nbsp;&nbsp;&nbsp; =3D MMC_VDD_32_33|MMC_VDD_33_34,<br
/>&nbsp;&nbsp;&nbsp; .detect_delay&nbsp;&nbsp;&nbsp; =3D 2,<br
/>&nbsp;&nbsp;&nbsp; .init&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D
mmc_DetectInit,<br />&nbsp;&nbsp;&nbsp; .setpower&nbsp;&nbsp;&nbsp; =3D
mmc_Setpower,<br />&nbsp;&nbsp;&nbsp; .exit&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; =3D mmc_Exit,<br />&nbsp;&nbsp;&nbsp;
.get_ro&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D mmc_Ronly,<br />};<br />=
<br
/>Also the SSP code addition, but not sure this is correct???:<br /><br
/>static struct resource pxa_ssp_resources[] =3D {<br />&nbsp;&nbsp;&nbsp=
;
[0] =3D {<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
.start&nbsp;&nbsp;&nbsp; =3D __PREG(SSCR0_P(1)),<br />&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp; .end&nbsp;&nbsp;&nbsp; =3D __PREG(SSCR0_P(1)) + 0x14,<=
br
/>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .flags&nbsp;&nbsp;&nbsp; =3D
IORESOURCE_MEM,<br />&nbsp;&nbsp;&nbsp; },<br />&nbsp;&nbsp;&nbsp; [1] =3D
{<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .start&nbsp;&nbsp;&nbsp; =3D
IRQ_SSP,<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .end&nbsp;&nbsp;&nbsp=
;
=3D IRQ_SSP,<br />&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
.flags&nbsp;&nbsp;&nbsp; =3D IORESOURCE_IRQ,<br />&nbsp;&nbsp;&nbsp; },<b=
r
/>};<br /><br />static struct pxa2xx_spi_master pxa_ssp_master_info =3D {=
<br
/>&nbsp;&nbsp;&nbsp; .ssp_type&nbsp;&nbsp;&nbsp; =3D PXA25x_SSP,<br
/>&nbsp;&nbsp;&nbsp; .clock_enable&nbsp;&nbsp;&nbsp; =3D CKEN_SSP,<br
/>&nbsp;&nbsp;&nbsp; .num_chipselect&nbsp;&nbsp;&nbsp; =3D 0,<br />};<br
/><br />static struct platform_device pxa_ssp =3D {<br />&nbsp;&nbsp;&nbs=
p;
.name&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D &quot;pxa2xx-spi&quot;,<br
/>&nbsp;&nbsp;&nbsp; .id&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; =3D 1,<br
/>&nbsp;&nbsp;&nbsp; .resource&nbsp;&nbsp;&nbsp; =3D pxa_ssp_resources,<b=
r
/>&nbsp;&nbsp;&nbsp; .num_resources&nbsp;&nbsp;&nbsp; =3D
ARRAY_SIZE(pxa_ssp_resources),<br />&nbsp;&nbsp;&nbsp; .dev =3D {<br
/>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp; .platform_data&nbsp;&nbsp;&nbsp; =
=3D
&amp;pxa_ssp_master_info,<br />&nbsp;&nbsp;&nbsp; },<br />};<br /><br
/><br />I build the mmc_spi driver and I can not get the card detect to
work at all.<br /><br />the interrupt should be GPIO12 w/ either directio=
n
picked.<br /><br />My question is what should be the next step to get thi=
s
going?<br /><br />Thank you,<br />Kbb<br /><br />
------=_20080715165603_84927--




--===============0383605183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0383605183==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
spi-devel-general mailing list
spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/spi-devel-general

--===============0383605183==--
