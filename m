From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: Re: devm_spi_register_master
Date: Sat, 16 Nov 2013 08:05:55 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1311160802560.2762@hadrien>
References: <alpine.DEB.2.02.1311110935230.2300@hadrien> <002701cedf3b$19f5b280$4de11780$%han@samsung.com> <alpine.DEB.2.02.1311111915570.2321@hadrien> <000e01cee1dc$12a4fba0$37eef2e0$%han@samsung.com>
 <CAPgLHd9hFNuke_cfs9QrQ0E0E_QmRfN3=fESUtBH6PPGgx=Wbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wei Yongjun <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPgLHd9hFNuke_cfs9QrQ0E0E_QmRfN3=fESUtBH6PPGgx=Wbw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

> > Then, how about the following patch submitted by Wei Yongjun?
> > http://www.spinics.net/lists/arm-kernel/msg286576.html
>
> spi_master_get() should be moved.

OK, I see now that that is the issue.

> probe:
> 	spi_alloc_master        	-> Init reference count to 1	=> 1
> 	devm_spi_register_master	-> Not increment reference count => 1
>         (It seems device_add() does not hold a reference)

Indeed.  It acquires a reference, but it releases it at the end.

> remove:
> 	spi_master_get			-> increment reference count => 2
> 	devm_spi_unregister		-> decrement reference count => 1
>
> So after remove, the reference count still 1.
>
> If devm_spi_register_master() hold a reference, we will need
> a extra spi_master_put() in remove to let master be freed.

OK, I think that everything is OK with just getting rid of the get and the
put in the remove function.  Thanks for the explanations.

julia
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
