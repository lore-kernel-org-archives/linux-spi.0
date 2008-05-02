From: Sebastian Siewior <bigeasy-kttTfShzVuc@public.gmane.org>
Subject: Re: [RFC / PATCH] [SPI] get_module while using
	it.
Date: Fri, 2 May 2008 12:32:05 +0200
Message-ID: <20080502103205.GA15651@www.tglx.de>
References: <20080414194549.GA1363@www.tglx.de>
	<20080424092605.GC7371@www.tglx.de>
	<200804241126.01158.david-b@pacbell.net>
	<200805011108.38240.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: David Brownell <david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200805011108.38240.david-b-yBeKhBN/0LDR7s880joybQ@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

* David Brownell | 2008-05-01 11:08:38 [-0700]:

>On Thursday 24 April 2008, David Brownell wrote:
>> 
>> > Aha. So you mean that the read function which was spidev_read() while
>> > the controller was available should point to something else once the
>> > controller is gone?
>> 
>> No, I mean that the issue is most likely a spidev bug.
>> 
>
>Does the appended patch resolve the problem you observed?
Nope. The backtrace:

Sending SPI_IOC_[    4.294967] ------------[ cut here ]------------
[    4.294967] Badness at /home/bigeasy/git/linux-2.6-powerpc/kernel/mutex.c:134
[    4.294967] NIP: c025a0f8 LR: c025a0e0 CTR: 00000000
[    4.294967] REGS: df273d60 TRAP: 0700   Not tainted  (2.6.25)
[    4.294967] MSR: 00021000 <ME>  CR: 24000482  XER: 20000000
[    4.294967] TASK = df2c1840[2307] 'spidev_test' THREAD: df272000
[    4.294967] GPR00: 00000000 df273e10 df2c1840 00000001 00000057 00000057 df2491fc c0be2920 
[    4.294967] GPR08: c02e0010 c0390000 00000001 c0360000 00000000 10019ad4 28004422 00000000 
[    4.294967] GPR16: 100e99a8 100d0000 100b0000 100d0000 df2491c0 df06b3c4 100d7b48 df06b230 
[    4.294967] GPR24: de833140 00000001 00000000 80206b00 df2c1840 df273e58 00029000 df06b3c4 
[    4.294967] NIP [c025a0f8] __mutex_lock_slowpath+0x80/0x1f4
[    4.294967] LR [c025a0e0] __mutex_lock_slowpath+0x68/0x1f4
[    4.294967] Call Trace:
[    4.294967] [df273e10] [00000001] 0x1 (unreliable)
[    4.294967] [df273e50] [c01b5148] spidev_ioctl+0x4c8/0x6ec
[    4.294967] [df273ec0] [c00861c0] vfs_ioctl+0x88/0xa8
[    4.294967] [df273ee0] [c00865e0] do_vfs_ioctl+0x400/0x444
[    4.294967] [df273f10] [c0086664] sys_ioctl+0x40/0x70
[    4.294967] [df273f40] [c000ded8] ret_from_syscall+0x0/0x3c
[    4.294967] Instruction dump:
[    4.294967] 801f0024 7f80f800 38000000 901f0004 41be0024 4bee6481 2f830000 419e0018 
[    4.294967] 3d20c039 8009871c 2f800000 409e0008 <0fe00000> 3ba10008 7fe3fb78 7fa4eb78 
[    4.294967] Unable to handle kernel paging request for data at address 0x6b6b6b6b

I started my spidev user, removed the module and then I started to write
what results in an ioctl. spidev_ioctl+0x4c8/0x6ec is
drivers/spi/spidev.c:228 and that is the first mutex_lock() in
spidev_message(). However you are touching spidev->spi and this is gone
isn't it?

Regards
Sebastian

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
