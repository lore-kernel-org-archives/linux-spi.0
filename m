From: "Trilok Soni" <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] OMAP: Add OMAP24XX Multichannel SPI
	controller driver
Date: Mon, 2 Jul 2007 10:40:01 +0530
Message-ID: <5d5443650707012210w32f578c4k78f6bd76f9a8ec6@mail.gmail.com>
References: <5d5443650706182323k4cc99707v8ad8dc5cff24ca3e@mail.gmail.com>
	<5d5443650706210037k6562d50frc7fc2f261a2e9352@mail.gmail.com>
	<5d5443650706290236g14da1c09hc023d12954674f71@mail.gmail.com>
	<200706291236.11069.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: juha.yrjola-EmnPodGKVbzby3iVrkZq2A@public.gmane.org,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, imre.deak-EmnPodGKVbzby3iVrkZq2A@public.gmane.org,
	samuel.ortiz-EmnPodGKVbzby3iVrkZq2A@public.gmane.org
To: "David Brownell" <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200706291236.11069.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
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

On 6/30/07, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> On Friday 29 June 2007, Trilok Soni wrote:
> > On 6/21/07, Trilok Soni <soni.trilok-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> > > On 6/21/07, David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org> wrote:
> > > > That's pretty much the latest from omap-git, right?
> > > >
> > > > If so, please try the appended patch, which includes various
> > > > bugfixes and cleanups I've had in my queue for a while.
> > > >
> > >
> > > Thanx David. Yes it is from latest omap-git. Tony may like to apply
> > > this patch to omap-git, instead of waiting it to come from upstream.
> > >
> > > I have appended your patch with mine and attached that patch, it is
> > > now build tested only, someone need to help in testing this patch as
> > > other team here took my H4 for some high-priority work :(
> >
> > No updates on testing this driver?
>
> The omap-git version plus my patch works for me ... ;)
>

The patch submitted by me is omap-git version + your patch. So, it is
OK to take that patch for mainline inclusion.


-- 
--Trilok Soni

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
