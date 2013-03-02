From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: Driver for GPIO controlled SPI multiplexer
Date: Sat, 2 Mar 2013 14:31:12 +0000
Message-ID: <CACxGe6tpjFygsmMtpN6dUA5o78t=x0Qp3o2OOmXouAD=NgpFgQ@mail.gmail.com>
References: <1361973519-30633-1-git-send-email-peter.korsgaard@barco.com>
	<20130302035043.GE6610@opensource.wolfsonmicro.com>
	<87wqtq3wup.fsf@thor.barco.com>
	<20130302104853.GA31872@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, "Van Puymbroeck,
	Dries" <Dries.VanPuymbroeck-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>,
	Peter Korsgaard <peter.korsgaard-ob4gmnvZ1/cAvxtiuMwx3w@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130302104853.GA31872-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Sat, Mar 2, 2013 at 10:48 AM, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Sat, Mar 02, 2013 at 11:43:58AM +0100, Peter Korsgaard wrote:
>
>> MB> This looks wrong without a vendor name in it but I'm not sure what we're
>> MB> supposed to do for generic stuff like this.
>
>> It's atleast in line with what we do elsewhere (spi-gpio, i2c-gpio,
>> i2c-mux-gpio, ..)
>
> Yup, it just feels wrong.  Not a problem though.  Will you respin for
> the max speed thing?

It's not quite the same though. spi-gpio and i2c-gpio are very well
defined things. An SPI multiplexer on the other hand can be
implemented in several different ways. I would still be more specific
here. You can be specific to your specific hardware now, and a more
generic value can be added later.

g.



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
