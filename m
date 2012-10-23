From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH 2/2] Revert "spi/pl022: enable runtime PM"
Date: Tue, 23 Oct 2012 12:48:42 +0100
Message-ID: <20121023114842.GA4293@n2100.arm.linux.org.uk>
References: <1349452272-4002-1-git-send-email-ulf.hansson@stericsson.com>
	<1349452272-4002-2-git-send-email-ulf.hansson@stericsson.com>
	<CAPDyKFqfE0u2CPzFKeHBE1LMtuetWabR94KuASPNhw4StDCfjw@mail.gmail.com>
	<20121023111019.GV4477@opensource.wolfsonmicro.com>
	<20121023111656.GT21164@n2100.arm.linux.org.uk>
	<20121023114130.GW4477@opensource.wolfsonmicro.com>
	<20121023114723.GU21164@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20121023114723.GU21164-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 23, 2012 at 12:47:23PM +0100, Russell King - ARM Linux wrote:
> On Tue, Oct 23, 2012 at 12:41:31PM +0100, Mark Brown wrote:
> > On Tue, Oct 23, 2012 at 12:16:56PM +0100, Russell King - ARM Linux wrote:
> > > On Tue, Oct 23, 2012 at 12:10:19PM +0100, Mark Brown wrote:
> > 
> > > > I *really* should not need to remind you to:
> > 
> > > >  - Not top post
> > > >  - Send patches in a form which can be applied if you want them applying
> > 
> > > How about actually applying the damned patch from the two-part patch set,
> > > rather than only the first, both of which has been around for almost a
> > > month now, and fixes what should never have gone into mainline in the
> > > first place?
> > 
> > Well, the reason for the second point is that I don't have a copy of the
> > patch any more, I need a copy of it before I can do anything.  Half the
> > reason these contentless top posts are annoying is that even if there's
> > something to do it's not actionable.
> > 
> > I have to say I had been under the impression that Linus' series that I
> > applied the other day dealt with all the outstanding stuff here; the
> > issues with this have been the awful changelogs and the overalapping
> > sets of patches.
> 
> Given that Linus is the one who introduced the fuckups in the first place,
> and afaics Linus' series has not been posted anywhere I can see, and I
> have been through the issues and worked with Ulf to get them fixed, I find
> that to be down right insulting by you.
> 
> You received *BOTH* of Ulf's patches on the 5th October.  Both needed
> to be applied *TOGETHER* to reduce the window where things got worse
> before they got better.  But for some goddamned unknown reason you decided
> to only take the first but totally and utterly ignored the second.
> 
> Well done, you've probably crapped this driver up again.  Way to go Mark.
> Now, tell us _exactly_ what patches you've applied to this driver.  Post
> them to this mailing list so we can see them, and see what state this
> driver is now in.
> 
> IMHO, you're being a terrible "maintainer" here - and this is being shown
> by the need to get you to post all the patches you've currently queued up
> for this.

Oh, and if you're unwilling to do that, then I'm taking both of Ulf's
patches, committing them to my fixes branch, and sending them off to
Linus tonight - because they are _NEEDED_ for the -rc series to fix
this driver.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_sfd2d_oct
