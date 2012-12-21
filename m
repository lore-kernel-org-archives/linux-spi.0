From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mpc512x-psc: don't use obsolet cell-index
	property
Date: Fri, 21 Dec 2012 19:29:14 +0000
Message-ID: <20121221192914.77D523E03CE@localhost>
References: <1356100981-18685-1-git-send-email-agust@denx.de>
	<CACxGe6sT_fsdcGN1OCRBVMXzAiDbbf=SnKp2F8eYL+F5Qoyu=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CACxGe6sT_fsdcGN1OCRBVMXzAiDbbf=SnKp2F8eYL+F5Qoyu=g@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, 21 Dec 2012 14:48:38 +0000, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org> wrote:
> On Fri, Dec 21, 2012 at 2:43 PM, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org> wrote:
> > Use unique PSCx register base offset to obtain the
> > SPI PSC number used for SPI bus id.
> >
> > Signed-off-by: Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
> 
> Don't do this. If you really want to assign a specific bus number,
> then use a property in /aliases. cell-index has been deprecated a very
> long time ago now.

Ummm.. I really should read patches before I reply to them. I see you're
removing cell-index, not adding it back in. It is fine.

Aliases would be a more generic solution though. Would this following
change work for you? Try it out and let me know.

g.

---
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 84c2861..de9f6ee 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -983,6 +983,9 @@ int spi_register_master(struct spi_master *master)
 	if (master->num_chipselect == 0)
 		return -EINVAL;
 
+	if ((master->bus_num < 0) && master->dev.of_node)
+		master->bus_num = of_alias_get_id(master->dev.of_node, "spi");
+
 	/* convention:  dynamically assigned bus IDs count down from the max */
 	if (master->bus_num < 0) {
 		/* FIXME switch to an IDR based scheme, something like


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
