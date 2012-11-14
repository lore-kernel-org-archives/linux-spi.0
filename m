From: Jonas Gorski <jonas.gorski-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi/bcm63xx: fix multi transfer messages
Date: Thu, 15 Nov 2012 00:33:31 +0100
Message-ID: <CAOiHx==CdCrb5++dsy5GBYpwXLmx3iG2bmpYiqiOuop_JAn9NQ@mail.gmail.com>
References: <1352931747-19893-1-git-send-email-jonas.gorski@gmail.com>
	<20121114231650.GC4536@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org,
	Kevin Cernekee <cernekee-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	Florian Fainelli <florian-p3rKhJxN3npAfugRpC6u6w@public.gmane.org>, Maxime Bizon <mbizon-MmRyKUhfbQ9GWvitb5QawA@public.gmane.org>
To: Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20121114231650.GC4536-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On 15 November 2012 00:17, Mark Brown
<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org> wrote:
> On Wed, Nov 14, 2012 at 11:22:26PM +0100, Jonas Gorski wrote:
>> The BCM63XX SPI controller does not support keeping CS asserted after
>> sending its buffer. This breaks common usages like spi_write_then_read,
>> where it is expected to be kept active during the whole transfers.
>
>> Work around this by combining the transfers into one if the buffer
>> allows. For spi_write_then_read, use the prepend byte feature to write
>> to "prepend" the write if it is less than 15 bytes, allowing the whole
>> fifo size for the read.
>
> This is only going to work around a relatively small subset of cases so
> it doesn't seem worth rushing in.  The normal fix for such issues is to
> control /CS as a GPIO.

Well, one of the "small" subsets is SPI attached flash, those need
write then read or write then write with CS asserted for most
operations, too. And I'm not sure if controlling CS as a GPIO is an
option on bcm63xx, at least not for the CS's commonly used (the others
have GPIO overlays on some chips).
OTOH booting from SPI flash isn't properly supported yet anyway in
vanilla linux for bcm63xx.


Jonas

------------------------------------------------------------------------------
Monitor your physical, virtual and cloud infrastructure from a single
web console. Get in-depth insight into apps, servers, databases, vmware,
SAP, cloud infrastructure, etc. Download 30-day Free Trial.
Pricing starts from $795 for 25 servers or applications!
http://p.sf.net/sfu/zoho_dev2dev_nov
