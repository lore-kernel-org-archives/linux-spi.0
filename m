From: Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Add high priority message pump support
Date: Thu, 26 Jan 2012 15:50:57 +0000
Message-ID: <20120126155057.GA16017@sirena.org.uk>
References: <1327439672-638-1-git-send-email-linus.walleij@stericsson.com>
	<20120125140215.GB2054@sirena.org.uk>
	<CACRpkdauRqVzUbr59P75Zyd-AFc8Y7fBJ=AWoSMQPYxXUJjBMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Linus Walleij <linus.walleij-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Chris Blair <chris.blair-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdauRqVzUbr59P75Zyd-AFc8Y7fBJ=AWoSMQPYxXUJjBMw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Jan 26, 2012 at 03:48:59PM +0100, Linus Walleij wrote:
> On Wed, Jan 25, 2012 at 3:02 PM, Mark Brown <broonie-GFdadSzt00ze9xe1eoZjHA@public.gmane.org> wrote:

> > It really feels like we should be pulling this into the core - lots of
> > drivers use a workqueue to drive data through the system and they're all
> > going to have exactly the same issue.

> That reads to me like the entire message queue and "transfer pump"
> mechanism from the PL022 driver should be made into generic
> code. That is the key ingredient from the PL022 driver that has
> allowed us to get real nice throughput on it.

> And that observation is correct, but a bit of upfront code.

Probably, yes - lots of drivers seem to have a workqueue of some kind
that drives the actual transfers and I strongly suspect that there's a
lot of generality there.  I have to confess that I had just thought that
"transfer pump" was an obscure bit of jargon in the changelog so it's
possible it's doing something device specific but it'd seem surprising
TBH.

> I would make it an opt-in for SPI drivers to have a generic
> message queue instead of treating messages in a one-by-one
> manner.

That'd certainly be nice - where things use a workqueue they do often
just pass the entire request from the caller off to it in one fell swoop
so that sounds compatible.

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
