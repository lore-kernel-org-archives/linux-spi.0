From: Jun Chen <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Add the flag indicate to registe new device as
	children of master or not.
Date: Wed, 19 Dec 2012 04:44:03 -0500
Message-ID: <1355910243.1435.39.camel@chenjun-workstation>
References: <1355848174.1435.25.camel@chenjun-workstation>
	<20121218152623.GA26077@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Bi Chao <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121218152623.GA26077-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 2012-12-18 at 15:26 +0000, Mark Brown wrote:
> On Tue, Dec 18, 2012 at 11:29:34AM -0500, Jun Chen wrote:
> 
> >   * @master: Controller to which device is connected
> > + * device_was_children_of_master is flag which the device is registed
> > + * as the children of the bus
> 
> This isn't a kerneldoc style comment (it needs the @XXX: format).  The
> name is also extremely long, can't we think of something more concise?
> 
Thank for your suggestion, I will correct this comment and use concise
flag.

> > -	spi->dev.parent = &master->dev;
> > +	if (device_was_children_of_master == true)
> > +		spi->dev.parent = &master->dev;
> > +	else
> > +		spi->dev.parent = dev;
> 
> Can you provide an example of where this is useful?  Your changelog
> didn't make it clear and the code doesn't make it obvious either.

This spi_alloc_device function will be called in the spi_new_device
function to alloc new device as the master. But other way, it is called
by the of_register_spi_devices function to register new device as the
children of the master. I will update changlog to add it. 

@@ -434,7 +440,7 @@ struct spi_device *spi_new_device(struct spi_master
*master,
         * suggests syslogged diagnostics are best here (ugh).
         */
 
-       proxy = spi_alloc_device(master);
+       proxy = spi_alloc_device(master, false);
        if (!proxy)
                return NULL;
 
@@ -827,7 +833,7 @@ static void of_register_spi_devices(struct
spi_master *master)
 
        for_each_available_child_of_node(master->dev.of_node, nc) {
                /* Alloc an spi_device */
-               spi = spi_alloc_device(master);
+               spi = spi_alloc_device(master, true);


If I have mistake, pls correct me, thanks!




------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
