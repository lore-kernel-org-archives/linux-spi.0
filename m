From: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Subject: Re: could not mount a spi-flash on rootfs
Date: Mon, 30 Jun 2014 09:21:58 +0200
Message-ID: <CAMuHMdXnLG==TmZCLd=tZ0C1PPurjWkbE=ysCFCOgVK+5UCJnw@mail.gmail.com>
References: <53AA941D.3000808@jinso.co.jp>
	<CAMuHMdWBf1+A9=8b1x+e0YcV3d=K_tBvqUeBXxvoHFy=QHcJxQ@mail.gmail.com>
	<53B0CB84.6030001@jinso.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>,
	"Shimoda, Yoshihiro" <yoshihiro.shimoda.uh-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
To: Cao Minh Hiep <cm-hiep-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <53B0CB84.6030001-HEF513clHfp3+QwDJ9on6Q@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-ID: <linux-spi.vger.kernel.org>

Hi Hiep-san,

On Mon, Jun 30, 2014 at 4:29 AM, =E3=82=AB=E3=82=AA=E3=80=80=E3=83=9F=E3=
=83=B3=E3=80=80=E3=83=92=E3=82=A7=E3=83=83=E3=83=97 <cm-hiep-HEF513clHfrHNBrmcpmgbg@public.gmane.org=
p> wrote:
>>> "EXT3-fs (mtdblock2): error: can't find ext3 filesystem on dev mtdb=
lock2.
>>> EXT2-fs (mtdblock2): error: can't find an ext2 filesystem on dev
>>> mtdblock2.
>>> EXT4-fs (mtdblock2): VFS: Can't find ext4 filesystem
>>> FAT-fs (mtdblock2): bogus number of reserved sectors
>>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>>> FAT-fs (mtdblock2): bogus number of reserved sectors
>>> FAT-fs (mtdblock2): Can't find a valid FAT filesystem
>>> mount: you must specify the filesystem type"
>>> root@linaro-nano:~# mount /dev/mtdblock2 /mnt/
>>
>> Does it make a difference if you explicitly specify the file system =
type,
>> by adding "-t ext3"?
>
> I have tried to specify the system type by adding "-t ext3" or "-t ex=
t4",
> but it has no change anything.
> I attached the qspi test logs file. Please see it.

"renesas_spi qspi.0: master is unqueued, this is deprecated"

So this is indeed a very old version of the rspi driver.
Which 3.10.31-ltsi are you using? The one from renesas-backports?

>>> I have enabled ext2,3,4 file systems when configuring the kernel.
>>> and I saw that the qspi driver code is same with upstream version c=
ode
>>> that
>>> be good.
>>> maybe the problem related to mtd (m25p80.c) (?)
>>> I attach the logs files when making a spi-flash partition and mount=
 it on
>>> rootfs.
>>
>> It looks like the file system wasn't written correctly to the device=
=2E
>> Do you see anything suspicious in the kernel log (dmesg)?
>
> No, I don't see anything suspicious in the kernel log. It is normally=
 log
> for qspi.

Strange.

Can you check that writing works using some other way, e.g. using dd?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-=
m68k.org

In personal conversations with technical people, I call myself a hacker=
=2E But
when I'm talking to journalists I just say "programmer" or something li=
ke that.
                                -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
