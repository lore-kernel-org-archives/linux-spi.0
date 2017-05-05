From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH/RFC] signal: Export signal_wake_up_state() to modules
Date: Fri,  5 May 2017 11:49:11 +0200
Message-ID: <1493977751-19340-1-git-send-email-geert+renesas@glider.be>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org,
        Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
To: Ingo Molnar <mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>,
        Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>,
        Oleg Nesterov <oleg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>,
        Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

When using signal_wake_up() from a loadable kernel module:

    ERROR: "signal_wake_up_state" [drivers/spi/spi-sh-msiof.ko] undefined!

Export signal_wake_up_state() to modules to fix this.

Reported-by: kbuild test robot <fengguang.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
---
I'm using signal_wake_up() to abort a task blocked on
wait_for_completion_interruptible(), cfr. sh_msiof_slave_abort() in
"spi: sh-msiof: Add slave mode support"
(http://www.spinics.net/lists/devicetree/msg175575.html).

Is exporting signal_wake_up_state() an acceptable solution?
Alternatively, I can extract the code to abort an completion into a
generic abort_completion() function, and export that.

Or is there a better way to abort a completion?

Thanks!
---
 kernel/signal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/signal.c b/kernel/signal.c
index 7e59ebc2c25e669e..f130598acd34f08b 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -660,6 +660,7 @@ void signal_wake_up_state(struct task_struct *t, unsigned int state)
 	if (!wake_up_state(t, state | TASK_INTERRUPTIBLE))
 		kick_process(t);
 }
+EXPORT_SYMBOL_GPL(signal_wake_up_state);
 
 /*
  * Remove signals in mask from the pending set and queue.
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
