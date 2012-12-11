From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] SPI: SSP SPI Controller driver
Date: Tue, 11 Dec 2012 16:36:52 +0000
Message-ID: <20121211163653.01EC43E0C3E@localhost>
References: <1353464203.20353.6.camel@bichao>
	<20121206123856.002683E0AE3@localhost>
	<1355191216.30354.107.camel@bichao>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	alan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, ken.k.mills-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, sylvain.centelles-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1355191216.30354.107.camel@bichao>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 11 Dec 2012 10:00:16 +0800, chao bi <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> > > +static void dump_trailer(const struct device *dev, char *buf, int len, int sz)
> > > +{
> > > +	int tlen1 = (len < sz ? len : sz);
> > > +	int tlen2 =  ((len - sz) > sz) ? sz : (len - sz);
> > > +	unsigned char *p;
> > > +	static char msg[MAX_SPI_TRANSFER_SIZE];
> > 
> > Is this size a limitation of the hardware, of of the driver?
> 
> I think this size is attributed to the DMA controller's maximum block size. 
> On Medfield platform, the DMA controller used by SSP SPI has defined its maximum 
> block size and word width, so SPI transfer size should not exceed the maximum size that 
> DMA could transfer in one block.

Typically what a driver should do here is to split up the transfer into
multiple DMA operations. I won't nack the driver over this issue, but
the driver should not have a maximum transfer size limitation in this
way.

g.


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
