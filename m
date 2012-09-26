From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/2] spi:pl022: Disable/Enable functional clock from
	suspend/resume
Date: Wed, 26 Sep 2012 14:41:56 +0200
Message-ID: <CACRpkdZLUUXw5TDwTqtP10YaRHEuHNHq9gMY-YSNeZ+21=cZRg@mail.gmail.com>
References: <1348658647-25975-1-git-send-email-vipulkumar.samar@st.com>
	<1348658647-25975-2-git-send-email-vipulkumar.samar@st.com>
	<CACRpkdampxUw0=NO6cs679C-r0_AnPEaTYVc+GppRkKGn32p-w@mail.gmail.com>
	<20120926121946.GO4428@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Vipul Kumar Samar <vipulkumar.samar-qxv4g6HH51o@public.gmane.org>,
	linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org,
	"Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120926121946.GO4428-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Sep 26, 2012 at 2:19 PM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Sep 26, 2012 at 02:17:36PM +0200, Linus Walleij wrote:
>> On Wed, Sep 26, 2012 at 1:24 PM, Vipul Kumar Samar
>
>> > SPI functional clock must be disalble/enable in non RTPM suspend/resume
>> > hooks. Currently it is only done for RTPM cases.
>
>> > This patch add support to disable/enbale clock for conventional
>> > suspend/resume calls.
>
>> Cross dependency between runtime suspend/resume and
>> common suspend/resume. Oh the horror ...
>
> This should be fine, we runtime resume before we suspend.
(...)
> This was clarified at some point relatively recently with the above
> (which is essentially the same as the solution you describe).

Oh. How come that whenever I poke my nose into this stuff I
feel like a compleat n00b X-D

Can you point me to the relevant posts/doc so I can read up on
it, would be much appreciated!

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
