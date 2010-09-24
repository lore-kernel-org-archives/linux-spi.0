From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] spi_mpc8xxx: issue with using definition of pram in
 Device Tree
Date: Fri, 24 Sep 2010 01:10:06 -0600
Message-ID: <20100924071006.GA21318@angua.secretlab.ca>
References: <20100916070503.10046C7391@messagerie.si.c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	spi-devel-general@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Kumar Gala <galak@kernel.crashing.org>,
	Anton Vorontsov <avorontsov@ru.mvista.com>
To: christophe leroy <christophe.leroy@c-s.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100916070503.10046C7391@messagerie.si.c-s.fr>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: linux-spi.vger.kernel.org

On Thu, Sep 16, 2010 at 09:05:03AM +0200, christophe leroy wrote:
> This patch applies to 2.6.34.7 and 2.6.35.4
> It fixes an issue during the probe for CPM1 with definition of parameter ram from DTS
> 
> Signed-off-by: christophe leroy <christophe.leroy@c-s.fr>

I'm sorry, I don't understand the fix from the given description.
What is the problem, and why is cpm_muram_alloc_fixed() the wrong
thing to call on CPM1?  Does CPM2 still need it?

g.

> 
> diff -urN b/drivers/spi/spi_mpc8xxx.c c/drivers/spi/spi_mpc8xxx.c
> --- b/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:43:50.000000000 +0200
> +++ c/drivers/spi/spi_mpc8xxx.c	2010-09-08 16:44:03.000000000 +0200
> @@ -822,7 +822,7 @@
>  	if (!iprop || size != sizeof(*iprop) * 4)
>  		return -ENOMEM;
>  
> -	spi_base_ofs = cpm_muram_alloc_fixed(iprop[2], 2);
> +	spi_base_ofs = iprop[2];
>  	if (IS_ERR_VALUE(spi_base_ofs))
>  		return -ENOMEM;
>  
> @@ -844,7 +844,6 @@
>  			return spi_base_ofs;
>  	}
>  
> -	cpm_muram_free(spi_base_ofs);
>  	return pram_ofs;
>  }
