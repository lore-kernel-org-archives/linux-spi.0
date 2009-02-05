From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 3/5] Blackfin SPI Driver: fix NULL
	pointer crash
Date: Thu, 5 Feb 2009 17:29:18 -0500
Message-ID: <8bd0f97a0902051429q2b76c7b7nf4187178b73f979@mail.gmail.com>
References: <1233828453-13311-1-git-send-email-cooloney@kernel.org>
	<1233828453-13311-4-git-send-email-cooloney@kernel.org>
	<20090205141250.cf66e663.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, dbrownell-Rn4VEauK+AKRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20090205141250.cf66e663.akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, Feb 5, 2009 at 17:12, Andrew Morton wrote:
> On Thu,  5 Feb 2009 18:07:31 +0800 Bryan Wu wrote:
>> From: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> fix NULL pointer crash when cleaning up from invalid platform resources
>>
>> Signed-off-by: Mike Frysinger <vapier.adi-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>> Signed-off-by: Bryan Wu <cooloney-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> ---
>>  drivers/spi/spi_bfin5xx.c |    3 +++
>>  1 files changed, 3 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/spi/spi_bfin5xx.c b/drivers/spi/spi_bfin5xx.c
>> index ce24d5e..b6098b5 100644
>> --- a/drivers/spi/spi_bfin5xx.c
>> +++ b/drivers/spi/spi_bfin5xx.c
>> @@ -1240,6 +1240,9 @@ static void bfin_spi_cleanup(struct spi_device *spi)
>>  {
>>       struct chip_data *chip = spi_get_ctldata(spi);
>>
>> +     if (!chip)
>> +             return;
>> +
>>       if ((chip->chip_select_num > 0)
>>               && (chip->chip_select_num <= spi->master->num_chipselect))
>>               peripheral_free(ssel[spi->master->bus_num]
>
> This one looks like 2.6.29 material to me.
>
> If you believe that it should be backported to earlier kernels then
> please let me know.  indicating whcih kernel versions would help things
> a bit, too.

including with 2.6.29 would be a good thing ... we havent quite synced
up our development process enough yet to do that kind of tracking, so
all of our stuff just goes into "the next thing" ...
-mike

------------------------------------------------------------------------------
Create and Deploy Rich Internet Apps outside the browser with Adobe(R)AIR(TM)
software. With Adobe AIR, Ajax developers can use existing skills and code to
build responsive, highly engaging applications that combine the power of local
resources and data with the reach of the web. Download the Adobe AIR SDK and
Ajax docs to start building applications today-http://p.sf.net/sfu/adobe-com
