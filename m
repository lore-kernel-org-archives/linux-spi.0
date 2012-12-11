From: Jun Chen <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Tue, 11 Dec 2012 09:30:47 -0500
Message-ID: <1355236247.1435.12.camel@chenjun-workstation>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
	<20121206141938.0100f06f@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org,
	chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121206141938.0100f06f-Z/y2cZnRghHXmaaqVzeoHQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 2012-12-06 at 14:19 +0000, Alan Cox wrote:

> > > +late_initcall(intel_mid_ssp_spi_init);
> > 
> > Why late_initcall()? module_init() should be sufficient. Or better yet
> > replace the init and exit functions with module_pci_driver()
> 
> Thats a legacy of the old SPI code not handling bus and device
> registration in random orders. So it's no longer needed I believe.
> 
> Alan

We use the late_initcall because we want init the spi driver after
finished the dma driver with fs_initcall. Now we can not test the 
module_pci_driver replace the late_initcall because our kernel version
is not brach 3.7. So maybe we can use old the late_initcall and update
this code in the further, Do you agree?


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
