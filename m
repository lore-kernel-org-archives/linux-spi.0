From: Alan Cox <alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Thu, 6 Dec 2012 14:19:38 +0000
Message-ID: <20121206141938.0100f06f@bob.linux.org.uk>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121206123856.002683E0AE3@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

> I think I've asked this question before, but I can't remember if I've
> gotten an answer. How is this different from the designware spi
> controller that is already in the tree for medfield and moorestown MID
> platforms? (drivers/spi/spi-dw-mid.c).

Different devices.


> ... Okay, so I just went looking for the read_SSSR() function because
> I wanted to know how it was defined. I just discovered that this
> driver is the same as drivers/spi/spi-pxa2xx.c with a PCI front end
> bolted on.

Quite possible - I wans't aware of that but they may well come from
the same origin.
 
> > +late_initcall(intel_mid_ssp_spi_init);
> 
> Why late_initcall()? module_init() should be sufficient. Or better yet
> replace the init and exit functions with module_pci_driver()

Thats a legacy of the old SPI code not handling bus and device
registration in random orders. So it's no longer needed I believe.

Alan

------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
