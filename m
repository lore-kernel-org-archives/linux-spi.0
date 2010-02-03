From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: PATCH [1/1] SPI: AMBA_PL022: Limit TX FIFO
	fills based on current RX FIFO used
Date: Wed, 3 Feb 2010 10:48:23 -0700
Message-ID: <fa686aa41002030948g6359ef3o4c3a7b265490b93f@mail.gmail.com>
References: <083DF309106F364B939360100EC290F805C4BF1E97@eu1rdcrdc1wx030.exi.nxp.com>
	<63386a3d1001220456p484efc7fm811ae2240698cbdf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org"
	<spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	Russell King <rmk+kernel-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
To: Linus Walleij <linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <63386a3d1001220456p484efc7fm811ae2240698cbdf-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 22, 2010 at 5:56 AM, Linus Walleij
<linus.ml.walleij-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> 2010/1/20 Kevin Wells <kevin.wells-3arQi8VN3Tc@public.gmane.org>:
>
>> Added logic to cap TX FIFO fill size based on current free RX
>> FIFO entries instead of TX status flags. This is to prevent
>> an issue with RX FIFO overflows
>
> Excellent patch and works like a charm on the U300. My loopback code
> would generate
> spurious overfill errors before and now it *never* fails so you hit
> exactly the right spot.
> I remember being intrigued by this when I worked on the driver and now
> it is finally
> nailed.
>
> As some sort of maintainer of this file I have signed it off and put
> it into Russells
> patch tracker for inclusion, OK? See;
> http://www.arm.linux.org.uk/developer/patches/viewpatch.php?id=5893/1

I'm actively maintaining SPI now.  In general, I'd prefer SPI patches
to go through the SPI tree, unless there are commit ordering issues
with arch code.  I'm tracking SPI patches with patchwork:

http://patchwork.kernel.org/project/spi-devel-general/list/

Thanks,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
