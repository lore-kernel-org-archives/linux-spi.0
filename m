From: viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [PATCH 2/6] spi/spi-pl022: Use GFP_NOWAIT for allocation from
	tasklet
Date: Wed, 10 Aug 2011 08:57:42 +0530
Message-ID: <4E41FAAE.40907@st.com>
References: <cover.1312887860.git.viresh.kumar@st.com>	<cb966698764017627e85a4c85d1d781cf3fc9819.1312887860.git.viresh.kumar@st.com>
	<CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Pratyush ANAND <pratyush.anand-qxv4g6HH51o@public.gmane.org>,
	Rajeev KUMAR <rajeev-dlh.kumar-qxv4g6HH51o@public.gmane.org>, Bhavna YADAV <bhavna.yadav-qxv4g6HH51o@public.gmane.org>,
	Bhupesh SHARMA <bhupesh.sharma-qxv4g6HH51o@public.gmane.org>,
	Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>,
	"linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipin KUMAR <vipin.kumar-qxv4g6HH51o@public.gmane.org>, Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	Amit VIRDI <Amit.VIRDI-qxv4g6HH51o@public.gmane.org>,
	Vipul Kumar SAMAR <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	Deepak SIKRI <deepak.sikri-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CABb+yY3CuYqNcpvdP8fa6FsaN3EBDAXivKSP56gRh6-oPyp2Mg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 08/09/2011 04:56 PM, Jassi Brar wrote:
> Since this could be called from when we actually need the transfer start,
> maybe we could try harder using GFP_ATOMIC instead ?

Yes. Will do it.

-- 
viresh

------------------------------------------------------------------------------
uberSVN's rich system and user administration capabilities and model 
configuration take the hassle out of deploying and managing Subversion and 
the tools developers use with it. Learn more about uberSVN and get a free 
download at:  http://p.sf.net/sfu/wandisco-dev2dev
