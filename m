From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: Re: [PATCH] spi: pxa2xx: Add CS control clock quirk
Date: Thu, 13 Feb 2020 19:18:36 +0200
Message-ID: <20200213171836.GD10400@smile.fi.intel.com>
References: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523@BGSMSX101.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
        Rajat Jain <rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
        Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org"
        <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>,
        "linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        "rajatxjain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <rajatxjain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        "evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>,
        "Muthukrishnan, Porselvan" <porselvan.muthukrishnan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
To: "Srivastava, Shobhit" <shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CB4ED07B85D6BB40B8B44F6D5442E4F6572C1523-yHIBzpp8AekElmVAvsQTrbfspsVTdybXVpNB7YpNyf8@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, Feb 13, 2020 at 04:57:24PM +0000, Srivastava, Shobhit wrote:
> > On 2/12/20 12:34 AM, Rajat Jain wrote:

...

> > I wonder is it enough to have this quick toggling only or is time or actually
> > number of clock cycles dependent? Now there is no delay between but I'm
> > thinking if it needs certain number cycles does this still work when using low
> > ssp_clk rates similar than in commit d0283eb2dbc1 ("spi:
> > pxa2xx: Add output control for multiple Intel LPSS chip selects").
> > 
> > I'm thinking can this be done only once after resume and may other LPSS
> > blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

> This behavior is seen after S0ix resume, but it is not seen after S3 resume.

I already commented in the other thread about this.

Have you checked what's going on in intel_lpss_suspend() and
intel_lpss_resume() for your case?

Is intel_lpss_prepare() called during S0ix exit?

> I am thinking that it happens because we are not enabling the SSP after resume. 
> It is deferred until we need to send data. By enabling the SSP in resume, I don’t see the issue.
> For S3, I think BIOS re-enables the SSP in resume flow.

-- 
With Best Regards,
Andy Shevchenko
