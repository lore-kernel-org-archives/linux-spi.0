From: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] ARM: pxa: ssp: Fix build error by removing originally
 incorrect DT binding
Date: Mon, 21 Sep 2015 20:45:03 +0530
Message-ID: <20150921151503.GK2381@localhost>
References: <1441610581-11434-1-git-send-email-jarkko.nikula@linux.intel.com>
 <87zj0rsqhe.fsf@belgarion.home>
 <55FFB643.1080208@linux.intel.com>
 <87fv28qh49.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>,
	Olof Johansson <olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>,
	Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
	linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>,
	Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <87fv28qh49.fsf-4ty26DBLk+jEm7gnYqmdkQ@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Mon, Sep 21, 2015 at 11:03:18AM +0200, Robert Jarzmik wrote:
> Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> 
> > Hi
> >
> > On 09/12/2015 04:43 PM, Robert Jarzmik wrote:
> >> Jarkko Nikula <jarkko.nikula-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> writes:
> >>
> >>> Commit 03fbf488cece ("spi: pxa2xx: Differentiate Intel LPSS types") caused
> >>> build error here because it removed the type LPSS_SSP and I didn't notice
> >>> the type was used here too.
> >> Queued into pxa/fixes, thanks.
> >>
> > Gentle reminder, is this going to 4.3-rc3?
> It is going into v4.3.
> 
> Now knowing if it is v4.3-rc3 is another story, as currently the pxa platform is
> broken because of a dmaengine regression. And if the necessary fix is not
> applied through dmaengine tree (by lack of time from Vinod), I'll want to carry
> it through my tree, which is the reason why I have not made the pull request
> yet.

Which ones are required for fixing, I will priortize those...

-- 
~Vinod
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
