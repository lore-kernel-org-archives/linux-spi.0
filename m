From: William Bourque <wfb-q1Y+AKCHEmHQT0dZR+AlfA@public.gmane.org>
Subject: Re: SPI: Integer overflow cause timeout to be too small
Date: Mon, 25 Apr 2016 18:19:55 -0400
Message-ID: <571E980B.5020700@xiphos.com>
References: <57169C1B.7010100@xiphos.com>
 <CAFcVECKhL_c53Rco_Qht7fNS_jozr_a5xG2Yfy-y38b5sfjYxA@mail.gmail.com>
 <CAGub7DGotZ6mpVbRmxvK7ZfU748FyFE58Zr=u=yjc-Vez-m-5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Harini Katakam <harinikatakamlinux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
To: sai krishna <saikrishna12468-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org,
	linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAGub7DGotZ6mpVbRmxvK7ZfU748FyFE58Zr=u=yjc-Vez-m-5g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

On 20/04/16 06:58 AM, sai krishna wrote:
>> Hi
>>
>> I bumped into a strange issue in the SPI driver that might be a bug.
>>
>> We are developing hardware based on Xilinx Zynq; as storage we uses an
>> N25Q512A NOR Flash over Xilinx Zynq Quad Spi driver.
>> The Quad SPI driver is _not_ in the upstream kernel but the
>> overflowing integer that is the root cause of the issue is (see
>> below).
>>
>> As such, the bug may or may not be related to upstream kernel code. I
>> tracked it down and found a fix but I am unsure if the whole issue
>> isn't just something the calling driver is doing wrong.
>>
>> The QSPI driver code can be found at:
>> https://github.com/Xilinx/linux-xlnx/blob/master/drivers/spi/spi-zynq-qspi.c
>>
>> Recently, we noticed we can crash the SPI driver simply by using dd
>> with an overly large block size.
>> Something like:
>> [root@test-spi ~]# dd if=/dev/mtd13 bs=4000000 count=1 | md5sum
>> m25p80 spi0.0: SPI transfer timed out
>> m25p80 spi0.0: flash operation timed out
>> m25p80 spi0.0: flash operation timed out
>> dd: /dev/mtd13: Connection timed out
>>
>> At this point the QSPI is effectively dead, any access to the
>> filesystem result in endless timeout. The system needs a reboot to
>> recover.
>>
>> [root@test-spi ~]# ls /etc
>> m25p80 spi0.0: flash operation timed out
>> m25p80 spi0.0: flash operation timed out
>> ubi0 warning: ubi_io_read: error -110 while reading 60 bytes from PEB
>> 167:54048, read only 0 bytes, retry
>> m25p80 spi0.0: flash operation timed out
>> ...
>>
>> By poking around, I found that the issue is caused by this line (ref:
>> http://lxr.free-electrons.com/source/drivers/spi/spi.c#L972 ):
>> ms = xfer->len * 8 * 1000 / xfer->speed_hz;
>>
>> ms is an unsigned long.
>> In the case shown above, "xfer->len" is 4,000,000 and xfer->speed_hz
>> is 62,499,599 (65MHz).
>> So here 4,000,000 * 8 * 1000 = 32,000,000,000. It overflows the uint32
>> so the end result ends up being 1,935,228,928.
>> After being divided by xfer->speed_hz, ms is roughtly equal to
>> 30.96ms, which is way too small for a transfer of this size.
>>
>> When a timeout occurs, the transfer is stopped; this leave the QSPI in
>> an incoherent state from which it never recover (this seem weird to
>> me?).
>>
>> I was able to workaround the issue by doing the math the other way,
>> i.e. by dividing the frequency instead of mutiplying the length.
>> Since the frequency of SPI should always be in the MHz, it seems safe
>> enough (although division IS slower on some platform).
>> The fix looks like this:
>> /* Use max() to avoid division by zero for very small frequency */
>> ms = xfer->len / max((unsigned long)1, (unsigned long)xfer->speed_hz /
>> 8 / 1000);
>>
>>
>> Now, as I said, the bug may not lie in spi.c; the culprit may be
>> Xilinx QSPI driver. Maybe it shouldn't have passed such a large length
>> down to spi.c?
>> I don't know enough of the SPI architecture to know what's good
>> practice and what's not.
>>
>> This lead me to the following questions:
>> 1- Is this an actual bug and if so, is the likely culprit spi.c or
>> spi-zynq-qspi.c?
>> 2- Should such large transfer length be handled in calling
>> spi-zynq-qspi.c or down in spi.c?
>> 3- Is it normal for the SPI to die after such timeout? Shouldn't the
>> SPI/QSPI driver be expected to recover from it?
> Transfer length is passed from the MTD layer to the spi core which passes
> it to the driver. Transfer size is broken down by the upper layers/filesystem.
Ok.
What you are saying is that the length is passed FROM the spi core TO 
the driver, not the reverse way around like I described. It seems I got 
it backward.
Correct me if I am wrong but that would mean that the integer overflow I 
described is a bug in the spi core since the overflows occurs before any 
driver/filesystem is involved.

Is the fix described (dividing frequency instead of multiplying length) 
seems acceptable?

Thanks,

- William

> Regards
> Sai Krishna
>>
>> Thanks,
>>
>> - William Bourque
>> Embedded Software Developer,
>> Xiphos Technologies
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-spi" in
>> the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
