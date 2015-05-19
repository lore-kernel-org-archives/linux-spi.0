From: Brian Norris <computersforpeace@gmail.com>
Subject: Re: [PATCH] Documentation: dt: mtd: replace "nor-jedec" binding with
 "jedec,spi-nor"
Date: Mon, 18 May 2015 18:34:15 -0700
Message-ID: <20150519013415.GV11598@ld-irv-0074>
References: <1431624773-4165-1-git-send-email-computersforpeace@gmail.com>
 <20150515195541.GL11598@ld-irv-0074>
 <20150518104501.GD3551@leverpostej>
 <20150518183442.GR11598@ld-irv-0074>
 <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Rutland <mark.rutland@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <Pawel.Moll@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Stephen Warren <swarren@wwwdotorg.org>,
	Marek Vasut <marex@denx.de>,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
	linux-spi <linux-spi@vger.kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUCj2AXk_0mAgRfAStrveHPi=Rp2g-b177zO_ode8NaCw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Geert,

On Mon, May 18, 2015 at 08:51:46PM +0200, Geert Uytterhoeven wrote:
> On Mon, May 18, 2015 at 8:34 PM, Brian Norris
> <computersforpeace@gmail.com> wrote:
> > On Mon, May 18, 2015 at 11:45:01AM +0100, Mark Rutland wrote:
> >> On Fri, May 15, 2015 at 08:55:41PM +0100, Brian Norris wrote:
> >> > It really helps if I test patches...
> >> >
> >> > On Thu, May 14, 2015 at 10:32:53AM -0700, Brian Norris wrote:
> > [...]
> >> > > @@ -305,7 +305,7 @@ static const struct spi_device_id m25p_ids[] = {
> >> > >    * Generic support for SPI NOR that can be identified by the JEDEC READ
> >> > >    * ID opcode (0x9F). Use this, if possible.
> >> > >    */
> >> > > - {"nor-jedec"},
> >> > > + {"jedec,spi-nor"},
> >> >
> >> > So I forgot (again; we hit this before) that the SPI/OF framework strips
> >> > everything before the first comma before binding devices. See
> >> > of_modalias_node(). So I'll have to squash in the patch below to get a
> >> > usable binding.
> >>
> >> Is it not possible to use the of_match_table on spi_driver::driver? If
> >> not, we really should make it so.
> >
> > Hmm, it does look like spi.c supports multiple matching mechanisms, so I
> > guess m25p80.c could match some with of_match_table and some with
> > modalias/spi_driver.id_table. See:
> >
> > static int spi_match_device(struct device *dev, struct device_driver *drv)
> > {
> >         const struct spi_device *spi = to_spi_device(dev);
> >         const struct spi_driver *sdrv = to_spi_driver(drv);
> >
> >         /* Attempt an OF style match */
> >         if (of_driver_match_device(dev, drv))
> >                 return 1;
> >         // ^^^^ we aren't yet (but could be) using this
> >
> >         /* Then try ACPI */
> >         if (acpi_driver_match_device(dev, drv))
> >                 return 1;
> >
> >         if (sdrv->id_table)
> >                 return !!spi_match_id(sdrv->id_table, spi);
> >         // ^^^^ we're currently only using this
> >
> >         return strcmp(spi->modalias, drv->name) == 0;
> > }
> >
> > I'll see about patching this for 4.2. We have a working solution for
> > 4.1 at least.
> 
> When using DT:
>   - spi_driver.id_table is used to match with vendor-stripped DT "compatible"
>     entries.
>   - spi_driver.driver.of_match_table is used to match with full DT "compatible"
>     entries.
> 
> Note that stripping of vendor names from DT "compatible" entries is done
> for the _first_ "compatible" entry in the device node only!
> Hence
> 
>         compatible = "myvendor,m25p80";
> 
> will match against "m25p80" in m25p_ids[], while
> 
>         compatible = "myvendor,shinynewdevice", "st,m25p80";
> 
> will _not_ match against "m25p80" in m25p_ids[], and fail to probe in
> the absence of a driver entry for the first (real) "compatible" entry.

This last part is a little odd, but understandable I guess.

> I2c behaves similarly.

So how about the following patch? It seems like we'll need to be able to
ignore useless 'modalias' values in cases like this:

	// modalias = "shinynewdevice"
	compatible = "myvendor,shinynewdevice", "jedec,spi-nor";

and also if somebody leaves off the entire shinynewdevice string:

	// modalias = "spi-nor"
	compatible = "jedec,spi-nor";

So we rework the spi-nor library to not reject "bad" names, and just
fall back to autodetection, and we add the .of_match_table to properly
catch all "jedec,spi-nor".

Signed-off-by: Brian Norris <computerfsorpeace@gmail.com>
---
 drivers/mtd/devices/m25p80.c  | 18 +++++++++++-------
 drivers/mtd/spi-nor/spi-nor.c |  8 ++++----
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
index 3af137f49ac9..30d608775f5a 100644
--- a/drivers/mtd/devices/m25p80.c
+++ b/drivers/mtd/devices/m25p80.c
@@ -223,8 +223,6 @@ static int m25p_probe(struct spi_device *spi)
 	 */
 	if (data && data->type)
 		flash_name = data->type;
-	else if (!strcmp(spi->modalias, "spi-nor"))
-		flash_name = NULL; /* auto-detect */
 	else
 		flash_name = spi->modalias;
 
@@ -301,19 +299,25 @@ static const struct spi_device_id m25p_ids[] = {
 	{"w25q128"},	{"w25q256"},	{"cat25c11"},
 	{"cat25c03"},	{"cat25c09"},	{"cat25c17"},	{"cat25128"},
 
-	/*
-	 * Generic support for SPI NOR that can be identified by the JEDEC READ
-	 * ID opcode (0x9F). Use this, if possible.
-	 */
-	{"spi-nor"},
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, m25p_ids);
 
+static const struct of_device_id m25p_of_table[] = {
+	/*
+	 * Generic compatibility for SPI NOR that can be identified by the
+	 * JEDEC READ ID opcode (0x9F). Use this, if possible.
+	 */
+	{ .compatible = "jedec,spi-nor" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, m25p_of_table);
+
 static struct spi_driver m25p80_driver = {
 	.driver = {
 		.name	= "m25p80",
 		.owner	= THIS_MODULE,
+		.of_match_table = m25p_of_table,
 	},
 	.id_table	= m25p_ids,
 	.probe	= m25p_probe,
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index 14a5d2325dac..390d6fa0a53f 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -1003,11 +1003,11 @@ int spi_nor_scan(struct spi_nor *nor, const char *name, enum read_mode mode)
 	if (ret)
 		return ret;
 
-	/* Try to auto-detect if chip name wasn't specified */
-	if (!name)
-		id = spi_nor_read_id(nor);
-	else
+	if (name)
 		id = spi_nor_match_id(name);
+	/* Try to auto-detect if chip name wasn't specified or not found */
+	if (!id)
+		id = spi_nor_read_id(nor);
 	if (IS_ERR_OR_NULL(id))
 		return -ENOENT;
 
-- 
1.9.1
