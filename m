From: Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 5/5] spi: fix return value check in hspi_probe().
Date: Thu, 3 Jan 2013 19:04:55 +0300
Message-ID: <20130103160455.GO7247@mwanda>
References: <1355271894-5284-1-git-send-email-tipecaml@gmail.com>
	<1355271894-5284-6-git-send-email-tipecaml@gmail.com>
	<87txrsqf7f.wl%kuninori.morimoto.gx@renesas.com>
	<20121219151154.937EC3E0AD7@localhost>
	<20121219163914.GN5032@mwanda>
	<20121222095620.83E243E07FA@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, kernel-janitors-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Cyril Roelandt <tipecaml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121222095620.83E243E07FA@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Dec 22, 2012 at 09:56:20AM +0000, Grant Likely wrote:
> On Wed, 19 Dec 2012 19:39:14 +0300, Dan Carpenter <dan.carpenter-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org> wrote:
> > On Wed, Dec 19, 2012 at 03:11:54PM +0000, Grant Likely wrote:
> > > On Tue, 11 Dec 2012 16:36:27 -0800 (PST), Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org> wrote:
> > > > 
> > > > Hi
> > > > 
> > > > > According to its documentation, clk_get() returns a "valid IS_ERR() condition
> > > > > containing errno", so we should call IS_ERR() rather than a NULL check.
> > > > > 
> > > > > Signed-off-by: Cyril Roelandt <tipecaml-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> > > > 
> > > > Acked-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> > > 
> > > Applied, thanks.
> > 
> > In another thread, we were just talking about who clk_get() can
> > return a NULL if !CONFIG_HAVE_CLK.  That might change to match the
> > documentation later...  Not sure.
> 
> So what is the solution here? Will the dummy clk_get() be changed, or is
> there more work needed on the drivers?
> 

This driver can't function without a clk.  It should select that at
build time instead of testing for it at probe.  Just checking for
IS_ERR() will NOT cause a NULL dereference so the patch is ok in
that respect.  I'm not sure if this can be build without
CONFIG_HAVE_CLK.

regards,
dan carpenter


------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnmore_122712
