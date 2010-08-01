From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] drivers/spi: Convert printks to pr_<level>
Date: Sun, 1 Aug 2010 00:53:00 -0600
Message-ID: <AANLkTi=gQCOvd8AD3dqBuFrmhgnGNdDhXtxehFjpFJcS@mail.gmail.com>
References: <1279738541.4640.15.camel@Joe-Laptop.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
To: Joe Perches <joe@perches.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1279738541.4640.15.camel@Joe-Laptop.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Wed, Jul 21, 2010 at 12:55 PM, Joe Perches <joe@perches.com> wrote:
> Add #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> Convert printks to pr_<level>
> Convert a test w/ errmsg to a more normal form
>
> Uncompiled, untested

Hi Joe,

If going through the bother of changing printk statements, then most
of these should be converted to dev_err/info/dbg() instead of pr_*().
Nack.

Cheers,
g.

>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
> =A0drivers/spi/amba-pl022.c =A0 =A0| =A0 =A06 ++++--
> =A0drivers/spi/au1550_spi.c =A0 =A0| =A0 =A05 +++--
> =A0drivers/spi/dw_spi.c =A0 =A0 =A0 =A0| =A0 =A06 +++---
> =A0drivers/spi/dw_spi_pci.c =A0 =A0| =A0 =A02 +-
> =A0drivers/spi/omap_spi_100k.c | =A0 =A02 +-
> =A0drivers/spi/omap_uwire.c =A0 =A0| =A0 =A03 +--
> =A0drivers/spi/spi_lm70llp.c =A0 | =A0 23 +++++++++++------------
> =A07 files changed, 24 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/spi/amba-pl022.c b/drivers/spi/amba-pl022.c
> index f0a1418..427fa44 100644
> --- a/drivers/spi/amba-pl022.c
> +++ b/drivers/spi/amba-pl022.c
> @@ -30,6 +30,8 @@
> =A0* - add generic DMA framework support
> =A0*/
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> =A0#include <linux/init.h>
> =A0#include <linux/module.h>
> =A0#include <linux/device.h>
> @@ -1775,8 +1777,8 @@ pl022_probe(struct amba_device *adev, struct am=
ba_id *id)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENOMEM;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err_no_ioremap;
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 printk(KERN_INFO "pl022: mapped registers from 0x%08x t=
o %p\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0adev->res.start, pl022->virtbase);
> + =A0 =A0 =A0 pr_info("mapped registers from 0x%08llx to %p\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long long)adev->res.start, pl=
022->virtbase);
>
> =A0 =A0 =A0 =A0pl022->clk =3D clk_get(&adev->dev, NULL);
> =A0 =A0 =A0 =A0if (IS_ERR(pl022->clk)) {
> diff --git a/drivers/spi/au1550_spi.c b/drivers/spi/au1550_spi.c
> index 3c9ade6..d95a54e 100644
> --- a/drivers/spi/au1550_spi.c
> +++ b/drivers/spi/au1550_spi.c
> @@ -21,6 +21,8 @@
> =A0* Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A00211=
1-1307 =A0USA
> =A0*/
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> =A0#include <linux/init.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/slab.h>
> @@ -1012,8 +1014,7 @@ static int __init au1550_spi_init(void)
> =A0 =A0 =A0 =A0if (usedma) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ddma_memid =3D au1xxx_ddma_add_device(=
&au1550_spi_mem_dbdev);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!ddma_memid)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "au1550=
-spi: cannot add memory"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "dbdma device\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("cannot add memo=
ry dbdma device\n");
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0return platform_driver_probe(&au1550_spi_drv, au1550_s=
pi_probe);
> =A0}
> diff --git a/drivers/spi/dw_spi.c b/drivers/spi/dw_spi.c
> index d256cb0..c5d15d4 100644
> --- a/drivers/spi/dw_spi.c
> +++ b/drivers/spi/dw_spi.c
> @@ -490,8 +490,8 @@ static void pump_transfers(unsigned long data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (transfer->speed_hz !=3D speed) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0speed =3D transfer->sp=
eed_hz;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (speed > dws->max_f=
req) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(=
KERN_ERR "MRST SPI0: unsupported"
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "freq: %dHz\n", speed);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"MRST SPI0: unsupported freq: %dHz\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0speed);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0messag=
e->status =3D -EIO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto e=
arly_exit;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> @@ -525,7 +525,7 @@ static void pump_transfers(unsigned long data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0u16_writer : null_writer;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0default:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "MRST S=
PI0: unsupported bits:"
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("MRST SPI0: unsu=
pported bits:"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"%db\n=
", bits);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0message->status =3D -E=
IO;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto early_exit;
> diff --git a/drivers/spi/dw_spi_pci.c b/drivers/spi/dw_spi_pci.c
> index 1f52755..35f1811 100644
> --- a/drivers/spi/dw_spi_pci.c
> +++ b/drivers/spi/dw_spi_pci.c
> @@ -38,7 +38,7 @@ static int __devinit spi_pci_probe(struct pci_dev *=
pdev,
> =A0 =A0 =A0 =A0int pci_bar =3D 0;
> =A0 =A0 =A0 =A0int ret;
>
> - =A0 =A0 =A0 printk(KERN_INFO "DW: found PCI SPI controller(ID: %04x=
:%04x)\n",
> + =A0 =A0 =A0 pr_info("DW: found PCI SPI controller(ID: %04x:%04x)\n"=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdev->vendor, pdev->device);
>
> =A0 =A0 =A0 =A0ret =3D pci_enable_device(pdev);
> diff --git a/drivers/spi/omap_spi_100k.c b/drivers/spi/omap_spi_100k.=
c
> index 9bd1c92..b8b23f2 100644
> --- a/drivers/spi/omap_spi_100k.c
> +++ b/drivers/spi/omap_spi_100k.c
> @@ -425,7 +425,7 @@ static void omap1_spi100k_work(struct work_struct=
 *work)
> =A0 =A0 =A0 =A0spin_unlock_irq(&spi100k->lock);
>
> =A0 =A0 =A0 =A0if (status < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "spi transfer faile=
d with %d\n", status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("spi transfer failed with %d=
\n", status);
> =A0}
>
> =A0static int omap1_spi100k_transfer(struct spi_device *spi, struct s=
pi_message *m)
> diff --git a/drivers/spi/omap_uwire.c b/drivers/spi/omap_uwire.c
> index 160d326..445a454 100644
> --- a/drivers/spi/omap_uwire.c
> +++ b/drivers/spi/omap_uwire.c
> @@ -154,8 +154,7 @@ static int wait_uwire_csr_flag(u16 mask, u16 val,=
 int might_not_catch)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((w & mask) =3D=3D val)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (time_after(jiffies, max_jiffies)) =
{
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "%s: ti=
meout. reg=3D%#06x "
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 "mask=3D%#06x val=3D%#06x\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: timeout. re=
g=3D%#06x mask=3D%#06x val=3D%#06x\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __func__,=
 w, mask, val);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> diff --git a/drivers/spi/spi_lm70llp.c b/drivers/spi/spi_lm70llp.c
> index 7746a41..ac3a13d 100644
> --- a/drivers/spi/spi_lm70llp.c
> +++ b/drivers/spi/spi_lm70llp.c
> @@ -18,6 +18,8 @@
> =A0* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
> =A0*/
>
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> =A0#include <linux/init.h>
> =A0#include <linux/module.h>
> =A0#include <linux/kernel.h>
> @@ -202,9 +204,7 @@ static void spi_lm70llp_attach(struct parport *p)
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status;
>
> =A0 =A0 =A0 =A0if (lm70llp) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: spi_lm70llp instan=
ce already loaded. Aborting.\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRVNAME);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("instance already loaded. Ab=
orting\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> @@ -252,9 +252,8 @@ static void spi_lm70llp_attach(struct parport *p)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0status =3D spi_bitbang_start(&pp->bitbang);
> =A0 =A0 =A0 =A0if (status < 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "%s: spi_bitbang_start =
failed with status %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DRVNAME, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("spi_bitbang_start failed wi=
th status %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_off_and_release;
> =A0 =A0 =A0 =A0}
>
> @@ -277,14 +276,14 @@ static void spi_lm70llp_attach(struct parport *=
p)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0pp->info.controller_data =3D pp;
> =A0 =A0 =A0 =A0pp->spidev_lm70 =3D spi_new_device(pp->bitbang.master,=
 &pp->info);
> - =A0 =A0 =A0 if (pp->spidev_lm70)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(&pp->spidev_lm70->dev, "spidev_=
lm70 at %s\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_nam=
e(&pp->spidev_lm70->dev));
> - =A0 =A0 =A0 else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: spi_new_device=
 failed\n", DRVNAME);
> + =A0 =A0 =A0 if (!pp->spidev_lm70) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("spi_new_device failed\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0status =3D -ENODEV;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_bitbang_stop;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 dev_dbg(&pp->spidev_lm70->dev, "spidev_lm70 at %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_name(&pp->spidev_lm70->dev));
> +
> =A0 =A0 =A0 =A0pp->spidev_lm70->bits_per_word =3D 8;
>
> =A0 =A0 =A0 =A0lm70llp =3D pp;
> @@ -302,7 +301,7 @@ out_parport_unreg:
> =A0out_free_master:
> =A0 =A0 =A0 =A0(void) spi_master_put(master);
> =A0out_fail:
> - =A0 =A0 =A0 pr_info("%s: spi_lm70llp probe fail, status %d\n", DRVN=
AME, status);
> + =A0 =A0 =A0 pr_info("probe fail, status %d\n", status);
> =A0}
>
> =A0static void spi_lm70llp_detach(struct parport *p)
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
