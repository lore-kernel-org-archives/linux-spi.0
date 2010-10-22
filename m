From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [Uclinux-dist-devel] [PATCH] spi/bfin_sport_spi: new driver to
	emulate a SPI bus using Blackfin SPORT peripheral
Date: Fri, 22 Oct 2010 01:29:16 -0600
Message-ID: <20101022072916.GD8205@angua.secretlab.ca>
References: <1287730415-6246-1-git-send-email-vapier@gentoo.org>
	<20101022071630.GA15440@angua.secretlab.ca>
	<AANLkTi=_u_0FksCzJix1Dw9Ui-Xf5C9J46CUvppSqUCJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: uclinux-dist-devel-ZG0+EudsQA8dtHy/vicBwGD2FQJk+8+b@public.gmane.org, Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	David Brownell <dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>,
	spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <AANLkTi=_u_0FksCzJix1Dw9Ui-Xf5C9J46CUvppSqUCJ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Oct 22, 2010 at 03:24:11AM -0400, Mike Frysinger wrote:
> On Fri, Oct 22, 2010 at 03:16, Grant Likely wrote:
> > On Fri, Oct 22, 2010 at 02:53:35AM -0400, Mike Frysinger wrote:
> >> From: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >>
> >> The Blackfin SPORT peripheral is a pretty flexible device. =A0With eno=
ugh
> >> coaching, we can make it generate SPI compatible waveforms. =A0This is
> >> desirable as the SPORT can run at much higher clock frequencies than t=
he
> >> dedicated on-chip SPI peripheral, and it can do full duplex DMA. =A0It=
 also
> >> opens up the possibility of multiple SPI buses in case someone wants to
> >> dedicate a whole bus to a specific part that does not play well with
> >> others.
> >>
> >> Signed-off-by: Cliff Cai <cliff.cai-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Signed-off-by: Michael Hennerich <michael.hennerich-OyLXuOCK7orQT0dZR+AlfA@public.gmane.org>
> >> Signed-off-by: Mike Frysinger <vapier-aBrp7R+bbdUdnm+yROfE0A@public.gmane.org>
> >> ---
> >> =A0drivers/spi/Kconfig =A0 =A0 =A0 =A0 =A0| =A0 10 +
> >> =A0drivers/spi/Makefile =A0 =A0 =A0 =A0 | =A0 =A01 +
> >> =A0drivers/spi/bfin_sport_spi.c | =A0925 +++++++++++++++++++++++++++++=
+++++++++++++
> >
> > Remind me about this one after 2.6.37-rc1 is released. =A0It is too late
> > for the current merge window.
> =

> isnt this why git supports multiple branches so easily ?  i dont
> expect you to take it for this merge window, but it seems silly for
> subsys maintainers to all have their own "merge" window.

'cause I don't have time to review it right now, and I might forget
about it later.

g.

---------------------------------------------------------------------------=
---
Nokia and AT&T present the 2010 Calling All Innovators-North America contest
Create new apps & games for the Nokia N8 for consumers in  U.S. and Canada
$10 million total in prizes - $4M cash, 500 devices, nearly $6M in marketing
Develop with Nokia Qt SDK, Web Runtime, or Java and Publish to Ovi Store =

http://p.sf.net/sfu/nokia-dev2dev
