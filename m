From: Stefan Roese <stefan.roese-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: spi-mpc52xx.c: Init bus_num to 0 as this driver
	only supports one bus
Date: Thu, 06 Dec 2012 15:50:09 +0100
Message-ID: <50C0B0A1.4020908@gmail.com>
References: <1353924587-31339-1-git-send-email-sr@denx.de>
	<20121206143720.3345F3E0948@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Anatolij Gustschin <agust-ynQEQJNshbs@public.gmane.org>
To: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121206143720.3345F3E0948@localhost>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 12/06/2012 03:37 PM, Grant Likely wrote:
> On Mon, 26 Nov 2012 11:09:47 +0100, Stefan Roese <sr-ynQEQJNshbs@public.gmane.org> wrote:
>> By setting bus_num to 0 the resulting device is named "spi0". Otherwise
>> the name was "spi32766" (dynamic numbering) which was a bit confusing.
>>
>> Using 0 is correct as this driver (and the MPC5200 SPI controller) only
>> supports one SPI bus.
> 
> But the chip has multiple SPI busses. If the psc spi bus gets probed
> first, then there will be a number conflict.

Yes, correct. Lets drop this patch for now then.

Thanks,
Stefan


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
