From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH] spi: Fix hung task timeout when initialization fails
Date: Thu, 1 May 2014 16:33:58 +0200
Message-ID: <CAMuHMdUeFJDq8TMQn=D+y_nWVy-puZDYekV3cPhHTnDF+ebKJA@mail.gmail.com>
References: <1398854171-5187-1-git-send-email-ricardo.ribalda@gmail.com>
	<20140501013402.GL3245@sirena.org.uk>
	<CAPybu_3g=VBW+gGhveBJoc7=tCiPurP_r_+hqOU78bvsg8QJWw@mail.gmail.com>
	<20140501141156.GV3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>,
	linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140501141156.GV3245-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On Thu, May 1, 2014 at 4:11 PM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Thu, May 01, 2014 at 07:53:58AM +0200, Ricardo Ribalda Delgado wrote:
>
>> Thanks for your comments. This fix does not avoid the task being
>> killed (which is not an error). What it does is that IF the task is
>> killed or we are out of memory we will exit with all the resources
>> properly released and no locks helds, giving the user a chance to
>> reload/rebind the module instead of getting and unstable system that
>> cannot even reboot without a powercycle.
>
> How does it ensure that?  What's to stop the task being killed after we
> check to see if the task was killed.

master->kworker_task is set like this:

    master->kworker_task = kthread_run(...)

so it just contains the status of the creation of the kthread, not if it was
killed, right? Hence we don't check if it was killed.

So Ricardo's patch prevents the stopping and destruction of the thread
if it failed to be _created_.

What if it is killed? I suppose the kthread API handles that internally, as it
could happen to any thread (e.g. OOM)?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
