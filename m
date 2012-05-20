From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH RFC] spi: Dont call prepare/unprepare transfer if not
	populated
Date: Sat, 19 May 2012 23:00:33 -0600
Message-ID: <20120520050033.1D3DD3E03B8@localhost>
References: <1336657841-2306-1-git-send-email-shubhrajyoti@ti.com>
	<CACRpkdZmr+i6d+k8XU6Qxo425=mFZo5kzUe1wFk+grxDshaoVA@mail.gmail.com>
	<20120511032455.6BB853E04A6@localhost>
	<20120515195801.GE23254@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, andrew-g2DYL2Zd6BY@public.gmane.org,
	Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120515195801.GE23254-g2DYL2Zd6BY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, 15 May 2012 21:58:01 +0200, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org> wrote:
> On Thu, May 10, 2012 at 09:24:55PM -0600, Grant Likely wrote:
> > On Thu, 10 May 2012 16:01:27 +0200, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > > On Thu, May 10, 2012 at 3:50 PM, Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org> wrote:
> > > 
> > > > Currently the prepare/unprepare transfer are called unconditionally.
> > > > The assumption is that every driver using the spi core queue infrastructure
> > > > has to populate the prepare and unprepare functions. This encourages
> > > > drivers to populate empty functions to prevent crashing.
> > > > This patch prevents the call to prepare/unprepare if not populated.
> > > >
> > > > Cc: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > > > Signed-off-by: Shubhrajyoti D <shubhrajyoti-l0cyMroinI0@public.gmane.org>
> > > 
> > > Great!
> > > Acked-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> > 
> > Applied, thanks (after fixing extra whitespace defect).
> 
> Hi Grant
> 
> Is this going to appear in linux-next soon? Can i depend on having
> this patch for 3.5?

It's pushed out now.

g.


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
