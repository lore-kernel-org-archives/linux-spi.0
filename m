From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi: Trivial warning fix
Date: Fri, 09 Mar 2012 10:57:48 -0700
Message-ID: <20120309175748.49BD13E0880@localhost>
References: <1330351145-3564-1-git-send-email-shubhrajyoti@ti.com>
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org,
	Shubhrajyoti D <shubhrajyoti@ti.com>
To: Shubhrajyoti D <shubhrajyoti@ti.com>,
	spi-devel-general@lists.sourceforge.net
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1330351145-3564-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Mon, 27 Feb 2012 19:29:05 +0530, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> The loop count i traverses for ntrans which is unsigned
> so make the loop count i also unsigned.
> 
> Fix the below warning
> In file included from drivers/spi/spi-omap2-mcspi.c:38:
> include/linux/spi/spi.h: In function 'spi_message_alloc':
> include/linux/spi/spi.h:556: warning: comparison between signed and unsigned integer expressions
> 
> Cc: Vitaly Wool <vwool@ru.mvista.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---

Applied, thanks.

g.

> Untested !
> 
>  include/linux/spi/spi.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/include/linux/spi/spi.h b/include/linux/spi/spi.h
> index 176fce9..6ae4993 100644
> --- a/include/linux/spi/spi.h
> +++ b/include/linux/spi/spi.h
> @@ -549,7 +549,7 @@ static inline struct spi_message *spi_message_alloc(unsigned ntrans, gfp_t flags
>  			+ ntrans * sizeof(struct spi_transfer),
>  			flags);
>  	if (m) {
> -		int i;
> +		unsigned i;
>  		struct spi_transfer *t = (struct spi_transfer *)(m + 1);
>  
>  		INIT_LIST_HEAD(&m->transfers);
> -- 
> 1.7.0.4
> 
> 
> ------------------------------------------------------------------------------
> Try before you buy = See our experts in action!
> The most comprehensive online learning library for Microsoft developers
> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
> Metro Style Apps, more. Free future releases when you subscribe now!
> http://p.sf.net/sfu/learndevnow-dev2
> _______________________________________________
> spi-devel-general mailing list
> spi-devel-general@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/spi-devel-general

-- 
Grant Likely, B.Sc, P.Eng.
Secret Lab Technologies,Ltd.
