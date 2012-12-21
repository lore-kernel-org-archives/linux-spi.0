From: Jun Chen <jun.d.chen-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Add the flag indicate to registe new device as
	children of master or not.
Date: Fri, 21 Dec 2012 12:39:52 -0500
Message-ID: <1356111592.731.4.camel@chenjun-workstation>
References: <1355848174.1435.25.camel@chenjun-workstation>
	<20121218152623.GA26077@sirena.org.uk>
	<1355910243.1435.39.camel@chenjun-workstation>
	<20121219090416.GK4985@opensource.wolfsonmicro.com>
	<20121219162142.9E1123E0B72@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bi Chao <chao.bi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	jun.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121219162142.9E1123E0B72@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, 2012-12-19 at 16:21 +0000, Grant Likely wrote:
> On Wed, 19 Dec 2012 09:04:16 +0000, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> > On Wed, Dec 19, 2012 at 04:44:03AM -0500, Jun Chen wrote:
> > 
> > > This spi_alloc_device function will be called in the spi_new_device
> > > function to alloc new device as the master. But other way, it is called
> > > by the of_register_spi_devices function to register new device as the
> > > children of the master. I will update changlog to add it. 
> > 
> > But why is this a bad thing?  You've said what's happening but not why
> > it's a problem.
> 
> spi_devices should always be children of the spi_master. If that is not
> the case then it is a bug to be fixed.
> 

When many boards initializing, boards will call function
spi_register_board_info to create bi->board_info,Then spi driver probe
to call spi_register_master to register the driver and in the function
spi_match_master_to_boardinfo To create new spi device, and this cases
the spi_devices are not children of the spi_master.
Many drivers do these steps. If all spi_devices must be children of the
spi_master, Do spi core have plan to delete this way? 
Or spi core can hold this way for many drivers. 
Thanks! 



------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
