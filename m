From: viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>
Subject: Re: [QUERY] Behavior of spi slave memories w.r.t chip select signal.
Date: Fri, 13 May 2011 14:50:37 +0530
Message-ID: <4DCCF7E5.2090009@st.com>
References: <4DCA0B77.8060700@st.com>	<4DCCAB19.2020302@st.com>
	<BANLkTik2OxGdQ7z1JBAsE+=gc5UCgx3wEA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Dinesh Kumar SHARMA <dinesh.sharma-qxv4g6HH51o@public.gmane.org>,
	Martin BERGSTROM <martin.bergstrom-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Armando VISCONTI <armando.visconti-qxv4g6HH51o@public.gmane.org>,
	Marcus COOPER <marcus.xm.cooper-0IS4wlFg1OjSUeElwK9/Pw@public.gmane.org>,
	Shiraz HASHIM <shiraz.hashim-qxv4g6HH51o@public.gmane.org>,
	"spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	Vikas MANOCHA <vikas.manocha-qxv4g6HH51o@public.gmane.org>,
	"linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
	<linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
To: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Jamie Iles <jamie-wmLquQDDieKakBO8gow8eQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BANLkTik2OxGdQ7z1JBAsE+=gc5UCgx3wEA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 05/13/2011 12:24 PM, Linus Walleij wrote:
> 2011/5/13 viresh kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>:
>> Linus, Jamie,
>>
>> Have you ever seen this kind of issue? Which spi slave memories did you used for testing?
>> I am using standard pl0022 and m25p80 driver. Tried in all modes: polling, interrupt, dma.
> 
> Not really. I'll throw in a few people on CC and see if they have some hints.
> 

Thanks guys.

Issue is solved now, data must be latched on Rising Edge and i have passed phase as falling edge.

--
viresh

------------------------------------------------------------------------------
Achieve unprecedented app performance and reliability
What every C/C++ and Fortran developer should know.
Learn how Intel has extended the reach of its next-generation tools
to help boost performance applications - inlcuding clusters.
http://p.sf.net/sfu/intel-dev2devmay
