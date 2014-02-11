From: "Ivan T. Ivanov" <iivanov-NEYub+7Iv8PQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 2/2] spi: Add Qualcomm QUP SPI controller support
Date: Tue, 11 Feb 2014 17:46:27 +0200
Message-ID: <1392133587.12787.32.camel@iivanov-dev>
References: <1391705868-20091-1-git-send-email-iivanov@mm-sol.com>
	 <1391705868-20091-3-git-send-email-iivanov@mm-sol.com>
	 <20140207073952.GA2610@qualcomm.com>
	 <1391766753.27491.60.camel@iivanov-dev>
	 <20140207173207.GA19974@qualcomm.com>
	 <1392051302.2853.56.camel@iivanov-dev>
	 <20140210174738.GA31596@qualcomm.com> <1392061304.24621.17.camel@violet>
	 <20140210202926.GV1706@sonymobile.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Andy Gross <agross-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	"linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	Alok Chauhan <alokc-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Gilad Avidov <gavidov-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Kiran Gunda <kgunda-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>,
	Sagar Dharia <sdharia-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
To: Courtney Cavin <courtney.cavin-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140210202926.GV1706-/MT0OVThwyLZJqsBc5GL+g@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>


Hi, 

On Mon, 2014-02-10 at 12:29 -0800, Courtney Cavin wrote: 
> On Mon, Feb 10, 2014 at 08:41:44PM +0100, Ivan T. Ivanov wrote:
> > 
> > Hi,
> > 
> > On Mon, 2014-02-10 at 11:47 -0600, Andy Gross wrote:
> > > On Mon, Feb 10, 2014 at 06:55:02PM +0200, Ivan T. Ivanov wrote:
> > > 
> > > [....]
> > > 
> > > > > > > Bail here?
> > > > > > 
> > > > > > I don't know. What will be the consequences if controller continue to
> > > > > > operate on its default rate?
> > > > > > 
> > > > > 
> > > > > It is unclear.  But if you can't set the rate that is configured or if there is
> > > > > a misconfiguration, it's probably better to exit the probe and catch it here.
> > > > 
> > > > 
> > > > My preference is to delay clock speed change till first
> > > > SPI transfer. And use wherever transfer itself mandate.
> > > > 
> > > 
> > > That works.  My only concern is that it might be nice to catch a configuration
> > > problem early rather than wait for the SPI transfer to fail continuously.
> > 
> > If developer is skilled enough to know which version controller is,
> > (s)he will be able to put the right frequency constrain here :-)
> 
> A developer doesn't have to have much skill at all to copy-paste DT
> configurations around and muck with numbers....  I agree with Andy here,
> early validation is a good idea here, at the very least, some sanity
> checks.

Actually, thinking more on this. Supplying SPI controller with, 
let say 50MHz, which is what success of clk_set_rate() means, doesn't
necessarily guaranteer that controller will be able to do transfers
properly, right? Setting frequency at this point didn't bring any
benefit. 

Regards,
Ivan


> 
> -Courtney


--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
