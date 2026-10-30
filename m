Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327804;
	b=Ny8SryEYLVkQkFo1X/jIBxzNzGddhYKVApyoHNn1P/0RS+PFvhEn25TS24P5s+cGN3J/
	 tolDNJLYQEfVPVM2sNIS5bcVe0m+MTyb4DkVzaXsoQcylK0RjgaVlEAY5Wg176zqcUHLB
	 ulLwdBSrUyC0yZQVIWeWXZRDwmHX9EUV/2sdDP4x0k3nJkBEoqYw8Zs4nJG2CBFpxT0Wn
	 f5hYMzwInqqiaa7603SFGqpnjvqjjfSXOMFspjw/hBg6ru3+RGbpNyhlMLwkRVaeesfwt
	 0Z6GeCttU+uUwxf8cMPVQo5JTvaTKnh0rWomKMyB+uYLNXe/KTGqa/N0abRMgWXWScw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327804;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:Message-ID:
	 Subject:From:To:Content-Type;
	bh=V/lnB9MH/HLYg6xkfRQbx6bEKxiHrzo85vIOCGxcRf0=;
	b=a4T2RqfAdgo9XLal3u76oCAwAJiQZ4D2HB3wW2U0G/vc60fY+P8+j26UFF3hUBw93R0H
	 CGC+zQ7bMoDHDcE0nrdlVYn7FcSy2DqjtZpdQfVD53c1Mqm9Vxw5LlWh7vGBudZnkmEnU
	 t57KxSuVfjki9hKdV2kKBwnY+yIfpRqAqccJqee9YIU5J+Z6Kb3fydBDbxIjqnZL44OuM
	 5dTnx6CtII7WLqzUX3QZwkADRUVHSX830lcEDgr20YAMrprRpYJ8pRPDbec58aa1J/IWW
	 rBfR/1ybs8WFXrKrVqUMzMIg/2tR2CnnI242h3V09r3NoEgiN0dhSJookUa3RDIGncw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.160.72
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com [209.85.160.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4D7606A31C
	for <linux-spi@vger.kernel.org>; Fri, 30 Oct 2026 02:36:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF4D7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-482966c4f4fso2400688fac.1
        for <linux-spi@vger.kernel.org>; Thu, 29 Oct 2026 19:36:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327803; x=1793932603;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V/lnB9MH/HLYg6xkfRQbx6bEKxiHrzo85vIOCGxcRf0=;
        b=yE6U4coSz3nXPzXFSAde6x5jySUqMGlRLkAnr+SxUUw+ZT7G0sywWzCQ/qp4A8l58w
         XcwfultWugmKmiuMn2ef8ZilTSEiB7LFGH1disfwGr5/aNuAr+kCYP/jdFQGFtlcZ/xd
         xCCu/9hqcAI7S0JSA4+EZjax9On7i316ToM/FvtVKn8k7pIJw2Tmcl8/fnwnw4+B/rtM
         6IMOve+zstSLCDgHEqA79xKjApy+ng3lFyi0xmOUR+tjguYYO+O0qaU+OJWamL5w2Zun
         rV99XFAtuiDy2uw3rBaT1CPDJbd5JpKScGQqe+UtJNZoH47f8QdV3TffMZQKGGvXK5kD
         3yRg==
X-Forwarded-Encrypted: i=1; AKwUvBycGiVh/6DrAwbJ7vR5hFMTpF1kVfMQCw+h7WnjX75V5TwdrHuvgEodyy5SMGtulTQAr5XT+QYvyFw=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtBoghlJztONgkTXkIlSnWUeXQ97pPNb86a3buSZW4LKqDXtdE
	BdVUS6yFhiAIQ3NvAKnGd7a2UEEmMnKnj0cC2f++M7O/pL+YxkA6LIRoSou7dN2TA86W+usHmhf
	VUb16Ws+tyYhDSjBKrTNhZG12YSCoL4kcOAnpg07G7npsBiLF9GmVSrPydDw=
X-Mailing-List: linux-spi@vger.kernel.org
List-Id: <linux-spi.vger.kernel.org>
List-Post: <mailto:linux-spi@vger.kernel.org>
List-Help: <mailto:linux-spi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-spi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-spi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-spi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1687:b0:4f1:5068:b93b with SMTP id
 5614622812f47-563ef93de1cmr2489055b6e.14.1793327802984; Thu, 29 Oct 2026
 19:36:42 -0700 (PDT)
Date: Thu, 29 Oct 2026 19:36:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae402ba.0c1d3ab6.e3d48.006b.GAE@google.com>
Subject: [syzbot] [spi?] [usb?] WARNING in spi_register_controller (2)
From: syzbot <syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com>
To: broonie@kernel.org, linux-kernel@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c339f4010dea Merge tag 'platform-drivers-x86-v7.4-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17d07259580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4a49f7c2815c8df7
dashboard link: https://syzkaller.appspot.com/bug?extid=41172204e7323356ecdb
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1420a1a5580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1271cef1580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c339f401.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2aba9a3fc60c/vmlinux-c339f401.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a3c085a78213/bzImage-c339f401.xz

AI-generated root cause summary:
In spi_controller_id_alloc() (drivers/spi/spi.c), idr_alloc() can return -ENOMEM
when radix tree memory allocation fails under memory pressure or fault
injection. The function inappropriately invokes WARN(id < 0, "couldn't get idr")
on any failure rather than handling expected runtime allocation errors silently.
In production builds without panic_on_warn, execution continues, locks are
properly released, and the error is cleanly propagated and handled by callers
without causing denial of service or memory corruption.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=41172204e7323356ecdb

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+41172204e7323356ecdb@syzkaller.appspotmail.com

R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fe4d0225fac R14: 00007fe4d0225fa0 R15: 00007fe4d0225fa0
 </TASK>
------------[ cut here ]------------
couldn't get idr
WARNING: drivers/spi/spi.c:3634 at spi_controller_id_alloc drivers/spi/spi.c:3634 [inline], CPU#0: syz.0.17/5588
WARNING: drivers/spi/spi.c:3634 at spi_register_controller+0x1261/0x1670 drivers/spi/spi.c:3697, CPU#0: syz.0.17/5588
Modules linked in:
CPU: 0 UID: 0 PID: 5588 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:spi_controller_id_alloc drivers/spi/spi.c:3634 [inline]
RIP: 0010:spi_register_controller+0x1261/0x1670 drivers/spi/spi.c:3697
Code: 8c e8 33 d5 79 fa e9 1e ff ff ff e8 a9 a6 16 fb 48 8d 3d 72 3f 18 0b 67 48 0f b9 3a eb 11 e8 96 a6 16 fb 48 8d 3d 6f 3f 18 0b <67> 48 0f b9 3a bf e4 ff ff ff 44 89 f6 e8 8d ab 16 fb 41 83 fe e4
RSP: 0018:ffffc90004de7878 EFLAGS: 00010293
RAX: ffffffff86b27e5a RBX: ffff888050e4a000 RCX: ffff888034fc4b00
RDX: 0000000000000000 RSI: 00000000fffffff4 RDI: ffffffff91cabdd0
RBP: 0000000000000000 R08: ffffc90004de7807 R09: 1ffff920009bcf00
R10: dffffc0000000000 R11: fffff520009bcf01 R12: 1ffff1100a1c9408
R13: dffffc0000000000 R14: 00000000fffffff4 R15: ffff888050e4a4d8
FS:  000055558743d500(0000) GS:ffff88808aa10000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbfc3e0ca90 CR3: 0000000040ab8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 msi2500_probe+0x4c6/0x9e0 drivers/media/usb/msi2500/msi2500.c:1249
 usb_probe_interface+0x751/0xe00 drivers/usb/core/driver.c:399
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x254/0xae0 drivers/base/dd.c:707
 __driver_probe_device+0x1e8/0x360 drivers/base/dd.c:869
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:899
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1027
 bus_for_each_drv+0x258/0x2f0 drivers/base/bus.c:503
 __device_attach+0x2bd/0x430 drivers/base/dd.c:1131
 proc_ioctl+0x409/0x660 drivers/usb/core/devio.c:2370
 proc_ioctl_default+0xc4/0x110 drivers/usb/core/devio.c:2405
 usbdev_do_ioctl drivers/usb/core/devio.c:2769 [inline]
 usbdev_ioctl+0x139d/0x21a0 drivers/usb/core/devio.c:2829
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe4cff9f559
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc6b706298 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe4d0225fa0 RCX: 00007fe4cff9f559
RDX: 0000200000000900 RSI: 00000000c0105512 RDI: 0000000000000004
RBP: 00007ffc6b706300 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000002
R13: 00007fe4d0225fac R14: 00007fe4d0225fa0 R15: 00007fe4d0225fa0
 </TASK>
----------------
Code disassembly (best guess):
   0:	8c e8                	mov    %gs,%eax
   2:	33 d5                	xor    %ebp,%edx
   4:	79 fa                	jns    0x0
   6:	e9 1e ff ff ff       	jmp    0xffffff29
   b:	e8 a9 a6 16 fb       	call   0xfb16a6b9
  10:	48 8d 3d 72 3f 18 0b 	lea    0xb183f72(%rip),%rdi        # 0xb183f89
  17:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  1c:	eb 11                	jmp    0x2f
  1e:	e8 96 a6 16 fb       	call   0xfb16a6b9
  23:	48 8d 3d 6f 3f 18 0b 	lea    0xb183f6f(%rip),%rdi        # 0xb183f99
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	bf e4 ff ff ff       	mov    $0xffffffe4,%edi
  34:	44 89 f6             	mov    %r14d,%esi
  37:	e8 8d ab 16 fb       	call   0xfb16abc9
  3c:	41 83 fe e4          	cmp    $0xffffffe4,%r14d


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
