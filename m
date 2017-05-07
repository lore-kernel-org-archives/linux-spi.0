From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: [PATCH/RFC] signal: Export signal_wake_up_state() to modules
Date: Sun, 7 May 2017 11:47:59 +0200
Message-ID: <CAMuHMdXdqH23H7XoCaHP9myM6oZ4SN0EXp-inwwmsZi=VK636A@mail.gmail.com>
References: <1493977751-19340-1-git-send-email-geert+renesas@glider.be> <20170506194256.GA21726@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>,
        Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>,
        "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
        linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20170506194256.GA21726-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Oleg,

On Sat, May 6, 2017 at 9:42 PM, Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> On 05/05, Geert Uytterhoeven wrote:
>> I'm using signal_wake_up() to abort a task blocked on
>> wait_for_completion_interruptible(), cfr. sh_msiof_slave_abort() in
>> "spi: sh-msiof: Add slave mode support"
>> (http://www.spinics.net/lists/devicetree/msg175575.html).
>>
>> Is exporting signal_wake_up_state() an acceptable solution?
>> Alternatively, I can extract the code to abort an completion into a
>> generic abort_completion() function, and export that.
>
> I too do not think this is a good idea... signal_wake_up() or even
> set_tsk_thread_flag() should never be used unless you actually send a
> signal. Yes, freeze_task() does this too but note that recalc_sigpending()
> checks freezing() and in this case we really want the target to enter the
> get_signal() path.
>
> And in fact I do not really understand why do you need it, it seems that
> you can easily rework this code and avoid this hack.

You mean having my own aborted flag, and calling complete_all()?

> Not to mention that sh_msiof_slave_abort() plays with struct completion
> internals, this doesn't look good too.

One reason to turn it into a generic abort_completion() function...

> Finally, clear_thread_flag(TIF_SIGPENDING) in sh_msiof_wait_for_completion()
> looks wrong. Or it is only for kthreads?

If I don't clear that flag, the next (by the same thread[*])
wait_for_completion_interruptible() will abort immediately.

[*] Typically this is the spi message pump worker.

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
