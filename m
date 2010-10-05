From: Jassi Brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Change MODE, CS, BUS, and SPEED using SPI-DEV driver?
Date: Tue, 5 Oct 2010 09:54:56 +0900
Message-ID: <AANLkTi=uszrgBRbh1a4WEYMZ5b9E9Sr8vXTkvf5UD1sz@mail.gmail.com>
References: <20101004210503.147160@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Charles Martel <SingerIsland-KK0ffGbhmjU@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20101004210503.147160-KK0ffGbhmjU@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Tue, Oct 5, 2010 at 6:02 AM, Charles Martel <SingerIsland-KK0ffGbhmjU@public.gmane.org> wrote:


> I had built a kernel for the s3c6410 using linux-2.6.24.
Could you plz upgrade to latest kernel ?
2.6.24 was released before I was born, so can't say much about it.

> I noticed that there are drivers for the s3c24xx but only the
> "S3C6410 High Speed SPI Driver" is specific to the s3c6410.
> I do not believe that the the s3c24xx series drivers are
> compatible with the s3c6410. Am I wrong?
No.

> The problem I am having would go away if I could use the
> s3c24xx drivers since they result in the spidev.c file being
> built.
SPIDEV is a test protocol driver. You should be able to select that
while config

Summary:- Upgrade to latest possible kernel or backport S3C64xx driver
from the latest kernel.

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
