From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v3 1/2] ARM: shmobile: r8a7778: Use clks as MSTP007 parent
Date: Mon, 14 Apr 2014 11:27:26 +0200
Message-ID: <5028748.H4m9LDvjIB@avalon>
References: <1397439698-30123-1-git-send-email-horms+renesas@verge.net.au> <1397439698-30123-2-git-send-email-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
	linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
To: Simon Horman <horms+renesas@verge.net.au>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <1397439698-30123-2-git-send-email-horms+renesas@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

Hi Simon,

Thank you for the patch.

On Monday 14 April 2014 10:41:36 Simon Horman wrote:
> According to the documentation the parent clock of
> MSTP007 should be clks not clkp.
> 
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v3
> * Correct changelog to refer to r8a7778 instead of r8a7779
> 
> v2
> * First post, as suggested by Laurent Pinchart
> ---
>  arch/arm/mach-shmobile/clock-r8a7778.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c
> b/arch/arm/mach-shmobile/clock-r8a7778.c index 2009a9b..9989b1b 100644
> --- a/arch/arm/mach-shmobile/clock-r8a7778.c
> +++ b/arch/arm/mach-shmobile/clock-r8a7778.c
> @@ -170,7 +170,7 @@ static struct clk mstp_clks[MSTP_NR] = {
>  	[MSTP010] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 10, 0), /* SSI2 */
>  	[MSTP009] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  9, 0), /* SSI3 */
>  	[MSTP008] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  8, 0), /* SRU */
> -	[MSTP007] = SH_CLK_MSTP32(&p_clk, MSTPCR0,  7, 0), /* HSPI */
> +	[MSTP007] = SH_CLK_MSTP32(&s_clk, MSTPCR0,  7, 0), /* HSPI */
>  };
> 
>  static struct clk_lookup lookups[] = {

-- 
Regards,

Laurent Pinchart

