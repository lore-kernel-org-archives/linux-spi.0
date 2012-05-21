From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH] spi: bitbang: convert to using core message queue
Date: Mon, 21 May 2012 13:19:31 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1205211306120.30522@axis700.grange>
References: <Pine.LNX.4.64.1203141837170.30291@axis700.grange>
	<20120315092923.951203E04FD@localhost>
	<CACRpkdZNQZyx-HZjzyMctpUQJtNYMwq5KsdE6RTFwKcHuz_X+w@mail.gmail.com>
	<Pine.LNX.4.64.1203170036590.20979@axis700.grange>
	<CACRpkdYFj6btOx75_myH45+tyqg3h21xnTL7PofydNeOVVQz_g@mail.gmail.com>
	<20120520030229.C10943E046E@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120520030229.C10943E046E@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, 19 May 2012, Grant Likely wrote:

> On Wed, 16 May 2012 08:57:48 +0200, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> > On Sat, Mar 17, 2012 at 12:39 AM, Guennadi Liakhovetski
> > <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org> wrote:
> > 
> > > The SPI subsystem core now manages message queues internally. Remove the
> > > local message queue implementation from the spi-bitbang driver and
> > > migrate to the common one.
> > >
> > > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> > 
> > Grant have you picked this patch? It arrived pretty early so should be
> > quite ripe by now...
> 
> Hmmm, two problems.  The patch is mailer damaged which I fixed
> manually,

Sorry, that's _extremely_ unlikely. I don't subscribe to spi-devel, so, I 
cannot verify the patch as it appeared on the list, but I don't think I 
used any special procedure, when sending that patch, just the same as what 
I use to send (almost) all my patches, which is also confirmed by what it 
looks like in my "sent" folder.

> but I also cannot figure out what it is based on.

Right, it was based on another spi-bitbang patch, that we dropped.

> Guennadi, could you please respin this patch on top of current mainline 
> and repost?

Sure, I'll resend it and a couple of cosmetic improvements in a minute.

> Thanks,
> g.

Thanks
g. ;-)
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
