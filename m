From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH 28/28] Blackfin SPI: init early
Date: Mon, 18 Oct 2010 00:21:24 -0600
Message-ID: <20101018062124.GE19399@angua.secretlab.ca>
References: <1287356381-31495-1-git-send-email-vapier@gentoo.org>
	<1287356381-31495-29-git-send-email-vapier@gentoo.org>
	<20101018061211.GC19399@angua.secretlab.ca>
	<AANLkTi=AwuK8-U8+Ezm1JVrvD1Taqwq53EzahA5Ag4Uf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
        David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
        Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
        uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=AwuK8-U8+Ezm1JVrvD1Taqwq53EzahA5Ag4Uf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://blackfin.uclinux.org/mailman/options/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=unsubscribe>
List-Archive: <http://blackfin.uclinux.org/pipermail/uclinux-dist-devel>
List-Post: <mailto:uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org>
List-Help: <mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=help>
List-Subscribe: <https://blackfin.uclinux.org/mailman/listinfo/uclinux-dist-devel>,
	<mailto:uclinux-dist-devel-request-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org?subject=subscribe>
Sender: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
Errors-To: uclinux-dist-devel-bounces-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Mon, Oct 18, 2010 at 02:14:28AM -0400, Mike Frysinger wrote:
> On Mon, Oct 18, 2010 at 02:12, Grant Likely wrote:
> > On Sun, Oct 17, 2010 at 06:59:41PM -0400, Mike Frysinger wrote:
> >> From: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >>
> >> Some systems using this bus sometimes have very basic devices on them
> >> such as regulators. =A0So we need to be loaded even earlier in case the
> >> devices are used before userspace is loaded. =A0Therefore register in
> >> subsys_initcall().
> >
> > This shouldn't have anything to do with userspace since regardless of
> > the initcall, all of this setup should be complete before userspace
> > starts. =A0Rather I expect it has to do with an earlier initcall wanting
> > to have the spi bus up earlier than module_initcall. =A0The description
> > of this patch seems wrong.
> =

> probably.  it doesnt make the change wrong though.  many spi/i2c
> busses do the same thing.

Not saying it does.  Just asking for the commit log to be changed.

> =

> > On that note, this is something that needs to be revisited. =A0Needing
> > to play these kind of games highlights a failure of the device model,
> > or the way that it is being used. =A0(The patch is okay; but it does
> > highlight some ugliness in the current kernel)
> =

> i agree, but i'm not about to embark on fixing these fundamental issues.

Indeed.  I'm certainly not asking you to.  Just thinking out loud.  :-)

g.
