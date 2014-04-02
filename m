From: Gerhard Sittig <gsi-ynQEQJNshbs@public.gmane.org>
Subject: Re: [PATCH] spi: Always check complete callback before calling it
Date: Wed, 2 Apr 2014 21:04:51 +0200
Message-ID: <20140402190451.GE11339@book.gsilab.sittig.org>
References: <1396448464.8891.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Hou Zhiqiang <b48286-KZfg59tc24xl57MIdRCFDg@public.gmane.org>,
	Sebastian Andrzej Siewior <bigeasy-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
	Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>,
	Atsushi Nemoto <anemo-7JcRY8pycbNHfZP73Gtkiw@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1396448464.8891.1.camel@phoenix>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, 2014-04-02 at 22:21 +0800, Axel Lin wrote:
> 
> Since commit 1e25cd4729bd "spi: Do not require a completion", this checking is
> required to prevent NULL pointer dereference.
> 
> Signed-off-by: Axel Lin <axel.lin-8E1dMatC8ynQT0dZR+AlfA@public.gmane.org>
> [ ... ]

> --- a/drivers/spi/spi-mpc512x-psc.c
> +++ b/drivers/spi/spi-mpc512x-psc.c
> @@ -300,7 +300,8 @@ static int mpc512x_psc_spi_msg_xfer(struct spi_master *master,
>  	}
>  
>  	m->status = status;
> -	m->complete(m->context);
> +	if (m->complete)
> +		m->complete(m->context);
>  
>  	if (status || !cs_change)
>  		mpc512x_psc_spi_deactivate_cs(spi);

Haven't run-tested the change, but assuming that the .complete()
member became optional, the change is straight forward for it.
Looks good to me.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office-ynQEQJNshbs@public.gmane.org
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
