From: Brian Norris <computersforpeace-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 00/23] mtd: st_spi_fsm: Add new device
Date: Tue, 26 Nov 2013 20:07:23 -0800
Message-ID: <20131127040723.GZ9468@ld-irv-0074.broadcom.com>
References: <1385137380-28968-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
	dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-mtd-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org,
	angus.clark-qxv4g6HH51o@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org,
	Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
	Huang Shijie <b32955-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1385137380-28968-1-git-send-email-lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

+ Huang, Mark, SPI list

There seem to be multiple efforts going on that are vaguely related. I'd
like to see more of the same people appearing on the CC list, to keep
better coordinated.

On that topic, is the SPI dev list relevant, or would anybody working on
the intersection of SPI and MTD be on the MTD list?

On Fri, Nov 22, 2013 at 04:22:37PM +0000, Lee Jones wrote:
> The first bunch of these patches have been on the MLs before, but 
> didn't receive a great deal of attention for the most part. We are
> a little more featureful this time however. We can now successfully
> setup and configure the N25Q256. We still can't read/write/erase
> it though. I'll start work on that next week and will provide it in
> the next instalment.

What happened to integrating a SPI NOR framework? I see you copied some
of the m25p80 commands, but you don't share them with m25p80. I also
understand your argument (from the first version of this patch series)
that much of the actual controller operation is not shared with m25p80,
but you'd be surprised how this might evolve. There are several others
with QSPI hardware that are trying to get patches merged, some of whom
(Huang, at least) are actively submitting patches to help with this
abstraction.

Now, I haven't had a lot of time yet to look at both yours and Huang's
work and see what, if anything, can be shared (will do soon). But I
think you need to be aware.

BTW, can you include version markers (i.e., [PATCH v2 X/Y]) in the
subject from now on?

Brian
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
