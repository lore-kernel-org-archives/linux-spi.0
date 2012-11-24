From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3.7] spi/bcm63xx: fix transfer bits_per_words check
Date: Sat, 24 Nov 2012 19:19:34 +0100
Message-ID: <CAOiHx=nXRgF6YCLJ+U77boeuuWb6TOdT9dg=cie=Gruz6eS6xQ@mail.gmail.com>
References: <1353764690-5961-1-git-send-email-jonas.gorski@gmail.com>
	<20121124172801.GC4719@opensource.wolfsonmicro.com>
	<CAOiHx=np+CQHzBAhF-b24cUjVHeYpTpbEQG9MMqgXL_31iGvZg@mail.gmail.com>
	<20121124180151.GJ4719@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>, spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121124180151.GJ4719-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 24 November 2012 19:01, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Sat, Nov 24, 2012 at 06:53:10PM +0100, Jonas Gorski wrote:
>> On 24 November 2012 18:28, Mark Brown
>
>> > This is now done by the SPI core, there's no need for individual drivers
>> > to do this.
>
>> So that will go to stable kernels, too?
>
> No, I hadn't sent it there.  I'd really expect that anyone using a
> release kernel would've noticed this if there were a problem, it's
> pretty obvious when it goes wrong, and I tend to be extremely
> conservative with changes to stable kernels especially framework ones.

Well, I noticed this particular problem on a 3.6 kernel (3.6.7 to be
exact), so by that definition at least one noticed, unless I don't
count as anyone ;-). So, how can I make this driver less broken for
release kernels? I somewhat doubt the framework change will be picked
up by release kernel maintainers.

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
