From: Girish KS <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 1/3] spi: s3c64xx: added support for polling mode
Date: Wed, 24 Apr 2013 15:07:47 +0530
Message-ID: <CAKrE-KcGecFNnyKj9AdDYwBOw_OO4o_V2DMjHmYX092fh4EQgw@mail.gmail.com>
References: <1366614565-3743-1-git-send-email-ks.giri@samsung.com>
	<1366614565-3743-2-git-send-email-ks.giri@samsung.com>
	<20130423151511.GR5019@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org,
	linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20130423151511.GR5019-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Apr 23, 2013 at 8:45 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Mon, Apr 22, 2013 at 12:39:23PM +0530, Girish K S wrote:
>> From: Girish K S <girishks2000-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
>>
>> The 64xx spi driver supports partial polling mode.
>> Only the last chunk of the transfer length is transferred
>> or recieved in polling mode.
>
> This appears to have a very noticable negative impact on SPI performance
> on my S3C6410 based system.  Not delved into it to test why but are you
> sure it's not mistakenly selecting polling?

If forced to polling you should see this message "Unable to get SPI rx
dma resource. Switching to poll mode". same if Tx dma resource is not
available from platform data.
Anyways let me cross check again on my tested systems.

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_apr
