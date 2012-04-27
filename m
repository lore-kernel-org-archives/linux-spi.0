From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] spi: pl022: Allow request for higher frequency than
	maximum possible
Date: Fri, 27 Apr 2012 12:08:02 -0600
Message-ID: <20120427180802.DC1C83E171B@localhost>
References: <fef35098d2e7f03888b21356bd2a5f73936ab6d1.1334814714.git.viresh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>,
	spear-devel-nkJGhpqTU55BDgjK7y7TUQ@public.gmane.org
To: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <fef35098d2e7f03888b21356bd2a5f73936ab6d1.1334814714.git.viresh.kumar-qxv4g6HH51o@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

On Thu, 19 Apr 2012 11:48:15 +0530, Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org> wrote:
> Currently, if we request for frequency greater than maximum possible, spi driver
> returns error.
> 
> For example, if the spi block src frequency is 333/4 MHz, i.e. 83.33.. MHz,
> maximum frequency programmable would be src/2. Which would come around 41.6...
> 
> It is difficult to pass frequency in these figures. We normally try to program
> in round figures, like 42 MHz and it should get programmed to <=
> requested_frequency, i.e. 41.6...
> 
> For this to happen, we must not return error even if requested freq is higher
> than max possible. But should program it to max possible.
> 
> Reported-by: Vinit Kamalaksha Shenoy <vinit.shenoy-qxv4g6HH51o@public.gmane.org>
> Signed-off-by: Viresh Kumar <viresh.kumar-qxv4g6HH51o@public.gmane.org>

Applied, thanks.

g.

> ---
>  drivers/spi/spi-pl022.c |   10 ++++++++--
>  1 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-pl022.c b/drivers/spi/spi-pl022.c
> index 09c925a..99d5f6d 100644
> --- a/drivers/spi/spi-pl022.c
> +++ b/drivers/spi/spi-pl022.c
> @@ -1667,9 +1667,15 @@ static int calculate_effective_freq(struct pl022 *pl022, int freq, struct
>  	/* cpsdvsr = 254 & scr = 255 */
>  	min_tclk = spi_rate(rate, CPSDVR_MAX, SCR_MAX);
>  
> -	if (!((freq <= max_tclk) && (freq >= min_tclk))) {
> +	if (freq > max_tclk)
> +		dev_warn(&pl022->adev->dev,
> +			"Max speed that can be programmed is %d Hz, you requested %d\n",
> +			max_tclk, freq);
> +
> +	if (freq < min_tclk) {
>  		dev_err(&pl022->adev->dev,
> -			"controller data is incorrect: out of range frequency");
> +			"Requested frequency: %d Hz is less than minimum possible %d Hz\n",
> +			freq, min_tclk);
>  		return -EINVAL;
>  	}
>  
> -- 
> 1.7.9
> 

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies, Ltd.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
