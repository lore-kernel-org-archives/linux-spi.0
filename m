From: Andy Shevchenko <andriy.shevchenko-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re:
Date: Wed, 12 Feb 2020 12:24:44 +0200
Message-ID: <20200212102444.GR10400@smile.fi.intel.com>
References: <20200211223400.107604-1-rajatja@google.com>
 <b3397374-0cb8-cf6c-0555-34541a1c108c@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Rajat Jain <rajatja-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
        Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
        Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>,
        Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Evan Green <evgreen-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>,
        rajatxjain-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, evgreen-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org,
        shobhit.srivastava-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, porselvan.muthukrishnan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
To: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <b3397374-0cb8-cf6c-0555-34541a1c108c-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Wed, Feb 12, 2020 at 11:30:51AM +0200, Jarkko Nikula wrote:
> On 2/12/20 12:34 AM, Rajat Jain wrote:

> This patch subject is missing from mail subject.

> I'm thinking can this be done only once after resume and may other LPSS
> blocks need the same? I.e. should this be done in drivers/mfd/intel-lpss.c?

On resume we restore the previously saved context, can we be sure that values
we saved during suspend are correct?

If above won't show any issue, it might be best place to have this quirk
applied in intel_lpss_suspend() / intel_lpss_resume() callbacks as Jarkko
suggested.

-- 
With Best Regards,
Andy Shevchenko
