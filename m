From: Jingoo Han <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: devm_spi_register_master
Date: Fri, 15 Nov 2013 17:24:16 +0900
Message-ID: <000e01cee1dc$12a4fba0$37eef2e0$%han@samsung.com>
References: <alpine.DEB.2.02.1311110935230.2300@hadrien>
 <002701cedf3b$19f5b280$4de11780$%han@samsung.com>
 <alpine.DEB.2.02.1311111915570.2321@hadrien>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: 'Mark Brown' <broonie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	'Jingoo Han' <jg1.han-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>,
	'Wei Yongjun' <weiyj.lk-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: 'Julia Lawall' <julia.lawall-L2FTfq7BK8M@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-reply-to: <alpine.DEB.2.02.1311111915570.2321@hadrien>
Content-language: ko
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>



> -----Original Message-----
> From: Julia Lawall [mailto:julia.lawall-L2FTfq7BK8M@public.gmane.org]
> Sent: Tuesday, November 12, 2013 12:19 PM
> To: Jingoo Han
> Cc: 'Mark Brown'; linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: devm_spi_register_master
> 
> On Tue, 12 Nov 2013, Jingoo Han wrote:
> 
> > On Tuesday, November 12, 2013 2:45 AM, Julia Lawall wrote:
> > >
> > > Hello,
> > >
> > > I was looking into the use of devm_spi_register_master.  This function
> > > seems to take care of registering and unregistering, but not allocation
> > > and freeing.  I have the impression that that is done with
> > > spi_alloc_master and and spi_master_put, which are not managed functions.
> > > But then I wonder how this can work?  It seems that the spi_master_put
> > > function should remain in the probe or remove function, and then the
> > > object could be freed before it is unregistered?
> > >
> > > The patch 2fe7e4add3e53df7c1b97e32076f8390dd81c6b3 introduces a call to
> > > devm_spi_register_master and also removes a call to spi_master_put.  By my
> > > reasoning, this would cause a memory leak.
> >
> > Hi Julia Lawall,
> >
> > I already checked that the patch 2fe7e4a "spi: txx9: use
> > devm_spi_register_master()" is right. The call to spi_master_put()
> > was duplicated. So, it should be removed.
> >
> > When removing the driver, the following functions are called.
> > : devm_spi_unregister()
> >        -> spi_unregister_master()
> >            -> device_unregister()
> >                -> put_device()
> >
> > Also, spi_master_put() calls the following functions.
> > : spi_master_put()
> >        -> put_device()
> >
> > So, put_device() is duplicated, when devm_spi_register_master()
> > is used. In this case, spi_master_put() can be removed.
> 
> spi_register_master calls device_add, which seems to increment the
> reference count.  So it may be that both calls to put_device are needed.
> On the other hand, in that case it would be safe to invert their order.
> 

Then, how about the following patch submitted by Wei Yongjun?
http://www.spinics.net/lists/arm-kernel/msg286576.html

Best regards,
Jingoo Han

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
