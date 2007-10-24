From: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Subject: Re: mmc_spi stopped working
Date: Wed, 24 Oct 2007 15:27:46 -0700
Message-ID: <200710241527.46458.david-b@pacbell.net>
References: <20071017211923.31fde15e@poseidon.drzeus.cx>
	<20071017193713.38D3923A5D5@adsl-69-226-248-13.dsl.pltn13.pacbell.net>
	<20071017215217.177cdb14@poseidon.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, tonyj-l3A5Bk7waGM@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Pierre Ossman <drzeus-list-p3sGCRWkH8CeZLLa646FqQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20071017215217.177cdb14-mgABNEgzgxm+PRNnhPf8W5YgPPQkE1Si@public.gmane.org>
Content-Disposition: inline
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

On Wednesday 17 October 2007, Pierre Ossman wrote:
> =

> On Wed, 17 Oct 2007 12:37:13 -0700
> David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > That issue is 49dce689ad4ef0fd1f970ef762168e4bd46f69a3, the
> > classdev-elimination patch from Tony Jones. =A0It broke the
> > "does this bus have more than one device" test by relocating
> > the relevant sysfs nodes.
> > =

> > Quick workaround for that one is to disable the fault return
> > after that test.
> > =

> =

> Annoying. Feel free to ping me when you've pushed fixes to Linus.

This is another case where whacking around in sysfs seems
unavoidable, even when it breaks things.  The patch below
works around that that change.  It seems like something that
should go through you, not directly through Linus...

- Dave

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	CUT HERE
Fix mmc-over-spi regression

Patch 49dce689ad4ef0fd1f970ef762168e4bd46f69a3 changed the sysfs data
structures for SPI in a way which broke the MMC-over-SPI host driver.

This patch fixes that regression by changing the scheme used to keep
from knowingly trying to use a shared bus segment, and updates the
adjacent comments slightly to better explain the issue.

Signed-off-by: David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>

--- a/drivers/mmc/host/mmc_spi.c	2007-10-23 21:24:41.000000000 -0700
+++ b/drivers/mmc/host/mmc_spi.c	2007-10-24 14:46:59.000000000 -0700
@@ -1165,6 +1165,23 @@ mmc_spi_detect_irq(int irq, void *mmc)
 	return IRQ_HANDLED;
 }
 =

+struct count_children {
+	unsigned	n;
+	struct bus_type	*bus;
+};
+
+static int maybe_count_child(struct device *dev, void *c)
+{
+	struct count_children *ccp =3D c;
+
+	if (dev->bus =3D=3D ccp->bus) {
+		if (ccp->n)
+			return -EBUSY;
+		ccp->n++;
+	}
+	return 0;
+}
+
 static int mmc_spi_probe(struct spi_device *spi)
 {
 	void			*ones;
@@ -1188,33 +1205,30 @@ static int mmc_spi_probe(struct spi_devi
 		return status;
 	}
 =

-	/* We can use the bus safely iff nobody else will interfere with
-	 * us.  That is, either we have the experimental exclusive access
-	 * primitives ... or else there's nobody to share it with.
+	/* We can use the bus safely iff nobody else will interfere with us.
+	 * Most commands consist of one SPI message to issue a command, then
+	 * several more to collect its response, then possibly more for data
+	 * transfer.  Clocking access to other devices during that period will
+	 * corrupt the command execution.
+	 *
+	 * Until we have software primitives which guarantee non-interference,
+	 * we'll aim for a hardware-level guarantee.
+	 *
+	 * REVISIT we can't guarantee another device won't be added later...
 	 */
 	if (spi->master->num_chipselect > 1) {
-		struct device	*parent =3D spi->dev.parent;
+		struct count_children cc;
 =

-		/* If there are multiple devices on this bus, we
-		 * can't proceed.
-		 */
-		spin_lock(&parent->klist_children.k_lock);
-		if (parent->klist_children.k_list.next
-				!=3D parent->klist_children.k_list.prev)
-			status =3D -EMLINK;
-		else
-			status =3D 0;
-		spin_unlock(&parent->klist_children.k_lock);
+		cc.n =3D 0;
+		cc.bus =3D spi->dev.bus;
+		status =3D device_for_each_child(spi->dev.parent, &cc,
+				maybe_count_child);
 		if (status < 0) {
 			dev_err(&spi->dev, "can't share SPI bus\n");
 			return status;
 		}
 =

-		/* REVISIT we can't guarantee another device won't
-		 * be added later.  It's uncommon though ... for now,
-		 * work as if this is safe.
-		 */
-		dev_warn(&spi->dev, "ASSUMING unshared SPI bus!\n");
+		dev_warn(&spi->dev, "ASSUMING SPI bus stays unshared!\n");
 	}
 =

 	/* We need a supply of ones to transmit.  This is the only time

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
