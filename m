From: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Subject: Re: [PATCH V2 6/6] spi/spi-pl022: Request/free DMA channels as and
	when required.
Date: Wed, 10 Aug 2011 11:30:52 +0100
Message-ID: <20110810103052.GI1831@n2100.arm.linux.org.uk>
References: <cover.1312965741.git.viresh.kumar@st.com>
	<566c0525199f498f04422d4c3b2ddd7466648c20.1312965742.git.viresh.kumar@st.com>
	<20110810090042.GE1831@n2100.arm.linux.org.uk>
	<4E424F7B.2000800@st.com>
	<CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Cc: Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>,
	Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>,
	Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>, "Koul, Vinod" <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>,
	Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>, Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>,
	Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CABb+yY0Qvuhrn+FUhWDHMwUjv=nR4MOfLeDfTzG17HXEuu2pmA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 10, 2011 at 03:39:28PM +0530, Jassi Brar wrote:
> On Wed, Aug 10, 2011 at 2:59 PM, viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> > On 08/10/2011 02:30 PM, Russell King - ARM Linux wrote:
> >>> > They must be allocated when they are required and must be freed aft=
er we are
> >>> > done with transfers. So that they can be used by other users.
> >> Which DMA engine driver requires this?
> >>
> >
> > dw_dmac.c
> >
> >> Normally, when we have DMA engine drivers with multiple request signal=
s,
> >> the slave peripheral side publishes several virtual channels which are
> >> claimed by the peripheral drivers. =A0This (amongst other things) allo=
ws
> >> the peripheral drivers to hold claim to one of the virtual channels
> >> all the time that it's required.
> >
> > If users of DMA expect DMA engine drivers to work this way, then we sho=
uld
> > have this mentioned clearly in DMA slave documentation.
> =

> The requirement stems from the fact that most DMACs(esp third party) coul=
d be
> made to reroute req-signals by the platform, it has not much to do with t=
he API.
> IMO, all dmac drivers should be implemented that way to be on the safer s=
ide.

No it isn't.  It's to do with how the physical channels are used.

---------------------------------------------------------------------------=
---
uberSVN's rich system and user administration capabilities and model =

configuration take the hassle out of deploying and managing Subversion and =

the tools developers use with it. Learn more about uberSVN and get a free =

download at:  http://p.sf.net/sfu/wandisco-dev2dev
