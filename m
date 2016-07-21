From: Michael Weiser <michael.weiser-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v6] ARM: sun4i: spi: Allow transfers larger
 than FIFO size
Date: Thu, 21 Jul 2016 19:27:12 +0200
Message-ID: <20160721172712.GA10640@weiser.dinsnail.net>
References: <1439062912-4405-1-git-send-email-oliver@schinagl.nl>
 <20160721112701.GB6610@weiser.dinsnail.net>
 <20160721163153.GO6509@sirena.org.uk>
Reply-To: michael-kvmrdUZdB1uagOi/AmBnLNHuzzzSOjJt@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org,
        Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>,
        linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-sunxi+bncBCZMJSV6TUIBBSE3YS6AKGQE7E4KMOA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20160721163153.GO6509-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
List-Id: linux-spi.vger.kernel.org

Hi Mark,

On Thu, Jul 21, 2016 at 05:31:53PM +0100, Mark Brown wrote:

> > What is keeping the patch from being merged (i.e. into mainline)?
> Someone needs to address whatever review comments there were on the last
> version and submit it.

That's my point: There don't seem to be any.

v6 was resend with fixes to checkpatch niggles on v5:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-August/363073.html

v5 addressed comments by Maxime on v4:
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-April/244305.html
http://lists.infradead.org/pipermail/linux-arm-kernel/2014-March/243995.html

I can't find any comments on v5 or v6.
-- 
Thanks,
Michael
