From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH 0/6] spi/spi-pl022 fixes
Date: Wed, 10 Aug 2011 16:12:51 +0200
Message-ID: <201108101612.51825.arnd@arndb.de>
References: <cover.1312887860.git.viresh.kumar@st.com>
	<4E420144.4010001@st.com>
	<CAKnu2MoTQTYMa4JvWyr7sPMhPyziTtnLeZLySUYxcuQC2Vu-6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>, viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>,
	Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>,
	Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>,
	Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>,
	Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAKnu2MoTQTYMa4JvWyr7sPMhPyziTtnLeZLySUYxcuQC2Vu-6Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wednesday 10 August 2011, Linus Walleij wrote:
> The basic assumption is that patches are orthogonal and apply
> without conflicts, i.e. patch different parts of the kernel tree or
> different lines in the same file.
> 
> Second assumption is that if patches do collide, the subsystem
> maintainer can solve most conflicts, and is expected to do
> so. Torvalds sets an example by requesting that subsystem
> maintainers do not fixup conflicts between subsystems so he
> can see them himself.
> 
> Then there are special cases when you get a strong
> coupling between patches.
> 
> In these special cases, ask the subsystem maintainer what to
> base the patches on. Usually it's some commit on the subsystem
> tree rather than -next.
> 
> This is my understanding of how we work, maybe I should
> patch Documentation/development-process/*, Arnd do you have
> anything to add?

No, your explanations are pretty much what I would have said.

	Arnd

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
