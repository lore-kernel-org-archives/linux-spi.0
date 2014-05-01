From: Ricardo Ribalda Delgado <ricardo.ribalda-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] spi: Fix hung task timeout when initialization fails
Date: Thu, 1 May 2014 07:53:58 +0200
Message-ID: <CAPybu_3g=VBW+gGhveBJoc7=tCiPurP_r_+hqOU78bvsg8QJWw@mail.gmail.com>
References: <1398854171-5187-1-git-send-email-ricardo.ribalda@gmail.com> <20140501013402.GL3245@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140501013402.GL3245-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hello Mark

Thanks for your comments. This fix does not avoid the task being
killed (which is not an error). What it does is that IF the task is
killed or we are out of memory we will exit with all the resources
properly released and no locks helds, giving the user a chance to
reload/rebind the module instead of getting and unstable system that
cannot even reboot without a powercycle.

The mention of 786235eeba0e1e85e5cbbb9f97d1087ad03dfa2 is because the condition

if (IS_ERR(master->kworker_task)) {
dev_err(&master->dev, "failed to create message pump task\n");
return -ENOMEM;
}

was very unlikely to happen/difficult to force .

I will reword the message and clean out he backtrace and upload a v2.

Thanks!


On Thu, May 1, 2014 at 3:34 AM, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
> On Wed, Apr 30, 2014 at 12:36:11PM +0200, Ricardo Ribalda Delgado wrote:
>
>> Since "786235eeba0e1e85e5cbbb9f97d1087ad03dfa21 kthread:
>> make kthread_create() killable" kthread_run can be killed by the user,
>> ie, by killing modprobe.
>
>> -     flush_kthread_worker(&master->kworker);
>> -     kthread_stop(master->kworker_task);
>> +     if (!IS_ERR(master->kworker_task)) {
>> +             flush_kthread_worker(&master->kworker);
>> +             kthread_stop(master->kworker_task);
>> +     }
>
> How does this fix avoid racing with the task being killed?  It will
> improve things but it doesn't look like a full fix.
>
> Please don't include entire backtraces in commit messages, they're
> typically extremely long and don't really add anything - edited
> highlights are fine but try to keep it to the point.



-- 
Ricardo Ribalda
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
