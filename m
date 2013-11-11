From: Julia Lawall <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Subject: devm_spi_register_master
Date: Mon, 11 Nov 2013 09:44:56 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1311110935230.2300@hadrien>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello,

I was looking into the use of devm_spi_register_master.  This function
seems to take care of registering and unregistering, but not allocation
and freeing.  I have the impression that that is done with
spi_alloc_master and and spi_master_put, which are not managed functions.
But then I wonder how this can work?  It seems that the spi_master_put
function should remain in the probe or remove function, and then the
object could be freed before it is unregistered?

The patch 2fe7e4add3e53df7c1b97e32076f8390dd81c6b3 introduces a call to
devm_spi_register_master and also removes a call to spi_master_put.  By my
reasoning, this would cause a memory leak.

Am I missing something?

thanks,
julia
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
