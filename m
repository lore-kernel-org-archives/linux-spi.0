From: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] spi/pl022: Fill master->dev.of_node to get spi devices
	registered via DT
Date: Wed, 22 Aug 2012 11:24:01 +0200
Message-ID: <CACRpkdZfJF29EP=S0p1FxxXQf549ZbOik0fbf==BqY_+3Saz=Q@mail.gmail.com>
References: <b76734a7fe072120c174bc76d287cff361a2492a.1345255737.git.viresh.kumar@linaro.org>
	<CACRpkdYhQM+=2jYhY2LW8FP-31Me5+p=0ghpjFR22eqskijB9A@mail.gmail.com>
	<CAKohpo=KA0=LtqTRMSTbii01Thg5RnLKVUF0EYOyYhDPW5CAgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Roland Stigge <stigge-uj/7R2tJ6VmzQB+pC5nmwQ@public.gmane.org>,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <CAKohpo=KA0=LtqTRMSTbii01Thg5RnLKVUF0EYOyYhDPW5CAgA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Wed, Aug 22, 2012 at 11:16 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> On 19 August 2012 03:56, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
>> On Sat, Aug 18, 2012 at 4:25 AM, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> Isn't this one of those things that *have* to be #ifdef CONFIG_OF?
>>
>> Next iteration, remember to add Mark Brown on To: because je's taking
>> care of SPI patches for the moment.
>
> Ahh!! Forgot to reply :(
>
> Dropping this patch as it is already fixed in Roland's patches

No problem, I was probably wrong anyway. It appears that
part of the device struct is no longer ifdef:ed, so it will compile
nicely.

Yours,
Linus Walleij

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
