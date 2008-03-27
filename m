From: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: spi_bitbang cs_change hinting fix
Date: Thu, 27 Mar 2008 09:30:28 +0100
Message-ID: <47EB5B24.1060609@gmail.com>
References: <47D6597F.4040503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <47D6597F.4040503-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
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

Hi David,

Jan Nikitenko wrote:
> Fix condition for deactivating chipselect after processing of
> spi_message - if cs_change==0, chipselect should not be touched and left
> active for next spi_message to follow.
> 
> Signed-off-by: Jan Nikitenko <jan.nikitenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> ---
> 
> I am not sure about the meaning of spi message transfer cs_change attribute.
> 
> I assume that non-zero cs_change indicate that chipselect should be
> toggled between spi_transfers.
> 
> What about cs_change in last spi_transfer of spi_message?
> Should zero cs_change provide hinting that chipselect should be left
> active, because spi_message to follow will be for the same spi device?
> 
> If that is so, the handling in spi_bitbang.c would be incorrect, because
> chipselect would be deactivated when cs_change==0.
> 
> Or is the meaning of cs_change in the last spi_transfer of spi_message
> different than in previous spi_transfers in single spi_message?
> Like cs_change==0 in last spi_transfer would indicate to deactivate
> chipselect and cs_change!=0 in last spi_transfer would provide hinting
> that next spi_message will be for the same spi device and chipselect
> should be left active?
> If that is so, it's quite confusing (and not documented), as the meaning
> of cs_change in the last spi_transfer would be opposite than in other
> spi_transfers in single spi_message.
> 
> The patch here fixes the condition for the case that cs_change meaning
> is the first variant described.
> 
>  spi_bitbang.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/spi/spi_bitbang.c b/drivers/spi/spi_bitbang.c
> index f7f8580..7ff31a3 100644
> --- a/drivers/spi/spi_bitbang.c
> +++ b/drivers/spi/spi_bitbang.c
> @@ -380,7 +380,7 @@ static void bitbang_work(struct work_struct *work)
>  		 * cs_change has hinted that the next message will probably
>  		 * be for this chip too.
>  		 */
> -		if (!(status == 0 && cs_change)) {
> +		if (!(status == 0 && !cs_change)) {
>  			ndelay(nsecs);
>  			bitbang->chipselect(spi, BITBANG_CS_INACTIVE);
>  			ndelay(nsecs);


Could you, please, comment this issue and clarify the meaning of
cs_change in the last spi_transfer of spi_message?

It seems that I am not the only one confused about that:
http://lkml.org/lkml/2006/2/28/2
SPI: cs_change usage

Thanks and best regards,
Jan

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
