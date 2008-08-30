From: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Subject: Re: pxa2xx_spi with SFRM
Date: Fri, 29 Aug 2008 23:07:05 -0400
Message-ID: <48B8B959.5010508@whoi.edu>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>	<489C1B23.6040804@cam.ac.uk>	<48A0C35D.5010606@gmail.com>	<48A44F77.1020908@whoi.edu>	<48A4ED85.1030803@gmail.com>	<48A5D44D.6040106@whoi.edu>	<20080815223307.02db86aa@vsauder-lx.localdomain>	<48A9C0D0.5050304@whoi.edu>	<48AB6C8F.4040408@whoi.edu>	<20080821180826.491ac70b@vsauder-lx.localdomain>	<48AF82B3.8040709@whoi.edu>
	<20080829151839.7a85e7d6@vsauder-lx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20080829151839.7a85e7d6-W37fpRALFaH6NKmgiXY+hA0JkcsJGQge@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

With the one small change re: 8191, below, this looks good to go.
For what it's worth, you can add below your sign-off:

Reviewed-by: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>

It's time to add an appropriate [Patch] subject line to the patch, as
outlined in the docs, and email it to David Brownell
<david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>, with CC to the list.

Thanks for pushing this; I know it takes time, and you are right that it
needed to be done.

Vernon Sauder wrote:
> Ned,
> 
> Sorry for the slow response. Real world/work intrudes sometimes.
> 
> Here is another version of the patch along with responses to your
> comments.
> 
> Ned Forrester wrote:
> 
>> Vernon Sauder wrote:
>>
>> Also note that the very recent patch that I submitted, tries to address
>> a problem that you encountered with transfer lengths longer than 8192;
>> in that case, I changed the behavior from "fail" to "do it in PIO mode
>> with rate limited warning".  Some day the driver could be rewritten to
>> bust long transfers and do the pieces by DMA, but that is too ambitious
>> for now.  So you could add to the list of states that transfers longer
>> than 8191 will be PIO.  Have you tested that patch to see if it fixes
>> any of your other problems?
>>
> 
> I did not try that patch yet. I added a comment to the doc about this.

If you would try that it would be appreciated.  I was waiting for your
test to see if it fixed at least one of the MMC problems you were having
(rejected long transfers) before I ask David to push the patch upstream.

--------------------------------
> 
> Patch against Linus 2.6 tree after
> 4c246edd2550304df5b766cc841584b2bb058843. It is compile tested only.
> 
> ---
> Subject: [PATCH] pxa2xx_spi: Fix chip_info defaults and documentation.
> 
> Make the chip info structure data optional by providing reasonable
> defaults. Improve corresponding documentation.
> 
> DMA can determine appropriate dma_burst_size and thresholds
> automatically so use DMA even if dma_burst_size is not specified.
> 
> Signed-off-by: Vernon Sauder <VernonInHand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---
>  Documentation/spi/pxa2xx |   31 ++++++++++++++++++++-----------
>  drivers/spi/pxa2xx_spi.c |   43 ++++++++++++++++++++++++++-----------------
>  2 files changed, 46 insertions(+), 28 deletions(-)
> 

[snip]

>  The following logic is used to determine the type of I/O to be used on
>  a per "spi_transfer" basis:
>  
> -if !enable_dma or dma_burst_size == 0 then
> +if !enable_dma then
>  	always use PIO transfers
>  
> +if spi_message.len > 8192 then

Oops.  if > 8191 (or >=8192), a count of 8192 is not possible in the DMA
controller.



-- 
Ned Forrester                                       nforrester-/d+BM93fTQY@public.gmane.org
Oceanographic Systems Lab                                  508-289-2226
Applied Ocean Physics and Engineering Dept.
Woods Hole Oceanographic Institution          Woods Hole, MA 02543, USA
http://www.whoi.edu/sbl/liteSite.do?litesiteid=7212
http://www.whoi.edu/hpb/Site.do?id=1532
http://www.whoi.edu/page.do?pid=10079


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
