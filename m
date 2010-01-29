From: jassi brar <jassisinghbrar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: McSPI questions pertaining to GPIO chip
	select support
Date: Fri, 29 Jan 2010 10:09:47 +0900
Message-ID: <1b68c6791001281709l7d11da30lee486632e85b99cb@mail.gmail.com>
References: <1264016711-sup-309@ben-laptop> <1264651770-sup-5197@ben-laptop>
	<1b68c6791001272033q60dd31dbif4de285cd9bac83d@mail.gmail.com>
	<1264724720-sup-7366@ben-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
To: Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1264724720-sup-7366@ben-laptop>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Fri, Jan 29, 2010 at 9:32 AM, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> Excerpts from jassi brar's message of Wed Jan 27 23:33:20 -0500 2010:
>> On Thu, Jan 28, 2010 at 1:10 PM, Ben Gamari <bgamari.foss-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>> > Hey all!
>> >
>> > Recently I've been thinking about adding support to the McSPI driver for
>> > using GPIO pins as chip selects. As a starting point, I've browsed the
>> > driver source trying to identify what changes would be necessary to add
>> > this support. It seems like the rough idea is,
>> You may loot at drivers/spi/spi_s3c64xx.c in Grant Likely's tree.
>>
> Grant,
>
> I think that you might be missing a file in your spi-next branch. I've
> been unable to find <plat/s3c64xx-spi.h> as referenced in
> drivers/spi/spi_s3c64xx.c. I don't have an ARM toolchain to try
> compiling the tree at the moment, but both ctags and find have been
> unable to find this header. Sorry if I'm just being dense.
the arch/mach specific stuff will come via the SoC maintainer's(Ben
Dooks) tree as I already mentioned.

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
