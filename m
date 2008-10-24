From: Vernon Sauder <vernoninhand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Limitations on transfer length [was:
	pxa2xx_spi with SFRM]
Date: Fri, 24 Oct 2008 01:11:04 -0400
Message-ID: <490158E8.8060502@gmail.com>
References: <1218182539.489bfd8b24a3d@webmail.whoi.edu>
	<489C1B23.6040804@cam.ac.uk> <48A0C35D.5010606@gmail.com>
	<48A44F77.1020908@whoi.edu> <48A4ED85.1030803@gmail.com>
	<48A5D272.1070804@whoi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Ned Forrester <nforrester-/d+BM93fTQY@public.gmane.org>
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <48A5D272.1070804-/d+BM93fTQY@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-spi.vger.kernel.org

Ned Forrester wrote:
> Vernon Sauder wrote:
>> Ned Forrester wrote:
> 
>> On a side note, there is an MTD error when using the SPI Flash with the 
>> pxa2xx_spi driver.
>>
>> root@inhand-ft4 [~] # flash_erase /dev/mtd_spi
>> Erase Total 1 Units
>> Performing Flash Erase of length 65536 at offset 0x0 done # <- why *64K* ??
>> root@inhand-ft4 [~] # echo -n hithere123 > /dev/mtd_spi
>> root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
>> 00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
>> |hithere123......|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
>> |................|
>> *
>> 00000200
>> root@inhand-ft4 [~] # echo -n hithere444xxx > /dev/mtdblock_spi
>> [  231.370000] pxa2xx-spi pxa2xx-spi.1: pump_transfers: transfer length 
>> greater than 8191
> 
> This message is issued by pxa2xx_spi.c in pump_transfers() if the
> transfer length is illegal.  You may have uncovered a bug here.  I think
> the 8191 limitation on transfer length only applies to DMA, as that is
> the length of the DMA counter.  The test for this should probably be
> performed only if DMA is in use.  I don't think Stephen or I ever
> expected any transfer to approach that length, in either PIO or DMA
> mode.  Is this really a legitimate transfer request?  Something that can
> only work in PIO mode and not in DMA mode?  That seems improper to me.
> 
>>  # maybe 64K??
>> [  231.380000] end_request: I/O error, dev mtdblock_spi, sector 0
>> [  231.380000] Buffer I/O error on device mtdblock_spi, logical block 0
>> [  231.380000] lost page write due to I/O error on mtdblock_spi
>> root@inhand-ft4 [~] # hexdump -C -n512 /dev/mtdblock_spi
>> 00000000  68 69 74 68 65 72 65 31  32 33 ff ff ff ff ff ff  
>> |hithere123......|
>> 00000010  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  
>> |................|
>> *
>> 00000200
>>
>> I have not done a great deal of testing with MTD yet but I can read and 
>> write a small test file. I was hoping to use the mtdblock interface for 
>> this application. I will take a little time and see if I can figure out 
>> what part is wrong here.
>>
>>
>> Thanks again for your help.
>> Vern
> 

Ned,

I finally had some time to test this again. For refreshing, this is
testing an m25p80 MTD device on the PXA270 SPI bus.

Good news and Bad news. Good  news is that the error is gone with your
patch on 2.6.24.4. Bad news is that it there are still cases where the
kernel crashes or locks up using 2.6.27-rc8.

One time, this much of an error message got out before the kernel
completely locked up:

root@inhand-ft4 [~] # cat /tmp/k > /dev/mtd_spi
cat: Write Error: Bad address
[  151.497694] ------------[ cut here ]------------
[  151.503356] WARNING: at kernel/mutex.c:135
__mutex_lock_slowpath+0x9c/0x200()
[  151.510452] Modules linked in: spidev

And here is another dump that appeared after multiple writes: (Notice
first the failed writes. I don't know what is causing that. The HW setup
is slightly different.)

root@inhand-ft4 [~] # echo 1234567890 > /dev/mtd_spi
root@inhand-ft4 [~] # hexdump -C -n65536 /dev/mtd_spi
00000000  31 32 33 34 30 00 00 00  00 00 00 00 00 00 00 00
|12340...........|
00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
|................|
*
00001000  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff
|................|
*
00010000
root@inhand-ft4 [~] # echo 1234567890 > /dev/mtd_spi
[  332.052355] slab error in verify_redzone_free(): cache `size-32':
memory outside object was overw
ritten
[  332.061741] [<c014c84c>] (dump_stack+0x0/0x14) from [<c01b1ad0>]
(__slab_error+0x28/0x30)
[  332.069951] [<c01b1aa8>] (__slab_error+0x0/0x30) from [<c01b2770>]
(cache_free_debugcheck+0x194/0
x2c8)
[  332.079236] [<c01b25dc>] (cache_free_debugcheck+0x0/0x2c8) from
[<c01b3120>] (kfree+0x94/0x114)
[  332.087911] [<c01b308c>] (kfree+0x0/0x114) from [<c02c9c00>]
(mtd_write+0x11c/0x240)
[  332.095652]  r8:07932c80 r7:386e438b r6:c71d2000 r5:c71ecee0 r4:00020000
[  332.102342] [<c02c9ae4>] (mtd_write+0x0/0x240) from [<c01b7aa8>]
(vfs_write+0xb8/0x144)
[  332.110337] [<c01b79f0>] (vfs_write+0x0/0x144) from [<c01b80e0>]
(sys_write+0x4c/0x80)
[  332.118237]  r7:00000004 r6:00000000 r5:00000000 r4:c782e4f4
[  332.123888] [<c01b8094>] (sys_write+0x0/0x80) from [<c0148d20>]
(ret_fast_syscall+0x0/0x2c)
[  332.132221]  r6:40147194 r5:40017000 r4:0000000b
[  332.136834] c71eced8: redzone 1:0xd84156c5635688c0, redzone 2:0x0.
root@inhand-ft4 [~] #
root@inhand-ft4 [~] # [  334.229714] Unable to handle kernel NULL
pointer dereference at virtual add
ress 00000000
[  334.237798] pgd = c0004000
[  334.240485] [00000000] *pgd=00000000
[  334.244053] Internal error: Oops: 17 [#1] PREEMPT
[  334.248730] Modules linked in: spidev pxa2xx_spi m25p80 hci_uart
bluetooth ohci_hcd sd_mod usb_st
orage libusual usbcore orinoco_cs orinoco hermes snd_pxa2xx_ac97
snd_ac97_codec snd_pxa2xx_pcm rtc_s
a1100 mmc_block pxamci mmc_core ft4_batt
[  334.269794] CPU: 0    Not tainted  (2.6.27-rc8 #7)
[  334.274610] PC is at list_del+0x14/0x9c
[  334.278444] LR is at free_block+0x88/0x1cc
[  334.282519] pc : [<c02704e4>]    lr : [<c01b2d1c>]    psr: 00000093
[  334.282533] sp : c7827ef0  ip : c7827f08  fp : c7827f04
[  334.293937] r10: c7809840  r9 : c7954000  r8 : c78043d0
[  334.299134] r7 : c71ecf14  r6 : 00000000  r5 : c7805c2c  r4 : c7805c2c
[  334.305629] r3 : 00000000  r2 : c198ba80  r1 : c7805c2c  r0 : c71ecf14
[  334.312120] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA ARM
Segment kernel
[  334.319475] Control: 0000397f  Table: a7950000  DAC: 00000017
[  334.325185] Process events/0 (pid: 5, stack limit = 0xc7826268)
[  334.331070] Stack: (0xc7827ef0 to 0xc7828000)
[  334.335399] 7ee0:                                     00000008
c7805c2c c7827f40 c7827f08
[  334.343678] 7f00: c01b2d1c c02704dc 00000000 00000001 c7805c2c
00000000 c7805c2c 00000001
[  334.351957] 7f20: c7805c1c c7809840 c01b33dc 00000000 00000000
c7827f60 c7827f44 c01b2f10
[  334.360237] 7f40: c01b2ca0 c78043d0 c7809840 00000000 c0481494
c7827f84 c7827f64 c01b3434
[  334.368516] 7f60: c01b2e6c 00000000 c0481498 c78012b0 c0481494
c7826000 c7827fa8 c7827f88
[  334.376796] 7f80: c01777c0 c01b33e8 c7827fb8 c78012b0 c7826000
00000000 00000000 c7827fd8
[  334.385074] 7fa0: c7827fac c0177ab4 c01776ec 00000000 c781dc00
c017b7bc c7827fb8 c7827fb8
[  334.393355] 7fc0: c7826000 c78012b0 c01779cc c7827ff4 c7827fdc
c017b784 c01779d8 00000000
[  334.401633] 7fe0: 00000000 00000000 00000000 c7827ff8 c0168360
c017b738 11d97d47 a5f725a5
[  334.409913] Backtrace:
[  334.412354] [<c02704d0>] (list_del+0x0/0x9c) from [<c01b2d1c>]
(free_block+0x88/0x1cc)
[  334.420256]  r4:c7805c2c
[  334.422775] [<c01b2c94>] (free_block+0x0/0x1cc) from [<c01b2f10>]
(drain_array+0xb0/0xfc)
[  334.430936] [<c01b2e60>] (drain_array+0x0/0xfc) from [<c01b3434>]
(cache_reap+0x58/0x134)
[  334.439095]  r7:c0481494 r6:00000000 r5:c7809840 r4:c78043d0
[  334.444745] [<c01b33dc>] (cache_reap+0x0/0x134) from [<c01777c0>]
(run_workqueue+0xe0/0x1ac)
[  334.453189]  r7:c7826000 r6:c0481494 r5:c78012b0 r4:c0481498
[  334.458840] [<c01776e0>] (run_workqueue+0x0/0x1ac) from [<c0177ab4>]
(worker_thread+0xe8/0xfc)
[  334.467429]  r8:00000000 r7:00000000 r6:c7826000 r5:c78012b0 r4:c7827fb8
[  334.474123] [<c01779cc>] (worker_thread+0x0/0xfc) from [<c017b784>]
(kthread+0x58/0x90)
[  334.482111]  r6:c01779cc r5:c78012b0 r4:c7826000
[  334.486719] [<c017b72c>] (kthread+0x0/0x90) from [<c0168360>]
(do_exit+0x0/0x794)
[  334.494198]  r6:00000000 r5:00000000 r4:00000000
[  334.498807] Code: e92dd810 e24cb004 e24dd004 e5903004 (e593c000)
[  334.505751] ---[ end trace 3637d999aba17a07 ]---
[  334.510408] note: events/0[5] exited with preempt_count 1


I wanted to send this so you know. There is the possibility that the
2.6.27 I am using is not completely configured and/or patched. It was
based on Linus' git tree but I have not completed testing all my board
patches. This feature is not being requested any longer so I don't have
a lot of pressure to fix it right now. As I get closer to finishing the
project, I might need to resolve this.

-- 
Regards,
 Vernon Sauder :)


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
